//
//  ListaRemedioViewController.m
//  Projeto Final
//
//  Created by Leonardo Felipe da Silva on 22/08/14.
//  Copyright (c) 2014 Mack Mobile - BEPiD. All rights reserved.
//

#import "ListaRemedioViewController.h"
#import "RemedioViewController.h"
#import "ListaHistoricoRemViewController.h"
#import "ListaRemedioCaixaViewController.h"
#import "ListaPrescricaoViewController.h"
#import "MMTabBarController.h"
#import "Pessoa.h"

@interface ListaRemedioViewController ()

@end

@implementation ListaRemedioViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setTitle:@"Remédios"];
    
    //Botão de Adicionar
    UIBarButtonItem *barButtonAdd = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(adicionar:)];
    [[self navigationItem] setRightBarButtonItem:barButtonAdd];
    
    //background
    [self.view setBackgroundColor:[UIColor colorWithRed:220/100.0f green:200/100.0f blue:238/20.0f alpha:0.6]];
    
    [self atualizarRemedios];
    
    //adicionando as notificações para atualizar a tableView
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tableViewReloadData:) name:@"tableViewRemediosReloadData" object:nil];
}

- (void)viewDidAppear:(BOOL)animated
{
    [self tableViewReloadData:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)atualizarRemedios
{
    RemedioManager *manager = [RemedioManager sharedInstance];
    
    NSDictionary *itens = [manager obterRemediosPorStatusDoPerfil];
    
    itensTableView = [NSArray arrayWithObjects:[itens objectForKey:@"ativados"], [itens objectForKey:@"naoAssociados"], [itens objectForKey:@"desativados"], nil];
}

#pragma mark - Table view data source

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat heightRow;
    
    heightRow = 60.0;
    
    return heightRow;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    NSString *title;
    
    if (section == 0) {
        title = @"Com perfis ativados";
    } else if (section == 1) {
        title = @"Sem perfis associados";
    } else if (section == 2) {
        title = @"Com perfis desativados";
    }
    
    return title;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *reuseIdentifier = @"CelulaRemedio";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    }
    // Configure the cell...
    
    Remedio *remedio = [[itensTableView objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    
    UIImage *imagem = [[UIImage alloc] initWithData: remedio.foto];
    
    UIImageView *viewImagem = [[UIImageView alloc] init];
    [viewImagem setFrame:CGRectMake(10, 10, 40, 40)];
    [viewImagem sizeThatFits:CGSizeMake(30, 30)];
    [viewImagem setImage:imagem];
    viewImagem.layer.masksToBounds = NO;
    viewImagem.layer.cornerRadius = 20;
    viewImagem.clipsToBounds = YES;
    [[cell contentView] addSubview:viewImagem];
    
    RemedioManager *manager = [RemedioManager sharedInstance];
    NSMutableArray *arrayCores = [[NSMutableArray alloc] init];
    for (Pessoa *pessoa in [manager obterPessoasComHistoricoDoRemedio:remedio]) {
        [arrayCores addObject:pessoa.cor];
    }
    MMUIViewDrawRect *viewCirculoColorido = [[MMUIViewDrawRect alloc] initWithPosition:CGPointMake(0, 0) andSize:viewImagem.frame.size.width andCores:arrayCores];
    [viewImagem addSubview:viewCirculoColorido];
    
    [[cell textLabel] setTextColor:[UIColor blackColor]];
    [[cell textLabel] setBackgroundColor:[UIColor clearColor]];
    [[cell textLabel] setText:remedio.nome];
    
    CGSize itemSize = CGSizeMake(30, 30); //Controla o tamanho do espacamento da imagem
    UIGraphicsBeginImageContext(itemSize);
    cell.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Remedio *remedio = [[itensTableView objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    
    UIViewController *viewController = [self criarViewControllerRemedio:remedio];
    
    [[self navigationController] pushViewController:viewController animated:YES];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        Remedio *remedio = [[itensTableView objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
        
        RemedioManager *manager = [RemedioManager sharedInstance];
        
        [manager deletarRemedio:remedio];
        
        [manager saveContext];
        
        [self atualizarRemedios];
        
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
}

#pragma mark - Selectors dos botões da navigationBar

- (void)adicionar:(id)sender
{
    UIViewController *viewController = [[RemedioViewController alloc] init];
    
//    [UIView transitionWithView:self.navigationController.view duration:0.75 options:UIViewAnimationOptionTransitionFlipFromTop animations:^{
//        [self.navigationController pushViewController:remedioViewController animated:NO];
//    } completion:NULL];
    
    UINavigationController *navigation = [[UINavigationController alloc] initWithRootViewController:viewController];
    
    [self.navigationController presentViewController:navigation animated:YES completion:nil];
}

- (UIViewController *)criarViewControllerRemedio:(Remedio *)remedio
{
    MMTabBarController *tabBarController = [[MMTabBarController alloc] init];
    
    tabBarController.objeto = remedio;
    
    RemedioViewController *remedioViewController = [[RemedioViewController alloc] init];
//    UINavigationController *ncRemedio = [[UINavigationController alloc] initWithRootViewController:remedioViewController];
    
    ListaHistoricoRemViewController *listaHistoricoRemViewController = [[ListaHistoricoRemViewController alloc] init];
//    UINavigationController *ncHistorico = [[UINavigationController alloc] initWithRootViewController:listaHistoricoRemViewController];
    
    ListaRemedioCaixaViewController *listaRemedioCaixaViewController = [[ListaRemedioCaixaViewController alloc] init];
//    UINavigationController *ncCaixa = [[UINavigationController alloc] initWithRootViewController:listaRemedioCaixaViewController];
    
    ListaPrescricaoViewController *listaPrescricaoViewController = [[ListaPrescricaoViewController alloc] init];
//    UINavigationController *ncPrescricao = [[UINavigationController alloc] initWithRootViewController:listaPrescricaoViewController];
    
//    [tabBarController setViewControllers:@[ncRemedio, ncHistorico, ncCaixa, ncPrescricao]];
    [tabBarController setViewControllers:@[remedioViewController, listaHistoricoRemViewController, listaRemedioCaixaViewController, listaPrescricaoViewController]];
    
    [[tabBarController.tabBar.items objectAtIndex:0] setTitle:@"Remédio"];
    
    [[tabBarController.tabBar.items objectAtIndex:1] setTitle:@"Histórico"];
//    [[tabBarController.tabBar.items objectAtIndex:1] setImage:[UIImage imageNamed:@"historico_line"] forState:UIControlStateDisabled];
//    [[tabBarController.tabBar.items objectAtIndex:1] setImage:[UIImage imageNamed:@"historico_color"] forState:UIControlStateSelected];
    [[tabBarController.tabBar.items objectAtIndex:2] setTitle:@"Caixa"];
//    [[tabBarController.tabBar.items objectAtIndex:2] setImage:[UIImage imageNamed:@"caixa_line"] forState:UIControlStateDisabled];
//    [[tabBarController.tabBar.items objectAtIndex:2] setImage:[UIImage imageNamed:@"caixa_color"] forState:UIControlStateSelected];
    [[tabBarController.tabBar.items objectAtIndex:3] setTitle:@"Prescrição"];
//    [[tabBarController.tabBar.items objectAtIndex:3] setImage:[UIImage imageNamed:@"prescricao_line"] forState:UIControlStateDisabled];
//    [[tabBarController.tabBar.items objectAtIndex:3] setImage:[UIImage imageNamed:@"prescricao_color"] forState:UIControlStateSelected];
    
    [tabBarController setSelectedIndex:0];
    
    [tabBarController.tabBar setTranslucent:NO];
    [tabBarController.tabBar setBarTintColor:self.navigationController.navigationBar.barTintColor];
    
    return tabBarController;
}

#pragma mark - Métodos do NotificationCenter para atualizar tableView

- (void)tableViewReloadData:(NSNotification *)notification {
    [self atualizarRemedios];
    
    [self.tableView reloadData];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
