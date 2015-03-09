//
//  RemedioCaixaViewController.m
//  Projeto Final
//
//  Created by Lucas Saito on 06/10/14.
//  Copyright (c) 2014 Mack Mobile - BEPiD. All rights reserved.
//

#import "RemedioCaixaViewController.h"
#import "RemedioManager.h"
#import "CampoViewController.h"

@interface RemedioCaixaViewController ()
{
    UITableView *tableViewConteudo;
    NSArray *tableViewItens;
}

@end

@implementation RemedioCaixaViewController

@synthesize remedioCaixa;
@synthesize remedio;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    RemedioManager *manager = [RemedioManager sharedInstance];
    
    if (!remedioCaixa) { //Adicionar Remédio
        remedioCaixa = [manager criarRemedioCaixaNoRemedio:remedio];
        
        [self setTitle:@"Nova caixa"];
        
        //Botão de Cancelar
        UIBarButtonItem *barButtonCancel = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(selBtnCancelar:)];
        [[self navigationItem] setLeftBarButtonItem:barButtonCancel];
        
        //Botão de Adicionar
        UIBarButtonItem *barButtonAdd = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(selBtnAdicionar:)];
        [[self navigationItem] setRightBarButtonItem:barButtonAdd];
    }
    
    UIView *viewTableView = [self criarView:0];
    
    tableViewConteudo = [self criarTableViewNaView:self.view comAltura:self.view.frame.size.height];
    tableViewConteudo.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [viewTableView setFrame:CGRectMake(viewTableView.frame.origin.x, viewTableView.frame.origin.y, viewTableView.frame.size.width, viewTableView.frame.size.height + tableViewConteudo.frame.size.height)];
    [viewTableView addSubview:tableViewConteudo];
    
    tableViewItens = [[NSArray alloc] initWithObjects:@"Data de validade", @"Quantidade total", @"Quantidade atual", nil];
    
    //adicionando as notificações
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tableViewReloadData:) name:@"atualizarTableView" object:nil];
}

- (void)viewWillAppear:(BOOL)animated
{
    [tableViewConteudo reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return tableViewItens.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    
    NSString *itemStr = [tableViewItens objectAtIndex:indexPath.row];
    if ([itemStr isEqualToString:@"Data de validade"]) {
        [[cell textLabel] setText:@"Data de validade"];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateStyle: NSDateFormatterMediumStyle]; //Choose the appropriate style for your case
        NSString *strData = [dateFormatter stringFromDate:remedioCaixa.dataValidade];
        [[cell detailTextLabel] setText:strData];
    } else if ([itemStr isEqualToString:@"Quantidade total"]) {
        [[cell textLabel] setText:@"Quantidade total"];
        [[cell detailTextLabel] setText:[NSString stringWithFormat:@"%@", remedioCaixa.qtdTotal]];
    } else if ([itemStr isEqualToString:@"Quantidade atual"]) {
        [[cell textLabel] setText:@"Quantidade atual"];
        [[cell detailTextLabel] setText:[NSString stringWithFormat:@"%@", remedioCaixa.qtdAtual]];
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height;
    
    height = 50.0;
    
    return height;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCellEditingStyle editingStyle;
    
    editingStyle = UITableViewCellEditingStyleNone;
    
    return editingStyle;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *itemStr = [tableViewItens objectAtIndex:indexPath.row];
    
    CampoViewController *campoViewController = [[CampoViewController alloc] init];
    campoViewController.refObjeto = remedioCaixa;
    
    if ([itemStr isEqualToString:@"Data de validade"]) {
        campoViewController.tipo = @"data";
        campoViewController.nomeAtributo = @"dataValidade";
    } else if ([itemStr isEqualToString:@"Quantidade total"]) {
        campoViewController.tipo = @"int";
        campoViewController.nomeAtributo = @"qtdTotal";
    } else if ([itemStr isEqualToString:@"Quantidade atual"]) {
        campoViewController.tipo = @"int";
        campoViewController.nomeAtributo = @"qtdAtual";
    }
    
    campoViewController.title = itemStr;
    
    [[self navigationController] pushViewController:campoViewController animated:YES];
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

- (void)selBtnCancelar:(id)sender
{
    RemedioManager *manager = [RemedioManager sharedInstance];
    [manager deletarRemedioCaixa:remedioCaixa];
    
    [self removerTela];
}

- (void)selBtnAdicionar:(id)sender
{
    RemedioManager *manager = [RemedioManager sharedInstance];
    
    [manager saveContext];
    
    [self removerTela];
}

- (void)removerTela
{
    //    [UIView animateWithDuration:0.75 animations:^{
    //        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    //        [UIView setAnimationTransition:UIViewAnimationTransitionNone forView:self.navigationController.view cache:NO];
    //    }];
    //    [self.navigationController popViewControllerAnimated:NO];
    
    //    [UIView transitionWithView:self.navigationController.view duration:0.75 options:UIViewAnimationOptionTransitionFlipFromBottom animations:^{
    //        [self.navigationController popViewControllerAnimated:NO];
    //    } completion:NULL];
    
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    
    //chamando o método do NotificationCenter para atualizar a tableView
    [[NSNotificationCenter defaultCenter] postNotificationName:@"atualizarTableView" object:nil];
}

#pragma mark - Métodos do NotificationCenter para atualizar tableView

- (void)tableViewReloadData:(NSNotification *)notification {
    [tableViewConteudo reloadData];
}

@end
