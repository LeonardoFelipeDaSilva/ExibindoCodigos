//
//  AlergiaPerfilViewController.m
//  Projeto Final
//
//  Created by Leonardo Felipe da Silva on 11/17/14.
//  Copyright (c) 2014 Mack Mobile - BEPiD. All rights reserved.
//

#import "AlergiaPessoaViewController.h"
#import "SubstanciaAlergiaViewController.h"
#import "TipoAlergiaPessoaViewController.h"

@interface AlergiaPessoaViewController ()

@end

@implementation AlergiaPessoaViewController

@synthesize pessoa, alergia;
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
    
    //Adicionando Botao salvar na view
    
    
    
    PessoaManager *manager = [PessoaManager sharedInstance];
    if (!alergia) { //Adicionar Remédio
        alergia = [manager criarAlergia];
        
        [self setTitle:@"Alergia"];
        UIBarButtonItem *saveButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(selBtnAdicionar:)];
        
        [[self navigationItem] setRightBarButtonItem:saveButton];
        UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelar:)];
        
        [[self navigationItem] setLeftBarButtonItem:cancelButton];
        
    } else { //Visualizar ou Editar o Remédio
        [self setTitle:alergia.substancia];
        
        
    }
    
    //BLUR E FOTO
    
    
    UIView *viewTableView = [self criarView:0];
    TableView = [[UITableView alloc]init];
    [TableView setFrame:CGRectMake(self.view.window.bounds.origin.x, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [TableView setDelegate:self];
    [TableView setDataSource:self];
    
    [viewTableView setFrame:CGRectMake(viewTableView.frame.origin.x, viewTableView.frame.origin.y, viewTableView.frame.size.width, viewTableView.frame.size.height + TableView.frame.size.height)];
    [viewTableView addSubview:TableView];
    
    [self setContentSizeScrollView];
    
    
    
    
}

//- (void)dealloc {
//    [nascimento release];
//    [dateFormatter release];
//    [super dealloc];
//}
- (void)viewDidAppear:(BOOL)animated
{
    PessoaManager *manager = [PessoaManager sharedInstance];
    //    itensHistorico = [pessoaManager obterConve];
    
    [TableView reloadData];
}

//- (void)salvar:(id)sender
//{
//    pessoa.foto = UIImageJPEGRepresentation(Foto.image, 1.0);
//
//
//    [[self navigationController] popViewControllerAnimated:YES];
//
//    //chamando o método do NotificationCenter para atualizar a tableView
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"tableViewCadPessoaReloadData" object:nil];
//}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 2;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    
    if (section == 1) {
        
        return @"  ";
    }
    if (section == 2) {
        return @"  ";
    }
    return @"";
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 20.0;
    }
    if (section == 1) {
        return 500.0;
    }
    return 0.0;
}
- (CGFloat)tableView: (UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 40.0;
    
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCellEditingStyle editingStyle;
    if (indexPath.section == 0) {
        editingStyle = UITableViewCellEditingStyleNone;
    } else if (indexPath.section == 1) {
        editingStyle = UITableViewCellEditingStyleNone;
    } else if (indexPath.section == 2) {
        if (indexPath.row == 0) {
            editingStyle = UITableViewCellEditingStyleInsert;
        } else {
            editingStyle = UITableViewCellEditingStyleDelete;
        }
    }
    
    return editingStyle;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            
            SubstanciaAlergiaViewController *viewController = [[SubstanciaAlergiaViewController alloc]initWithNibName:nil bundle:nil];
//            NomeConveioViewController *viewController = [[NomeConveioViewController alloc]initWithNibName:nil bundle:nil];
//                    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            viewController.alergia = alergia;
//
            [[self navigationController] pushViewController:viewController animated:YES];
        }
        if (indexPath.row == 1){
            TipoAlergiaPessoaViewController *viewController = [[TipoAlergiaPessoaViewController alloc]initWithNibName:nil bundle:nil];
//            //        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            viewController.alergia = alergia;
            [[self navigationController] pushViewController:viewController animated:YES];
        }
        
    }
    if (indexPath.section == 2) {
        if (indexPath.row == 0) {
            
        }
    }
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    switch (section) {
        case 0:
            return 2;
            break;
        case 1:
            return 0; //of rows in section;
            break;
    }
    return 0;
}

- (UITableViewCell *)tableView: (UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *CellIdentifier = @"celulaConvenio";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    }
    // Configure the cell...
    [cell setBackgroundColor: [UIColor clearColor]];
    
    
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    
    if (indexPath.section == 0) {
        if(indexPath.row == 0){
            NSString *title = @"Subtância";
            [[cell textLabel] setText:title];
            [[cell detailTextLabel] setText:alergia.substancia];
            cell.textLabel.textColor = [UIColor colorWithRed:84/255.0f green:84/255.0f blue:84/255.0f alpha:1];
            cell.textLabel.highlightedTextColor = [UIColor whiteColor];
        }
        if(indexPath.row == 1){
            NSString *title = @"Tipo";
            NSString *detailTitle = [NSString stringWithFormat:@"%@", alergia.tipo];
            [[cell textLabel] setText:title];
            [[cell detailTextLabel] setText:detailTitle];
            cell.textLabel.textColor = [UIColor colorWithRed:84/255.0f green:84/255.0f blue:84/255.0f alpha:1];
            cell.textLabel.highlightedTextColor = [UIColor whiteColor];
        }
        
    }
    
    
    return cell;
    
    
}


- (void)cancelar:(id)sender
{
    PessoaManager *manager = [PessoaManager sharedInstance];
    [manager deletarAlergia:alergia];
    
    [self removerTela];
}

- (void)selBtnAdicionar:(id)sender
{
    PessoaManager *manager = [PessoaManager sharedInstance];
    [manager saveContext];
    [self removerTela];
}

- (void)removerTela
{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    
    //chamando o método do NotificationCenter para atualizar a tableView
    [[NSNotificationCenter defaultCenter] postNotificationName:@"atualizarTableView" object:nil];
}





- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
