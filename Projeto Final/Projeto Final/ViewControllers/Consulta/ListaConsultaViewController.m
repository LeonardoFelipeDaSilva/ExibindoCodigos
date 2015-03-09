//
//  ListaConsultaViewController.m
//  Projeto Final
//
//  Created by Leonardo Felipe da Silva on 12/7/14.
//  Copyright (c) 2014 Mack Mobile - BEPiD. All rights reserved.
//

#import "ListaConsultaViewController.h"
#import "ConsultaViewController.h"
#import "PessoaManager.h"
#import "MostrarConsultaViewController.h"


@interface ListaConsultaViewController ()

@end

@implementation ListaConsultaViewController

@synthesize consulta, consultas, nome, Data, dataLabel;

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
    
    ConsultaManager *manager = [ConsultaManager sharedInstance];
    consultas = [manager obterConsultas];
    
    [self setTitle:@"Consultas"];
    
    UIBarButtonItem *barButtonAdd = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(adicionar:)];
    [[self navigationItem] setRightBarButtonItem:barButtonAdd];
    
    //background
    [self.view setBackgroundColor:[UIColor colorWithRed:220/100.0f green:200/100.0f blue:238/20.0f alpha:0.6]];
    
    //adicionando as notificações para atualizar a tableView
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tableViewReloadData:) name:@"atualizarTableViewReloadData" object:nil];
}

- (void)viewDidAppear:(BOOL)animated
{
    //Botão de Adicionar
    UIBarButtonItem *barButtonAdd = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(adicionar:)];
    
    [[[self tabBarController] navigationItem] setRightBarButtonItem:barButtonAdd];
    //    [[self navigationItem] setRightBarButtonItem:barButtonAdd];
    
    [self setTitle: @"Consultas"];
    
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
    return consultas.count;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *reuseIdentifier = @"CelulaVacina";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:nil];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    }
    
    
    // Configure the cell...
    
    
    Consulta *consulta1 = [consultas objectAtIndex:indexPath.row];
    
    PessoaManager *managerPessoa = [PessoaManager sharedInstance];
    
    //    UIView *imagemtest = [managerPessoa criarViewCorBolinhaDaPessoa:exame1.pessoa naPosicao:CGPointMake(270, 10)];
    
    UIImage *imagem = [UIImage imageNamed:@"consulta_me"];
    
    UIImageView *viewImagem = [[UIImageView alloc] init];
    [viewImagem setFrame:CGRectMake(10, 10, 60, 60)];
    [viewImagem setBackgroundColor:self.navigationController.navigationBar.barTintColor];
    viewImagem.layer.cornerRadius = viewImagem.frame.size.width/2;
    viewImagem.layer.borderWidth = 3.0f;
    viewImagem.layer.borderColor = ((UIColor*)consulta1.pessoa.cor).CGColor;
    UIImageView *viewImagemReduzida = [[UIImageView alloc] init];
    [viewImagemReduzida setFrame:CGRectMake(viewImagem.frame.size.width/4, viewImagem.frame.size.height/4, viewImagem.frame.size.width/2, viewImagem.frame.size.height/2)];
    [viewImagemReduzida setImage:imagem];
    [viewImagem addSubview:viewImagemReduzida];
    
    [[cell contentView] addSubview:viewImagem];
    
    nome = [[UILabel alloc]init];
    nome.frame = CGRectMake(cell.frame.origin.x+viewImagem.frame.size.width + 20, cell.frame.origin.y+(cell.frame.size.height / 3), cell.frame.size.width - viewImagem.frame.size.width, cell.frame.size.height/3);
    [nome setText:consulta1.titulo];
    
    Data = [[UILabel alloc]init];
    Data.frame = CGRectMake(cell.frame.origin.x+viewImagem.frame.size.width + 20, nome.frame.size.height + cell.frame.size.height/(cell.frame.size.height / 30), cell.frame.size.width - viewImagem.frame.size.width, cell.frame.size.height/3);
    
    if (consulta1.data == nil) {
        Data.text = @"--/--/----";
    }else{
        NSDateFormatter *dateFormatter;
        dateFormatter = [MMNSDateFormater criarDateFormatter];
        
        dataLabel = [NSString stringWithFormat:@"%@",
                     [dateFormatter stringFromDate:consulta1.data]];
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
        Consulta *consulta1 = [consultas objectAtIndex:indexPath.row];
        
        ConsultaManager *manager = [ConsultaManager sharedInstance];
        
        [manager deletarConsulta:consulta1];
        
        [manager saveContext];
        
        [self atualizarItensHistorico];
        
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
}

- (void)atualizarItensHistorico
{
    ConsultaManager *manager = [ConsultaManager sharedInstance];
    consultas = [manager obterConsultas];
}

- (CGFloat)tableView: (UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80.0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MostrarConsultaViewController *viewController = [[MostrarConsultaViewController alloc] init];
    Consulta *consulta1 = [consultas objectAtIndex:indexPath.row];
    viewController.consulta = consulta1;
    
    [[self navigationController] pushViewController:viewController animated:YES];
}

#pragma mark - Selectors dos botões da navigationBar

- (void)adicionar:(id)sender
{
    ConsultaViewController *viewController = [[ConsultaViewController alloc] init];
    UINavigationController *navigation = [[UINavigationController alloc]initWithRootViewController:viewController];
    [[self navigationController] presentViewController:navigation animated:YES completion:nil];
}

#pragma mark - Métodos do NotificationCenter para atualizar tableView

- (void)tableViewReloadData:(NSNotification *)notification {
    ConsultaManager *manager = [ConsultaManager sharedInstance];
    consultas = [manager obterConsultas];
    
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
