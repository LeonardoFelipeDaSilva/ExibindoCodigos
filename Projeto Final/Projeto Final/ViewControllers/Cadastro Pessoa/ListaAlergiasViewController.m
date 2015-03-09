//
//  ListaAlergiasViewController.m
//  Projeto Final
//
//  Created by Leonardo Felipe da Silva on 11/17/14.
//  Copyright (c) 2014 Mack Mobile - BEPiD. All rights reserved.
//

#import "ListaAlergiasViewController.h"
#import "AlergiaPessoaViewController.h"
#import "AlergiaPerfilManager.h"

@interface ListaAlergiasViewController ()
{
    NSArray *itensHistorico2;
}
@end

@implementation ListaAlergiasViewController
@synthesize alergia, perfil;
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
    
    [self setTitle:@"Alergias"];
    
    
    //Botão de Adicionar
    UIBarButtonItem *barButtonAdd = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(adicionar:)];
    [[self navigationItem] setRightBarButtonItem:barButtonAdd];
    
    PessoaManager *manager = [PessoaManager sharedInstance];
    
    alergias = [manager obterAlergias];
    
    //background
    [self.view setBackgroundColor:[UIColor colorWithRed:220/100.0f green:200/100.0f blue:238/20.0f alpha:0.6]];
    
    //adicionando as notificações para atualizar a tableView
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tableViewReloadData:) name:@"atualizarTableView" object:nil];
    
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        Alergia *alergia1 = [alergias objectAtIndex:indexPath.row];
        
        PessoaManager *manager = [PessoaManager sharedInstance];
        
        [manager deletarAlergia:alergia1];
        
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
    alergias = [manager obterAlergias];
    [self.tableView reloadData];
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
    return alergias.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *reuseIdentifier = @"CelulaPerfil";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    }
    
    // Configure the cell...
    
    
//    PessoaManager *managerPessoa = [PessoaManager sharedInstance];
    
    Alergia *alergia1 = [alergias objectAtIndex:indexPath.row];
    
    
    [[cell textLabel] setTextColor:[UIColor blackColor]];
    
    [[cell textLabel] setBackgroundColor:[UIColor clearColor]];
    
    [[cell textLabel] setText:alergia1.substancia];
    
    
    
    
    
    UIGraphicsEndImageContext();
    
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    
    return cell;
}

- (CGFloat)tableView: (UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60.0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    AlergiaPessoaViewController *viewController = [[AlergiaPessoaViewController alloc] init];
    Alergia *alergiaaa = [alergias objectAtIndex:indexPath.row];
    viewController.alergia = alergiaaa;
    
    [[self navigationController] pushViewController:viewController animated:YES];
}

#pragma mark - Selectors dos botões da navigationBar

- (void)adicionar:(id)sender
{
    AlergiaPessoaViewController *viewController = [[AlergiaPessoaViewController alloc] init];
    UINavigationController *navigation = [[UINavigationController alloc]initWithRootViewController:viewController];
    [[self navigationController] presentViewController:navigation animated:YES completion:nil];
}

#pragma mark - Métodos do NotificationCenter para atualizar tableView

- (void)tableViewReloadData:(NSNotification *)notification {
    PessoaManager *manager = [PessoaManager sharedInstance];
    
    alergias = [manager obterAlergias];
    
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
