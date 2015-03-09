
//
//  TipoAlergiaViewController.m
//  Projeto Final
//
//  Created by Leonardo Felipe da Silva on 11/17/14.
//  Copyright (c) 2014 Mack Mobile - BEPiD. All rights reserved.
//

#import "TipoAlergiaPessoaViewController.h"
#import "AlergiaPerfilManager.h"

@interface TipoAlergiaPessoaViewController ()

@end

@implementation TipoAlergiaPessoaViewController

@synthesize tableViewNome, tipoAlergia, pickerView, alergia, tiposAlergia;

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
    
    [self setTitle:@"Tipo da Alergia"];
    
    tableViewNome = [[UITableView alloc]init];
    [tableViewNome setFrame:CGRectMake(self.view.window.bounds.origin.x, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [tableViewNome setDelegate:self];
    [tableViewNome setDataSource:self];
    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(adicionar:)];
    
    [[self navigationItem] setRightBarButtonItem:saveButton];
    
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelar:)];
    
    [[self navigationItem] setLeftBarButtonItem:cancelButton];
    
    UIView *viewTableView = [self criarView:0];
    [viewTableView setFrame:CGRectMake(viewTableView.frame.origin.x, viewTableView.frame.origin.y, viewTableView.frame.size.width, viewTableView.frame.size.height + tableViewNome.frame.size.height)];
    [viewTableView addSubview:tableViewNome];
    
    [self setContentSizeScrollView];
    // Do any additional setup after loading the view.
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 8;
    }
    return  0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 30;
    }
    if (section == 1) {
        return self.view.frame.size.height - (20+30);
    }
    return 0.0;
}
- (CGFloat)tableView: (UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 40.0;
    }
    return 0.0;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    for (int secao=0; secao<tableView.numberOfSections; secao++) {
        for (int linha=0; linha<[tableView numberOfRowsInSection:secao]; linha++) {
            //                NSLog(@"S %d L %d", secao, linha);
            [[tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:linha inSection:secao]] setAccessoryType:UITableViewCellAccessoryNone];
        }
    }
    if (indexPath.row == 0) {
        tiposAlergia = @"Alergia Graves/Anafilaxia";
    }
    if (indexPath.row == 1) {
        tiposAlergia = @"Alergia Alimentar";
    }
    if (indexPath.row == 2) {
        tiposAlergia = @"Alergia Cutânea";
    }
    if (indexPath.row == 3) {
        tiposAlergia = @"Alergia à Remédios";
    }
    if (indexPath.row == 4) {
        tiposAlergia = @"Alergia ao Látex";
    }
    if (indexPath.row == 5) {
        tiposAlergia = @"Alergia Respiratória";
    }
    if (indexPath.row == 6) {
        tiposAlergia = @"Alergia à Picadas de Insetos";
    }
    if (indexPath.row == 7) {
        tiposAlergia = @"Outros";
    }
    [[tableView cellForRowAtIndexPath:indexPath] setSelectionStyle:UITableViewCellSelectionStyleBlue];
    [[tableView cellForRowAtIndexPath:indexPath] setAccessoryType:UITableViewCellAccessoryCheckmark];
    
}
- (UITableViewCell *)tableView: (UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *CellIdentifier = @"celulaNome";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    
    [cell setAccessoryType:UITableViewCellAccessoryNone];
    
    if (indexPath.section == 0) {
        if(indexPath.row == 0){
            NSString *title = @"Alergia Graves/Anafilaxia";
            [[cell textLabel] setText:title];
            cell.textLabel.textColor = [UIColor colorWithRed:84/255.0f green:84/255.0f blue:84/255.0f alpha:1];
            cell.textLabel.highlightedTextColor = [UIColor whiteColor];
        }
        if(indexPath.row == 1){
            NSString *title = @"Alergia Alimentar";
            [[cell textLabel] setText:title];
            cell.textLabel.textColor = [UIColor colorWithRed:84/255.0f green:84/255.0f blue:84/255.0f alpha:1];
            cell.textLabel.highlightedTextColor = [UIColor whiteColor];
        }
        if(indexPath.row == 2){
            NSString *title = @"Alergia Cutânea";
            [[cell textLabel] setText:title];
            cell.textLabel.textColor = [UIColor colorWithRed:84/255.0f green:84/255.0f blue:84/255.0f alpha:1];
            cell.textLabel.highlightedTextColor = [UIColor whiteColor];
        }
        if(indexPath.row == 3){
            NSString *title = @"Alergia à Remédios";
            
            [[cell textLabel] setText:title];
            cell.textLabel.textColor = [UIColor colorWithRed:84/255.0f green:84/255.0f blue:84/255.0f alpha:1];
            cell.textLabel.highlightedTextColor = [UIColor whiteColor];
        }
        if(indexPath.row == 4){
            NSString *title = @"Alergia ao Látex";
            
            [[cell textLabel] setText:title];
            cell.textLabel.textColor = [UIColor colorWithRed:84/255.0f green:84/255.0f blue:84/255.0f alpha:1];
            cell.textLabel.highlightedTextColor = [UIColor whiteColor];
        }
        if(indexPath.row == 5){
            NSString *title = @"Alergia Respiratória";
            [[cell textLabel] setText:title];
            cell.textLabel.textColor = [UIColor colorWithRed:84/255.0f green:84/255.0f blue:84/255.0f alpha:1];
            cell.textLabel.highlightedTextColor = [UIColor whiteColor];
        }
        if(indexPath.row == 6){
            NSString *title = @"Alergia à Picadas de Insetos";
            [[cell textLabel] setText:title];
            cell.textLabel.textColor = [UIColor colorWithRed:84/255.0f green:84/255.0f blue:84/255.0f alpha:1];
            cell.textLabel.highlightedTextColor = [UIColor whiteColor];
        }
        if(indexPath.row == 7){
            NSString *title = @"Outros";
            [[cell textLabel] setText:title];
            cell.textLabel.textColor = [UIColor colorWithRed:84/255.0f green:84/255.0f blue:84/255.0f alpha:1];
            cell.textLabel.highlightedTextColor = [UIColor whiteColor];
        }
    }
    return cell;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)cancelar:(id)sender
{
    
    [self removerTela];
}

- (void)adicionar:(id)sender
{
    alergia.tipo = tiposAlergia;
    AlergiaPerfilManager *manager = [AlergiaPerfilManager sharedInstance];
    [manager saveContext];
    [self removerTela];
}
- (void)removerTela
{
    [[self navigationController] popViewControllerAnimated:YES];
    
    //chamando o método do NotificationCenter para atualizar a tableView
    [[NSNotificationCenter defaultCenter] postNotificationName:@"atualizarTableView" object:nil];
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
