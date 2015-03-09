//
//  ListaHistVacinaViewController.m
//  Projeto Final
//
//  Created by Leonardo Felipe da Silva on 10/30/14.
//  Copyright (c) 2014 Mack Mobile - BEPiD. All rights reserved.
//

#import "ListaHistVacinaViewController.h"
#import "HistóricoVacinaViewController.h"
#import "PessoaManager.h"
#import "UnidadeDeTempoManager.h"

@interface ListaHistVacinaViewController ()

@end

@implementation ListaHistVacinaViewController

@synthesize viewControllerPai;

- (id)initWithVacina:(Vacina *)vacina2
{
    self = [super init];
    
    if (self) {
        vacina = vacina2;
        [self carregarItens];
    }
    
    return self;
}

- (void)carregarItens
{
    [self atualizarItensHistorico];
    
    //para corrigir tamanho da tableView ultrapassando a tabBar
    self.edgesForExtendedLayout = UIRectEdgeAll;
    self.tableView.contentInset = UIEdgeInsetsMake(0.0f, 0.0f, CGRectGetHeight(self.tabBarController.tabBar.frame), 0.0f);
    [self.tableView setScrollIndicatorInsets:UIEdgeInsetsMake(0.0f, 0.0f, CGRectGetHeight(self.tabBarController.tabBar.frame), 0.0f)];
    
    //adicionando as notificações
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tableViewReloadData:) name:@"atualizarTableView" object:nil];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    [self carregarItens];
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    
}

- (void)viewDidAppear:(BOOL)animated {
    //Botão de Adicionar
    UIBarButtonItem *barButtonAdd = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(adicionar:)];
    
    [[[self tabBarController] navigationItem] setRightBarButtonItem:barButtonAdd];
    //    [[self navigationItem] setRightBarButtonItem:barButtonAdd];
}

