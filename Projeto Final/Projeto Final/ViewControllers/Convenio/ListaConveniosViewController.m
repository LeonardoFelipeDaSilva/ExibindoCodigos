//
//  ListaConveniosViewController.m
//  Projeto Final
//
//  Created by Leonardo Felipe da Silva on 12/8/14.
//  Copyright (c) 2014 Mack Mobile - BEPiD. All rights reserved.
//

#import "ListaConveniosViewController.h"
#import "ConsultaManager.h"
#import "ConvenioViewController.h"

@interface ListaConveniosViewController ()
{
    NSArray *itensHistorico2;
}
@end

@implementation ListaConveniosViewController

@synthesize convenio, perfil;
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
    
    [self setTitle:@"Convenios"];
    
    
    //Botão de Adicionar
    UIBarButtonItem *barButtonAdd = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(adicionar:)];
    [[self navigationItem] setRightBarButtonItem:barButtonAdd];
    
    PessoaManager *manager = [PessoaManager sharedInstance];
    
    convenios = [manager obterConvenios];
    
    //background
    [self.view setBackgroundColor:[UIColor colorWithRed:220/100.0f green:200/100.0f blue:238/20.0f alpha:0.6]];
    
    //adicionando as notificações para atualizar a tableView
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tableViewReloadData:) name:@"atualizarTableView" object:nil];
    
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
    return convenios.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *reuseIdentifier = @"CelulaPerfil";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuseIdentifier];
    }
    
    // Configure the cell...
    
    
    //    PessoaManager *managerPessoa = [PessoaManager sharedInstance];
    
    Convenio *convenio1 = [convenios objectAtIndex:indexPath.row];
    
    
    [[cell textLabel] setTextColor:[UIColor blackColor]];
    
    [[cell textLabel] setBackgroundColor:[UIColor clearColor]];
    
    [[cell textLabel] setText:convenio1.nome];
    [[cell detailTextLabel] setText:[NSString stringWithFormat:@"%@",convenio1.numero]];
    
    
    
    
    
    UIGraphicsEndImageContext();
    
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        Convenio *convenio1 = [convenios objectAtIndex:indexPath.row];
        
        PessoaManager *manager = [PessoaManager sharedInstance];
        
        [manager deletarConvenio:convenio1];
        
        [manager saveContext];
        
        [self atualizarItensHistorico];
        
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
}

- (void)atualizarItensHistorico
{
    PessoaManager *manager = [PessoaManager sharedInstance];
    convenios = [manager obterConvenios];
    [self.tableView reloadData];
}

- (CGFloat)tableView: (UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60.0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ConvenioViewController *viewController = [[ConvenioViewController alloc] init];
    Convenio *convenio1 = [convenios objectAtIndex:indexPath.row];
    viewController.convenio = convenio1;
    
    [[self navigationController] pushViewController:viewController animated:YES];
}

#pragma mark - Selectors dos botões da navigationBar

- (void)adicionar:(id)sender
{
    ConvenioViewController *viewController = [[ConvenioViewController alloc] init];
    UINavigationController *navigation = [[UINavigationController alloc]initWithRootViewController:viewController];
    [[self navigationController] presentViewController:navigation animated:YES completion:nil];
}

#pragma mark - Métodos do NotificationCenter para atualizar tableView

- (void)tableViewReloadData:(NSNotification *)notification {
    PessoaManager *manager = [PessoaManager sharedInstance];
    
    convenios = [manager obterConvenios];
    
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
