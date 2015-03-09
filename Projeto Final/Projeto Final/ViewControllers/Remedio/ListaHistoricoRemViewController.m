//
//  ListaHistoricoRemViewController.m
//  Projeto Final
//
//  Created by Lucas Saito on 06/10/14.
//  Copyright (c) 2014 Mack Mobile - BEPiD. All rights reserved.
//

#import "ListaHistoricoRemViewController.h"
#import "HistoricoRemViewController.h"
#import "RemedioManager.h"
#import "PessoaManager.h"
#import "UnidadeDeTempoManager.h"

@interface ListaHistoricoRemViewController ()

@end

@implementation ListaHistoricoRemViewController
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        UIImage *image = [UIImage imageNamed:@"relogio_line.png"];
        self.tabBarItem.image = [self imageWithImage:image scaledToSize:CGSizeMake(30, 30)];
        [[UITabBar appearance] setTintColor:[UIColor whiteColor]];
        UIImage *imageSelect = [UIImage imageNamed:@"relogio_color.png"];
        
        self.tabBarItem.selectedImage = [self imageWithImage:imageSelect scaledToSize:CGSizeMake(30, 30)];
        
        
        //        [[tabBarController.tabBar.items objectAtIndex:0] setImage:[UIImage imageNamed:@"remedio_line"] forState:UIControlStateDisabled];
        //        [[tabBarController.tabBar.items objectAtIndex:0] setImage:[UIImage imageNamed:@"remedio_color"] forState:UIControlStateSelected];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    remedio = ((Remedio *)((MMTabBarController *)self.tabBarController).objeto);
    
    [self atualizarItensHistorico];
    
    //para corrigir tamanho da tableView ultrapassando a tabBar
//    self.edgesForExtendedLayout = UIRectEdgeAll;
//    self.tableView.contentInset = UIEdgeInsetsMake(0.0f, 0.0f, CGRectGetHeight(self.tabBarController.tabBar.frame), 0.0f);
//    [self.tableView setScrollIndicatorInsets:UIEdgeInsetsMake(0.0f, 0.0f, CGRectGetHeight(self.tabBarController.tabBar.frame), 0.0f)];
    
    //adicionando as notificações
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tableViewReloadData:) name:@"atualizarTableView" object:nil];
}

- (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize {
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

- (void)viewDidAppear:(BOOL)animated {
    //Botão de Adicionar
    UIBarButtonItem *barButtonAdd = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(selBtnAdicionar:)];
    
    [[[self tabBarController] navigationItem] setRightBarButtonItem:barButtonAdd];
//    [[self navigationItem] setRightBarButtonItem:barButtonAdd];
}

- (void)viewDidDisappear:(BOOL)animated {
    [[[self tabBarController] navigationItem] setRightBarButtonItem:nil];
}



- (void)viewWillAppear:(BOOL)animated
{
    [self.tableView reloadData];
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

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    NSString *title;
    
    if (section == 0) {
        title = @"Prioridade";
    } else if (section == 1) {
        title = @"Próximos";
    } else if (section == 2) {
        title = @"Finalizados";
    }
    
    return title;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:nil];
    
    // Configure the cell...
    
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    
    RemedioManager *managerRemedio = [RemedioManager sharedInstance];
    PessoaManager *managerPessoa = [PessoaManager sharedInstance];
    UnidadeDeTempoManager *managerTempo = [UnidadeDeTempoManager sharedInstance];
    
    HistoricoRem *historicoRem = [[itensTableView objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle: NSDateFormatterMediumStyle]; //Choose the appropriate style for your case
    NSDateFormatter *dateTimeFormatter = [[NSDateFormatter alloc] init];
    [dateTimeFormatter setDateStyle: NSDateFormatterMediumStyle];
    [dateTimeFormatter setTimeStyle: NSDateFormatterShortStyle];
    
    if (indexPath.section == 0) {
        //Atuais
//        [cell setBackgroundColor:[UIColor greenColor]];
        [[cell contentView] addSubview:[self criarFilete:[UIColor colorWithRed:205/255.0f green:51/255.0f blue:51/255.0f alpha:1.0] andSice:CGSizeMake(10, cell.frame.size.height)]];
        [[cell textLabel] setText:[NSString stringWithFormat:@"Próximo: %@", [dateTimeFormatter stringFromDate:[managerRemedio proximaDataDoHistoricoRem:historicoRem]]]];
    } else if (indexPath.section == 1) {
        //Próximos
//        [cell setBackgroundColor:[UIColor yellowColor]]; //ainda não começou (e consequentemente não terminou)
        [[cell contentView] addSubview:[self criarFilete:[UIColor colorWithRed:255/255.0f green:215/255.0f blue:0/255.0f alpha:1.0]andSice:CGSizeMake(10, cell.frame.size.height)]];
        [[cell textLabel] setText:[NSString stringWithFormat:@"Início: %@", [dateTimeFormatter stringFromDate:historicoRem.dataInicio]]];
    } else if (indexPath.section == 2) {
        //Finalizados
        [[cell contentView] addSubview:[self criarFilete:[UIColor colorWithRed:35/255.0f green:142/255.0f blue:35/255.0f alpha:1.0] andSice:CGSizeMake(10, cell.frame.size.height)]];
    }
    
    [[cell detailTextLabel] setText:[NSString stringWithFormat:@"De %@ a %@", [dateTimeFormatter stringFromDate:historicoRem.dataInicio], [dateTimeFormatter stringFromDate:[managerRemedio dataFinalHistoricoRem:historicoRem]]]];
    
//    UIView *corView = [managerPessoa criarViewCorBolinhaDaPessoa:historicoRem.pessoa naPosicao:CGPointMake(260, 25)];
//    [[cell contentView] addSubview:corView];
    UIView *corView = [managerPessoa criarViewCorBolinhaDaPessoa:historicoRem.pessoa naPosicao:CGPointMake(0, 0)];
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
    HistoricoRemViewController *historicoRemViewController = [[HistoricoRemViewController alloc] init];
    
    historicoRemViewController.historicoRem = [[itensTableView objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    
    [[self navigationController] pushViewController:historicoRemViewController animated:YES];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        HistoricoRem *historicoRem = [[itensTableView objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
        
        RemedioManager *manager = [RemedioManager sharedInstance];
        
        [manager deletarHistoricoRem:historicoRem];

        [manager saveContext];
        
        [self atualizarItensHistorico];
        
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
}

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

- (void)atualizarItensHistorico
{
    RemedioManager *manager = [RemedioManager sharedInstance];
    
    NSDictionary *itens = [manager obterHistoricoPorStatusDoRemedio:remedio];
    
    itensTableView = [NSArray arrayWithObjects:[itens objectForKey:@"atuais"], [itens objectForKey:@"futuros"], [itens objectForKey:@"finalizados"], nil];
}

- (void)selBtnAdicionar:(id)sender
{
    HistoricoRemViewController *historicoRemViewController = [[HistoricoRemViewController alloc] init];

    historicoRemViewController.historicoRem = nil;
    historicoRemViewController.remedio = remedio;
    
    UINavigationController *navigation = [[UINavigationController alloc] initWithRootViewController:historicoRemViewController];
    
    [self.navigationController presentViewController:navigation animated:YES completion:nil];
}

#pragma mark - Métodos do NotificationCenter para atualizar tableView

- (void)tableViewReloadData:(NSNotification *)notification
{
    [self atualizarItensHistorico];
    
    [self.tableView reloadData];
}

@end