- (void)viewDidDisappear:(BOOL)animated {
    [[[self tabBarController] navigationItem] setRightBarButtonItem:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat heightRow;
    
    heightRow = 70.0;
    
    return heightRow;
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
    [super tableView:tableView willDisplayHeaderView:view forSection:section];
    
    UIColor *corNavigation = viewControllerPai.navigationController.navigationBar.barTintColor;
    [view setTintColor:corNavigation];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    NSString *title;
    
    if (section == 0) {
        title = @"Presente";
    } else if (section == 1) {
        title = @"Futuro";
    } else if (section == 2) {
        title = @"Passado";
    }
    
    return title;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:nil];
    
    // Configure the cell...
    
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    
    VacinaManager *managerVacina = [VacinaManager sharedInstance];
    PessoaManager *managerPessoa = [PessoaManager sharedInstance];
    UnidadeDeTempoManager *managerTempo = [UnidadeDeTempoManager sharedInstance];
    
    HistoricoVacina *historico = [[itensTableView objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle: NSDateFormatterMediumStyle]; //Choose the appropriate style for your case
    NSDateFormatter *dateTimeFormatter = [[NSDateFormatter alloc] init];
    [dateTimeFormatter setDateStyle: NSDateFormatterMediumStyle];
//    [dateTimeFormatter setTimeStyle: NSDateFormatterShortStyle];
    
    if (indexPath.section == 0) {
        //Atuais
        [[cell contentView]addSubview:[self criarFilete:[UIColor colorWithRed:35/255.0f green:142/255.0f blue:35/255.0f alpha:1.0] andSice:CGSizeMake(10, cell.frame.size.height)]];
        
        [[cell textLabel] setText:[NSString stringWithFormat:@"Próximo: %@", [dateTimeFormatter stringFromDate:[managerVacina proximaDataDoHistoricoVacina:historico]]]];
    } else if (indexPath.section == 1) {
        //Próximos
        [[cell contentView] addSubview:[self criarFilete:[UIColor colorWithRed:255/255.0f green:215/255.0f blue:0/255.0f alpha:1.0]andSice:CGSizeMake(10, cell.frame.size.height)]]; //ainda não começou (e consequentemente não terminou)
        NSLog(@"%@", historico);
        [[cell textLabel] setText:[NSString stringWithFormat:@"Início: %@", [dateTimeFormatter stringFromDate:historico.dataInicio]]];
    } else if (indexPath.section == 2) {
        //Finalizados
        [[cell contentView]addSubview:[self criarFilete:[UIColor colorWithRed:35/255.0f green:142/255.0f blue:35/255.0f alpha:1.0] andSice:CGSizeMake(10, cell.frame.size.height)]];
        [[cell textLabel] setText:[NSString stringWithFormat:@"Fim: %@", [dateTimeFormatter stringFromDate:[managerVacina dataFinalHistoricoVacina:historico]]]];
    }
    
    [[cell detailTextLabel] setText:[NSString stringWithFormat:@"Início: %@    Fim: %@", [dateTimeFormatter stringFromDate:historico.dataInicio], [dateTimeFormatter stringFromDate:[managerVacina dataFinalHistoricoVacina:historico]]]];
    
    //    UIView *corView = [managerPessoa criarViewCorBolinhaDaPessoa:historicoRem.pessoa naPosicao:CGPointMake(260, 25)];
    //    [[cell contentView] addSubview:corView];
    UIView *corView = [managerPessoa criarViewCorBolinhaDaPessoa:historico.pessoa naPosicao:CGPointMake(0, 0)];
    [cell setAccessoryView:corView];
    
    //    NSString *strDetailLabel = @"";
    //    strDetailLabel = [strDetailLabel stringByAppendingString:@"Duração: "];
    //    strDetailLabel = [strDetailLabel stringByAppendingString:[managerTempo criarLabel:historicoRem.duracao]];
    //    strDetailLabel = [strDetailLabel stringByAppendingString:@"Frequência: "];
    //    strDetailLabel = [strDetailLabel stringByAppendingString:[managerTempo criarLabel:historicoRem.frequencia]];
    //    strDetailLabel = [strDetailLabel stringByAppendingString:@"Quantidade: "];
    //    strDetailLabel = [strDetailLabel stringByAppendingString:historicoRem.qtda];
    //    [[cell detailTextLabel] setText:strDetailLabel];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Histo_ricoVacinaViewController *historicoViewController = [[Histo_ricoVacinaViewController alloc] init];
    
    historicoViewController.histVacina = [[itensTableView objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    
    [[viewControllerPai navigationController] pushViewController:historicoViewController animated:YES];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        HistoricoVacina *historico = [[itensTableView objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
        
        VacinaManager *manager = [VacinaManager sharedInstance];
        
        [manager deletarHistoricoVacina:historico];
        
        [manager saveContext];
        
        [self atualizarItensHistorico];
        
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
}

- (void)atualizarDados
{
    [self atualizarItensHistorico];
}

- (void)atualizarItensHistorico
{
    VacinaManager *manager = [VacinaManager sharedInstance];
    
    NSDictionary *itens = [manager obterHistoricoPorStatusDaVacina:vacina];
    
    itensTableView = [NSArray arrayWithObjects:[itens objectForKey:@"atuais"], [itens objectForKey:@"futuros"], [itens objectForKey:@"finalizados"], nil];
}

- (void)adicionar:(id)sender
{
    
    Histo_ricoVacinaViewController *historicoView = [[Histo_ricoVacinaViewController alloc] init];
    
    historicoView.histVacina = nil;
    historicoView.vacina = vacina;
    
    
    UINavigationController *navigation = [[UINavigationController alloc] initWithRootViewController:historicoView];
    
    [self.navigationController presentViewController:navigation animated:YES completion:nil];
    
    
}

- (void)tableViewReloadData:(NSNotification *)notification
{
    [self atualizarItensHistorico];
    
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
