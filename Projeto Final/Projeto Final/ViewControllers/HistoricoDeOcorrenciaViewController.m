//
//  HistoricoDeOcorrenciaViewController.m
//  Projeto Final
//
//  Created by Leonardo Felipe da Silva on 01/10/14.
//  Copyright (c) 2014 Mack Mobile - BEPiD. All rights reserved.
//

#import "HistoricoDeOcorrenciaViewController.h"
#import "OcorrenciaViewController.h"
#import "PessoaManager.h"
#import "MostrarOcorrenciaViewController.h"

@interface HistoricoDeOcorrenciaViewController ()

@end

@implementation HistoricoDeOcorrenciaViewController
@synthesize ocorrencia, nome, Data, dataLabel;
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
    
    [self setTitle:@"Ocorrências"];
    
    
    //Botão de Adicionar
    UIBarButtonItem *barButtonAdd = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(adicionar:)];
    [[self navigationItem] setRightBarButtonItem:barButtonAdd];
    
    OcorrenciaManager *manager = [OcorrenciaManager sharedInstance];
    
    ocorrencias = [manager obterOcorrencias];
    
    //background
    [self.view setBackgroundColor:[UIColor colorWithRed:220/100.0f green:200/100.0f blue:238/20.0f alpha:0.6]];
    
    //adicionando as notificações para atualizar a tableView
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tableViewReloadData:) name:@"atualizarTableView" object:nil];
    
}

-(void)viewDidAppear:(BOOL)animated
{
    [self setTitle: @"Ocorrências"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return ocorrencias.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *reuseIdentifier = @"CelulaPerfil";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:nil];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    }
    
    // Configure the cell...
    
    
    OcorrenciaDoenca *ocorrencia1 = [ocorrencias objectAtIndex:indexPath.row];
   
//    PessoaManager *managerPessoa = [PessoaManager sharedInstance];
    
    UIImage *imagem = [UIImage imageNamed:@"ocorrencia_me"];
    
    UIImageView *viewImagem = [[UIImageView alloc] init];
    [viewImagem setFrame:CGRectMake(10, 10, 60, 60)];
    [viewImagem setBackgroundColor:self.navigationController.navigationBar.barTintColor];
    viewImagem.layer.cornerRadius = viewImagem.frame.size.width/2;
    viewImagem.layer.borderWidth = 3.0f;
    viewImagem.layer.borderColor = ((UIColor*)ocorrencia1.pessoa.cor).CGColor;
    UIImageView *viewImagemReduzida = [[UIImageView alloc] init];
    [viewImagemReduzida setFrame:CGRectMake(viewImagem.frame.size.width/4, viewImagem.frame.size.height/4, viewImagem.frame.size.width/2, viewImagem.frame.size.height/2)];
    [viewImagemReduzida setImage:imagem];
    [viewImagem addSubview:viewImagemReduzida];
    
    [[cell contentView] addSubview:viewImagem];
    
    nome = [[UILabel alloc]init];
    nome.frame = CGRectMake(cell.frame.origin.x+viewImagem.frame.size.width + 20, cell.frame.origin.y+(cell.frame.size.height / 3), cell.frame.size.width - viewImagem.frame.size.width, cell.frame.size.height/3);
    [nome setText:ocorrencia1.titulo];
    
    Data = [[UILabel alloc]init];
    Data.frame = CGRectMake(cell.frame.origin.x+viewImagem.frame.size.width + 20, nome.frame.size.height + cell.frame.size.height/(cell.frame.size.height / 30), cell.frame.size.width - viewImagem.frame.size.width, cell.frame.size.height/3);
    //    [Data setText:exame.da];
    if (ocorrencia1.data == nil) {
        Data.text = @"--/--/----";
    }else{
        NSDateFormatter *dateFormatter;
        dateFormatter = [MMNSDateFormater criarDateFormatter];
        
        dataLabel = [NSString stringWithFormat:@"%@",
                     [dateFormatter stringFromDate:ocorrencia1.data]];
        [Data setText:dataLabel];
    }
    [[cell contentView] addSubview:nome];
    [[cell contentView] addSubview:Data];
    
    [[cell textLabel] setBackgroundColor:[UIColor clearColor]];
    
    [[cell textLabel] setBackgroundColor:[UIColor clearColor]];
    
    [[cell textLabel] setText:ocorrencia.titulo];
    
    
    
    
    
    UIGraphicsEndImageContext();
    
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        OcorrenciaDoenca *ocorrencia1 = [ocorrencias  objectAtIndex:indexPath.row];
        
        OcorrenciaManager *manager = [OcorrenciaManager sharedInstance];
        
        [manager deletarOcorrencia:ocorrencia1];
        
        [manager saveContext];
        
        [self atualizarItensHistorico];
        
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
}

- (void)atualizarItensHistorico
{
    OcorrenciaManager *manager = [OcorrenciaManager sharedInstance];
    ocorrencias = [manager obterOcorrencias];
    [self.tableView reloadData];
}

- (CGFloat)tableView: (UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80.0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MostrarOcorrenciaViewController *viewController = [[MostrarOcorrenciaViewController alloc] init];
    OcorrenciaDoenca *ocorrencia1 = [ocorrencias objectAtIndex:indexPath.row];
    viewController.ocorrencia = ocorrencia1;
    
    [[self navigationController] pushViewController:viewController animated:YES];
}

#pragma mark - Selectors dos botões da navigationBar

- (void)adicionar:(id)sender
{
    OcorrenciaViewController *viewController = [[OcorrenciaViewController alloc] init];
    UINavigationController *navigation = [[UINavigationController alloc]initWithRootViewController:viewController];
    [[self navigationController] presentViewController:navigation animated:YES completion:nil];
}

#pragma mark - Métodos do NotificationCenter para atualizar tableView

- (void)tableViewReloadData:(NSNotification *)notification {
    OcorrenciaManager *manager = [OcorrenciaManager sharedInstance];
    
    ocorrencias = [manager obterOcorrencias];
    
    [self.tableView reloadData];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
