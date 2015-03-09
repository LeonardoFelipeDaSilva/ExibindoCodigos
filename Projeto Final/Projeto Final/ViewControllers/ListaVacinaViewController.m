//
//  ListaVacinaViewController.m
//  Projeto Final
//
//  Created by Leonardo Felipe da Silva on 08/09/14.
//  Copyright (c) 2014 Mack Mobile - BEPiD. All rights reserved.
//

#import "ListaVacinaViewController.h"
#import "ListaPrescricaoViewController.h"
#import "ListaHistVacinaViewController.h"
#import "MostrarVacinaViewController.h"
#import "HistóricoVacinaViewController.h"
#import "PessoaManager.h"
#import "MostrarVacinaViewController.h"
#import "MMPrincipal.h"

@interface ListaVacinaViewController ()
{
    NSArray *fotosPageControl;
}
@end

@implementation ListaVacinaViewController
@synthesize vacinas, histVacina, nomeVacina,tipoVacina, bolinha;

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
    
    [self setTitle:@"Vacinas"];
    
    //Botão de Adicionar
    UIBarButtonItem *barButtonAdd = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(adicionar:)];
    [[self navigationItem] setRightBarButtonItem:barButtonAdd];
    Vacina *vacina;
    VacinaManager *vacinaManager = [VacinaManager sharedInstance];
    histVacina = [vacinaManager criarHistoricoVacinaDaVacina:vacina];
    vacinas = [vacinaManager obterVacinas];
    
    //background
    [self.view setBackgroundColor:[UIColor colorWithRed:220/100.0f green:200/100.0f blue:238/20.0f alpha:0.6]];
    
    //adicionando as notificações para atualizar a tableView
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tableViewReloadData:) name:@"atualizarTableView" object:nil];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    VacinaViewController *viewController = [[VacinaViewController alloc] init];
//    Vacina *vacina = [vacinas objectAtIndex:indexPath.row];
//    viewController.vacina = vacina;
    
    Vacina *vacina = [vacinas objectAtIndex:indexPath.row];
    
    MostrarVacinaViewController *mostrar = [[MostrarVacinaViewController alloc]initWithNibName:nil bundle:nil];
    
//    UIViewController *viewController = [self criarViewControllerVacina:vacina];
    mostrar.vacina = vacina;
    
    [[self navigationController] pushViewController:mostrar animated:YES];
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        Vacina *vacina = [vacinas objectAtIndex:indexPath.row];
        
        VacinaManager *manager = [VacinaManager sharedInstance];
        
        [manager deletarVacina:vacina];
        
        [manager saveContext];
        
        [self atualizarItensHistorico];
        
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
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
    return vacinas.count;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *reuseIdentifier = @"CelulaVacina";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:nil];
    }
    // Configure the cell...
    
    Vacina *vacina = [vacinas objectAtIndex:indexPath.row];
    
    VacinaManager *managerVacina = [VacinaManager sharedInstance];
    
    UIImage *imagem = [UIImage imageNamed:@"vacina"];

    UIImageView *viewImagem = [[UIImageView alloc] init];
    [viewImagem setFrame:CGRectMake(10, 10, 60, 60)];
    [viewImagem setBackgroundColor:self.navigationController.navigationBar.barTintColor];
    viewImagem.layer.cornerRadius = viewImagem.frame.size.width/2;
    
    UIImageView *viewImagemReduzida = [[UIImageView alloc] init];
    [viewImagemReduzida setFrame:CGRectMake(viewImagem.frame.size.width/4, viewImagem.frame.size.height/4, viewImagem.frame.size.width/2, viewImagem.frame.size.height/2)];
    [viewImagemReduzida setImage:imagem];
    [viewImagem addSubview:viewImagemReduzida];
    
    [[cell contentView] addSubview:viewImagem];
    
    NSMutableArray *arrayCores = [[NSMutableArray alloc] init];
    for (Pessoa *pessoa in [managerVacina obterPessoasComHistoricoDaVacina:vacina]) {
        [arrayCores addObject:pessoa.cor];
    }
    MMUIViewDrawRect *viewCirculoColorido = [[MMUIViewDrawRect alloc] initWithPosition:CGPointMake(0, 0) andSize:viewImagem.frame.size.width andCores:arrayCores];
    [viewImagem addSubview:viewCirculoColorido];
    
    
    
    nomeVacina = [[UILabel alloc]init];
    nomeVacina.frame = CGRectMake(cell.frame.origin.x+viewImagem.frame.size.width + 20, cell.frame.origin.y+(cell.frame.size.height / 3), cell.frame.size.width - viewImagem.frame.size.width, cell.frame.size.height/3);
    [nomeVacina setText:vacina.nome];
    
    tipoVacina = [[UILabel alloc]init];
    tipoVacina.frame = CGRectMake(cell.frame.origin.x+viewImagem.frame.size.width + 20, nomeVacina.frame.size.height + cell.frame.size.height/(cell.frame.size.height / 30), cell.frame.size.width - viewImagem.frame.size.width, cell.frame.size.height/3);
    [tipoVacina setText:vacina.tipo];
    
    [[cell contentView] addSubview:nomeVacina];
    [[cell contentView] addSubview:tipoVacina];
   
