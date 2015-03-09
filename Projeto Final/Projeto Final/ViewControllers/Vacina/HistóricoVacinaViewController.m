//
//  HistóricoVacinaViewController.m
//  Projeto Final
//
//  Created by Leonardo Felipe da Silva on 10/24/14.
//  Copyright (c) 2014 Mack Mobile - BEPiD. All rights reserved.
//

#import "HistóricoVacinaViewController.h"
#import "DataTomVacinaViewController.h"
#import "LocalVacinaViewController.h"
#import "ListaPerfilViewController.h"
#import "UnidadeDeTempoManager.h"
#import "CampoViewController.h"

@interface Histo_ricoVacinaViewController ()
{
    NSArray *itensHistorico2;
}
@end

@implementation Histo_ricoVacinaViewController
@synthesize vacina, histVacina, tableView2, dataTomada;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)carregarItens
{
    VacinaManager *vacinaManager = [VacinaManager sharedInstance];
    UIView *viewTableView = [self criarView:0];
    tableView2 = [[UITableView alloc]init];
    [tableView2 setFrame:CGRectMake(self.view.window.bounds.origin.x, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [tableView2 setDelegate:self];
    [tableView2 setDataSource:self];
    [viewTableView setFrame:CGRectMake(viewTableView.frame.origin.x, viewTableView.frame.origin.y, viewTableView.frame.size.width, viewTableView.frame.size.height + tableView2.frame.size.height)];
    [viewTableView addSubview:tableView2];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tableViewReloadData:) name:@"atualizarTableView" object:nil];
    
    if (!histVacina) {
        
        histVacina = [vacinaManager criarHistoricoVacinaDaVacina:vacina];
        
        UIBarButtonItem *saveButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(adicionar:)];
        
        [[self navigationItem] setRightBarButtonItem:saveButton];
        
        UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelar:)];
        
        [[self navigationItem] setLeftBarButtonItem:cancelButton];
        
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    
    
    [self carregarItens];
    
   
    
   
    
    
    // Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated
{
    VacinaManager *vacinaManager = [VacinaManager sharedInstance];
    
    
    itensHistorico2 = [vacinaManager obterHistoricoDaVacina:vacina];
    
    
    [tableView2 reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 2;
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
//    if (section == 0) {
//        return 40.0;
//    }
    if (section == 1) {
        return 300.0;
    }
    return 0.0;
}
- (CGFloat)tableView: (UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 40.0;
    }
    if (indexPath.section == 1){
//        return 40.0;
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
            DataTomVacinaViewController *ViewController = [[DataTomVacinaViewController alloc]initWithNibName:nil bundle:nil];
            ViewController.histVacina = histVacina;
//            UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            [[self navigationController] pushViewController:ViewController animated:YES];
        }
        if (indexPath.row == 1) {
            LocalVacinaViewController *ViewController = [[LocalVacinaViewController alloc]initWithNibName:nil bundle:nil];
            ViewController.histVacina = histVacina;
//            UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            [[self navigationController] pushViewController:ViewController animated:YES];
        }
        if (indexPath.row == 2) { //FREQUENCIA
            CampoViewController *campoViewController = [[CampoViewController alloc] init];
            campoViewController.refObjeto = histVacina;
            campoViewController.tipo = @"unidadeDeTempo";
            campoViewController.nomeAtributo = @"frequencia";
            campoViewController.title = @"Frequência";
            [[self navigationController] pushViewController:campoViewController animated:YES];
        }
        if (indexPath.row == 3) { //DURACAO
            CampoViewController *campoViewController = [[CampoViewController alloc] init];
            campoViewController.refObjeto = histVacina;
            campoViewController.tipo = @"unidadeDeTempo";
            campoViewController.nomeAtributo = @"duracao";
            campoViewController.title = @"Duração";
            [[self navigationController] pushViewController:campoViewController animated:YES];
        }
        if (indexPath.row == 4) {
            ListaPerfilViewController *perfilViewController = [[ListaPerfilViewController alloc] init];
            
            perfilViewController.modoTela = @"telaSelecionarPerfil";
            perfilViewController.refObjetoSelecionarPerfil = histVacina;
            
            [[self navigationController] pushViewController:perfilViewController animated:YES];
        }
        
        
    }
    
    
    
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //    NSInteger numRows = itensHistoricoConvenio.count;
    // Return the number of rows in the section.
    switch (section) {
        case 0:
            return 5;
            break;
        case 1:
            return 0; //of rows in section;
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
    UnidadeDeTempoManager *managerTempo = [UnidadeDeTempoManager sharedInstance];
    
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    
    if(indexPath.section == 0){
        if (indexPath.row == 0) {
            
            NSString *title = @"Data Tomada ";
            [[cell textLabel] setText:title];
            NSDateFormatter *dateFormatter;
            dateFormatter = [MMNSDateFormater criarDateFormatter];
            
            dataTomada = [NSString stringWithFormat:@"%@",
                          [dateFormatter stringFromDate:histVacina.dataInicio]];
            [[cell detailTextLabel] setText:dataTomada];
            if (histVacina.dataInicio == nil) {
                NSDateFormatter *dateFormatter2;
                dateFormatter2 = [MMNSDateFormater criarDateFormatter];
                
                [[cell detailTextLabel] setText: [NSString stringWithFormat:@"%@",
                                                  [dateFormatter2 stringFromDate:[NSDate date]]]];
            }
            cell.textLabel.textColor = [UIColor colorWithRed:84/255.0f green:84/255.0f blue:84/255.0f alpha:1];
            cell.textLabel.highlightedTextColor = [UIColor whiteColor];
        }
        if(indexPath.row == 1){
            NSString *title = @"Local ";
            
            [[cell textLabel] setText:title];
            [[cell detailTextLabel] setText:histVacina.local];
            cell.textLabel.textColor = [UIColor colorWithRed:84/255.0f green:84/255.0f blue:84/255.0f alpha:1];
            cell.textLabel.highlightedTextColor = [UIColor whiteColor];
        }
        if(indexPath.row == 2){
            NSString *title = @"Frequência ";
            [[cell textLabel] setText:title];
            [[cell detailTextLabel] setText:[managerTempo criarLabel:histVacina.frequencia]];
            cell.textLabel.textColor = [UIColor colorWithRed:84/255.0f green:84/255.0f blue:84/255.0f alpha:1];
            cell.textLabel.highlightedTextColor = [UIColor whiteColor];
        }
        if(indexPath.row == 3){
            NSString *title = @"Duração";
            [[cell textLabel] setText:title];
            [[cell detailTextLabel] setText:[managerTempo criarLabel:histVacina.duracao]];
            cell.textLabel.textColor = [UIColor colorWithRed:84/255.0f green:84/255.0f blue:84/255.0f alpha:1];
            cell.textLabel.highlightedTextColor = [UIColor whiteColor];
        }
        if(indexPath.row == 4){
            NSString *title = @"Associar à um Perfil";
            
            
            
            [[cell textLabel] setText:title];
            [[cell detailTextLabel] setText:[NSString stringWithFormat:@"%@",histVacina.pessoa.nome]];
            if (histVacina.pessoa.nome == nil) {
                [[cell detailTextLabel] setText:@"Sem Nome"];
            }
            
            NSLog(@"%@", histVacina.pessoa.cor);
            
            PessoaManager *managerPessoa = [PessoaManager sharedInstance];
            
            UIView *imagemtest = [managerPessoa criarViewCorBolinhaDaPessoa:histVacina.pessoa naPosicao:CGPointMake(180, 10)];
            
            if (histVacina.pessoa.cor == nil) {
                [[cell detailTextLabel] setText:@"Não possui cor"];
            }else{
                [[cell contentView] addSubview:imagemtest];
            }
            
            
            
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
    VacinaManager *manager = [VacinaManager sharedInstance];
    [manager deletarHistoricoVacina:histVacina];
    
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

- (void)tableViewReloadData:(NSNotification *)notification {
    [tableView2 reloadData];
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
