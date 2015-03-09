//
//  ListaExamesTableViewController.m
//  Projeto Final
//
//  Created by Leonardo Felipe da Silva on 17/10/14.
//  Copyright (c) 2014 Mack Mobile - BEPiD. All rights reserved.
//

#import "ListaExamesTableViewController.h"
#import "ExameViewController.h"
#import "PessoaManager.h"
#import "MostrarExameViewController.h"

@interface ListaExamesTableViewController ()

@end

@implementation ListaExamesTableViewController

@synthesize exame, exames, nome, Data, dataLabel;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    ExameManager *manager = [ExameManager sharedInstance];
    exames = [manager obterExames];
    
    [self setTitle:@"Exames"];
    
    UIBarButtonItem *barButtonAdd = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(adicionar:)];
    [[self navigationItem] setRightBarButtonItem:barButtonAdd];
    
    //background
    [self.view setBackgroundColor:[UIColor colorWithRed:220/100.0f green:200/100.0f blue:238/20.0f alpha:0.6]];
    
    //adicionando as notificações para atualizar a tableView
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tableViewReloadData:) name:@"atualizarTableView" object:nil];
}

- (void)viewDidAppear:(BOOL)animated
{
    //Botão de Adicionar
    UIBarButtonItem *barButtonAdd = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(adicionar:)];
    
    [[[self tabBarController] navigationItem] setRightBarButtonItem:barButtonAdd];
    //    [[self navigationItem] setRightBarButtonItem:barButtonAdd];

    [self setTitle: @"Exames"];
    
}

- (void)viewDidDisappear:(BOOL)animated {
    [[[self tabBarController] navigationItem] setRightBarButtonItem:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return exames.count;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *reuseIdentifier = @"CelulaVacina";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:nil];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    }
    
    
    // Configure the cell...
    
    
    Exame *exame1 = [exames objectAtIndex:indexPath.row];
    
    PessoaManager *managerPessoa = [PessoaManager sharedInstance];
    
//    UIView *imagemtest = [managerPessoa criarViewCorBolinhaDaPessoa:exame1.pessoa naPosicao:CGPointMake(270, 10)];
    
    UIImage *imagem = [UIImage imageNamed:@"exame_me"];
    
    UIImageView *viewImagem = [[UIImageView alloc] init];
    [viewImagem setFrame:CGRectMake(10, 10, 60, 60)];
    [viewImagem setBackgroundColor:self.navigationController.navigationBar.barTintColor];
    viewImagem.layer.cornerRadius = viewImagem.frame.size.width/2;
    viewImagem.layer.borderWidth = 3.0f;
    viewImagem.layer.borderColor = ((UIColor*)exame1.pessoa.cor).CGColor;
    UIImageView *viewImagemReduzida = [[UIImageView alloc] init];
    [viewImagemReduzida setFrame:CGRectMake(viewImagem.frame.size.width/4, viewImagem.frame.size.height/4, viewImagem.frame.size.width/2, viewImagem.frame.size.height/2)];
    [viewImagemReduzida setImage:imagem];
    [viewImagem addSubview:viewImagemReduzida];
    
    [[cell contentView] addSubview:viewImagem];
    
    nome = [[UILabel alloc]init];
    nome.frame = CGRectMake(cell.frame.origin.x+viewImagem.frame.size.width + 20, cell.frame.origin.y+(cell.frame.size.height / 3), cell.frame.size.width - viewImagem.frame.size.width, cell.frame.size.height/3);
    [nome setText:exame1.titulo];
    
    Data = [[UILabel alloc]init];
    Data.frame = CGRectMake(cell.frame.origin.x+viewImagem.frame.size.width + 20, nome.frame.size.height + cell.frame.size.height/(cell.frame.size.height / 30), cell.frame.size.width - viewImagem.frame.size.width, cell.frame.size.height/3);
    
    if (exame1.data == nil) {
        Data.text = @"--/--/----";
    }else{
    NSDateFormatter *dateFormatter;
    dateFormatter = [MMNSDateFormater criarDateFormatter];
    
    dataLabel = [NSString stringWithFormat:@"%@",
            [dateFormatter stringFromDate:exame1.data]];
    [Data setText:dataLabel];
    }
    [[cell contentView] addSubview:nome];
    [[cell contentView] addSubview:Data];
    
    [[cell textLabel] setBackgroundColor:[UIColor clearColor]];
    
//    [[cell textLabel] setText:];
    
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    
    
    
    
    
    return cell;
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        Exame *exame1 = [exames objectAtIndex:indexPath.row];
        
        ExameManager *manager = [ExameManager sharedInstance];
        
        [manager deletarExame:exame1];
        
        [manager saveContext];
        
        [self atualizarItensHistorico];
        
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
}

- (void)atualizarItensHistorico
{
    ExameManager *manager = [ExameManager sharedInstance];
    exames = [manager obterExames];
}
- (CGFloat)tableView: (UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80.0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MostrarExameViewController *viewController = [[MostrarExameViewController alloc] init];
    Exame *exame1 = [exames objectAtIndex:indexPath.row];
    viewController.exame = exame1;
    
    [[self navigationController] pushViewController:viewController animated:YES];
}

#pragma mark - Selectors dos botões da navigationBar

- (void)adicionar:(id)sender
{
    ExameViewController *viewController = [[ExameViewController alloc] init];
    UINavigationController *navigation = [[UINavigationController alloc]initWithRootViewController:viewController];
    [[self navigationController] presentViewController:navigation animated:YES completion:nil];
}

#pragma mark - Métodos do NotificationCenter para atualizar tableView

- (void)tableViewReloadData:(NSNotification *)notification {
    ExameManager *manager = [ExameManager sharedInstance];
    exames = [manager obterExames];
    
    [self.tableView reloadData];
}
/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