//    [[cell textLabel] setText:vacina.nome];
//    [[cell detailTextLabel] setText:vacina.tipo];
    
    [[cell textLabel] setTextColor:[UIColor blackColor]];
    [[cell textLabel] setBackgroundColor:[UIColor clearColor]];
    
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    
    return cell;
}

- (CGFloat)tableView: (UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80.0;
}
- (UIViewController *)criarViewControllerVacina:(Vacina *)vacina
{
    MMTabBarController *tabBarController = [[MMTabBarController alloc] init];
    
    tabBarController.objeto = vacina;
    
    VacinaViewController *vacinaViewController = [[VacinaViewController alloc] init];
    //    UINavigationController *ncRemedio = [[UINavigationController alloc] initWithRootViewController:remedioViewController];
    
//    ListaHistoricoRemViewController *listaHistoricoRemViewController = [[ListaHistoricoRemViewController alloc] init];
    //    UINavigationController *ncHistorico = [[UINavigationController alloc] initWithRootViewController:listaHistoricoRemViewController];
    
    ListaPrescricaoViewController *listaPrescricaoViewController = [[ListaPrescricaoViewController alloc] init];
    //    UINavigationController *ncPrescricao = [[UINavigationController alloc] initWithRootViewController:listaPrescricaoViewController];
    
    //    [tabBarController setViewControllers:@[ncRemedio, ncHistorico, ncCaixa, ncPrescricao]];
    
//    MostrarVacinaViewController *mostrarVacinaViewController = [[MostrarVacinaViewController alloc]init];
    ListaHistVacinaViewController *listaVacinaViewController = [[ListaHistVacinaViewController alloc] init];
    
    [tabBarController setViewControllers:@[vacinaViewController, listaVacinaViewController, listaPrescricaoViewController]];
    
    [[tabBarController.tabBar.items objectAtIndex:0] setTitle:@"Vacina"];
//    [[tabBarController.tabBar.items objectAtIndex:1] setTitle:@"Histórico"];
    [[tabBarController.tabBar.items objectAtIndex:1] setTitle:@"Histórico"];
    [[tabBarController.tabBar.items objectAtIndex:2] setTitle:@"Prescrição"];
    
    [tabBarController setSelectedIndex:0];
    
    return tabBarController;
}


#pragma mark - Selectors dos botões da navigationBar
- (void)atualizarItensHistorico
{
    VacinaManager *manager = [VacinaManager sharedInstance];
    vacinas = [manager obterVacinas];
    [self.tableView reloadData];
}
- (void)adicionar:(id)sender
{
    VacinaViewController *viewController = [[VacinaViewController alloc] init];
    UINavigationController *navigation = [[UINavigationController alloc]initWithRootViewController:viewController];
    [[self navigationController] presentViewController:navigation animated:YES completion:nil];
}

#pragma mark - Métodos do NotificationCenter para atualizar tableView

- (void)tableViewReloadData:(NSNotification *)notification {
    VacinaManager *vacinaManager = [VacinaManager sharedInstance];
    vacinas = [vacinaManager obterVacinas];
    
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
