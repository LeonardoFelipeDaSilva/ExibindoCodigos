//
//  VacinaViewController.m
//  Projeto Final
//
//  Created by Leonardo Felipe da Silva on 08/09/14.
//  Copyright (c) 2014 Mack Mobile - BEPiD. All rights reserved.
//

#import "VacinaViewController.h"
#import "NomeVacinaViewController.h"
#import "TipoVacinaViewController.h"
#import "LocalVacinaViewController.h"
#import "DataTomVacinaViewController.h"
#import "ListaPerfilViewController.h"
#import "CampoViewController.h"
#import "UnidadeDeTempoManager.h"

@interface VacinaViewController ()

@end

@implementation VacinaViewController
@synthesize vacina, tableView2, dataTomada;

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
    
    
    
    VacinaManager *vacinaManager = [VacinaManager sharedInstance];
    
   
    
    if (!vacina) {
        vacina = [vacinaManager criarVacina];
//        histVacina = [vacinaManager criarHistoricoVacinaDaVacina:vacina];
        
        UIBarButtonItem *saveButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(adicionar:)];
        
        [[self navigationItem] setRightBarButtonItem:saveButton];
        
        UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelar:)];
        
        [[self navigationItem] setLeftBarButtonItem:cancelButton];
        [self setTitle:@"Nova Vacina"];
    } else {
        [self setTitle:vacina.nome];
        
    }
    
    UIView *viewTableView = [self criarView:0];
    tableView2 = [[UITableView alloc]init];
    [tableView2 setFrame:CGRectMake(self.view.window.bounds.origin.x, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [tableView2 setDelegate:self];
    [tableView2 setDataSource:self];
    [viewTableView setFrame:CGRectMake(viewTableView.frame.origin.x, viewTableView.frame.origin.y, viewTableView.frame.size.width, viewTableView.frame.size.height + tableView2.frame.size.height)];
    [viewTableView addSubview:tableView2];
    
    [self setContentSizeScrollView];
    
    
    // Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated
{
//    VacinaManager *vacinaManager = [VacinaManager sharedInstance];

    
//    itensHistorico2 = [vacinaManager obterHistoricoDaVacina:vacina];
    
    
    [tableView2 reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 3;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    
    if (section == 0) {
        
        return @" ";
    }
    if (section == 1) {
        return @" ";
    }
    return @"";
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 30.0;
    }
    if (section == 1) {
        return 0.0;
    }
    if (section == 2) {
        return 340.0;
    }
    return 0.0;
}
- (CGFloat)tableView: (UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 40.0;
    }
    if (indexPath.section == 1){
    return 40.0;
    }
    return 40.0;
    
}

//- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    if (indexPath.section == 1)
//    if (indexPath.row == 0) {
//        return UITableViewCellEditingStyleNone;
//    }
//        return UITableViewCellEditingStyleDelete;
//
//}
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
            NomeVacinaViewController *nomeViewController = [[NomeVacinaViewController alloc]init];
//            UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            nomeViewController.vacina = vacina;
            [[self navigationController] pushViewController:nomeViewController animated:YES];
        }
        if (indexPath.row == 1) {
            TipoVacinaViewController *ViewController = [[TipoVacinaViewController alloc]init];
            ViewController.vacina = vacina;
//            UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            [[self navigationController] pushViewController:ViewController animated:YES];
        }
       
        
    }
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
           
        }
//        if (indexPath.row == 0) {
//            DataTomVacinaViewController *ViewController = [[DataTomVacinaViewController alloc]initWithNibName:nil bundle:nil];
//            ViewController.histVacina = histVacina;
//            UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
//            [[self navigationController] pushViewController:ViewController animated:YES];
//        }
//        if (indexPath.row == 1) {
//            LocalVacinaViewController *ViewController = [[LocalVacinaViewController alloc]initWithNibName:nil bundle:nil];
//            ViewController.histVacina = histVacina;
//            UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
//            [[self navigationController] pushViewController:ViewController animated:YES];
//        }
    }
    
    
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //    NSInteger numRows = itensHistoricoConvenio.count;
    // Return the number of rows in the section.
    switch (section) {
        case 0:
            return 2;
            break;
        case 1:
            return 0; //of rows in section;
            break;
        case 2:
            return 0;
            break;
    }
    return 0;
}

- (UITableViewCell *)tableView: (UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *CellIdentifier = @"celulaVacina";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    }
    // Configure the cell...
    
    
    
    [cell setBackgroundColor: [UIColor clearColor]];
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    
    if (indexPath.section == 0) {
        if(indexPath.row == 0){
            NSString *title = @"Nome ";
            [[cell textLabel] setText:title];
            [[cell detailTextLabel] setText:vacina.nome];
            cell.textLabel.textColor = [UIColor colorWithRed:84/255.0f green:84/255.0f blue:84/255.0f alpha:1];
            cell.textLabel.highlightedTextColor = [UIColor whiteColor];
        }
        if(indexPath.row == 1){
            NSString *title = @"Tipo ";
            [[cell textLabel] setText:title];
            [[cell detailTextLabel] setText:vacina.tipo];
            cell.textLabel.textColor = [UIColor colorWithRed:84/255.0f green:84/255.0f blue:84/255.0f alpha:1];
            cell.textLabel.highlightedTextColor = [UIColor whiteColor];
        }
        
        
        
    }else if(indexPath.section == 1){
//        if (indexPath.row == 0) {
//            
//            NSString *title = @"Data Tomada ";
//            [[cell textLabel] setText:title];
//            NSDateFormatter *dateFormatter;
//            dateFormatter = [MMNSDateFormater criarDateFormatter];
//            
//            dataTomada = [NSString stringWithFormat:@"%@",
//                              [dateFormatter stringFromDate:histVacina.dataTomada]];
//            [[cell detailTextLabel] setText:dataTomada];
//            
//            cell.textLabel.textColor = [UIColor colorWithRed:84/255.0f green:84/255.0f blue:84/255.0f alpha:1];
//            cell.textLabel.highlightedTextColor = [UIColor whiteColor];
//        }
//        if(indexPath.row == 1){
//            NSString *title = @"Local ";
//            
//            [[cell textLabel] setText:title];
//            [[cell detailTextLabel] setText:histVacina.local];
//            cell.textLabel.textColor = [UIColor colorWithRed:84/255.0f green:84/255.0f blue:84/255.0f alpha:1];
//            cell.textLabel.highlightedTextColor = [UIColor whiteColor];
//        }
        
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
    VacinaManager *manager = [VacinaManager sharedInstance];
    [manager deletarVacina:vacina];
    
    [self removerTela];
}


- (void)adicionar:(id)sender
{
    VacinaManager *manager = [VacinaManager sharedInstance];
    
    [manager saveContext];
    
    [self removerTela];
}

- (void)removerTela
{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    
    //chamando o método do NotificationCenter para atualizar a tableView
    [[NSNotificationCenter defaultCenter] postNotificationName:@"atualizarTableView" object:nil];
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
