//
//  ConsultaViewController.m
//  Projeto Final
//
//  Created by Leonardo Felipe da Silva on 12/7/14.
//  Copyright (c) 2014 Mack Mobile - BEPiD. All rights reserved.
//

#import "ConsultaViewController.h"
#import "PessoaManager.h"
#import "ListaPerfilViewController.h"
#import "Medico.h"
#import "TipoConsultaViewController.h"
#import "NomeMedicoConsultaTableViewController.h"
#import "DataConsultaTableViewController.h"
#import "AnotacoesConsultaViewController.h"


@interface ConsultaViewController ()

@end

@implementation ConsultaViewController

@synthesize consulta, tableView2, dataConsulta, imageView, medico;
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
    
    
    
    ConsultaManager *manager = [ConsultaManager sharedInstance];
    
    
    
    if (!consulta) {
        consulta = [manager criarConsulta];
        UIBarButtonItem *saveButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(adicionar:)];
        
        [[self navigationItem] setRightBarButtonItem:saveButton];
        
        UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelar:)];
        
        [[self navigationItem] setLeftBarButtonItem:cancelButton];
        [self setTitle:@"Nova Consulta"];
    } else {
        [self setTitle:consulta.titulo];
    }
    
    
    tableView2 = [[UITableView alloc]init];
    [tableView2 setFrame:CGRectMake(self.view.window.bounds.origin.x, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [tableView2 setDelegate:self];
    [tableView2 setDataSource:self];
    UIView *viewTableView = [self criarView:0];
    [viewTableView setFrame:CGRectMake(viewTableView.frame.origin.x, viewTableView.frame.origin.y, viewTableView.frame.size.width, viewTableView.frame.size.height + tableView2.frame.size.height)];
    [viewTableView addSubview:tableView2];
    
    [self setContentSizeScrollView];
    
   
    // Do any additional setup after loading the view.
    
}

- (void)viewDidAppear:(BOOL)animated
{
//    ExameManager *manager = [ExameManager sharedInstance];
    
    [tableView2 reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 4;
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
        return 10.0;
    }
    if (section == 1) {
        return 30.0;
    }
    if (section == 2) {
        return 30.0;
    }
    return 200.0;
}
- (CGFloat)tableView: (UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 40.0;
    }
    if (indexPath.section == 1){
        return 200.0;
    }
    if (indexPath.section == 2) {
        return 40.0;
    }
    return 10.0;
    
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
            TipoConsultaViewController *viewController = [[TipoConsultaViewController alloc]initWithNibName:nil bundle:nil];
            //            UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            viewController.consulta = consulta;
            [[self navigationController] pushViewController:viewController animated:YES];
        }
        if (indexPath.row == 1) {
            NomeMedicoConsultaTableViewController *viewController = [[NomeMedicoConsultaTableViewController alloc]initWithNibName:nil bundle:nil];
            //            UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            viewController.consulta = consulta;
            [[self navigationController] pushViewController:viewController animated:YES];
        }
        if (indexPath.row == 2) {
            DataConsultaTableViewController *viewController = [[DataConsultaTableViewController alloc]initWithNibName:nil bundle:nil];
            //            UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            viewController.consulta = consulta;
            [[self navigationController] pushViewController:viewController animated:YES];
        }
    }
        if (indexPath.section == 1) {
            if (indexPath.row == 0) {
                AnotacoesConsultaViewController *viewController = [[AnotacoesConsultaViewController alloc]initWithNibName:nil bundle:nil];
                viewController.consulta = consulta;
                 [[self navigationController] pushViewController:viewController animated:YES];
            }
        }
        
        if (indexPath.section == 2) {
        if (indexPath.row == 0) {
            ListaPerfilViewController *perfilViewController = [[ListaPerfilViewController alloc] init];
            
            perfilViewController.modoTela = @"telaSelecionarPerfil";
            perfilViewController.refObjetoSelecionarPerfil = consulta;
            
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
            return 3;
            break;
        case 1:
            return 1; //of rows in section;
            break;
        case 2:
            return 1;
            break;
    }
    return 0;
}

- (UITableViewCell *)tableView: (UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *CellIdentifier = @"celula";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:nil];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    }
    // Configure the cell...
    [cell setBackgroundColor: [UIColor clearColor]];
    
    
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    
    if (indexPath.section == 0) {
        if(indexPath.row == 0){
            NSString *title = @"Tipo";
            [[cell textLabel] setText:title];
            [[cell detailTextLabel] setText:consulta.titulo];
            cell.textLabel.textColor = [UIColor colorWithRed:84/255.0f green:84/255.0f blue:84/255.0f alpha:1];
            cell.textLabel.highlightedTextColor = [UIColor whiteColor];
            
        }
        if(indexPath.row == 1){
            NSString *title = @"Médico";
            [[cell textLabel] setText:title];
            [[cell detailTextLabel] setText:consulta.medico.nome];
            cell.textLabel.textColor = [UIColor colorWithRed:84/255.0f green:84/255.0f blue:84/255.0f alpha:1];
            cell.textLabel.highlightedTextColor = [UIColor whiteColor];
        }
        if(indexPath.row == 2){
            NSString *title = @"Data";
            [[cell textLabel] setText:title];
            NSDateFormatter *dateFormatter;
            dateFormatter = [MMNSDateFormater criarDateFormatter];
            
            dataConsulta = [NSString stringWithFormat:@"%@",
                         [dateFormatter stringFromDate:consulta.data]];
            [[cell detailTextLabel] setText:dataConsulta];
            if (consulta.data == nil) {
                NSDateFormatter *dateFormatter2;
                dateFormatter2 = [MMNSDateFormater criarDateFormatter];
                
                [[cell detailTextLabel] setText: [NSString stringWithFormat:@"%@",
                                                  [dateFormatter2 stringFromDate:[NSDate date]]]];
            }
            
            cell.textLabel.textColor = [UIColor colorWithRed:84/255.0f green:84/255.0f blue:84/255.0f alpha:1];
            cell.textLabel.highlightedTextColor = [UIColor whiteColor];
        }
    }
    if(indexPath.section == 1){
          if (indexPath.row == 0) {
            
            UILabel *anotacoes = [[UILabel alloc]init];
            anotacoes.frame = CGRectMake(cell.frame.origin.x+10, cell.frame.origin.y + 10, cell.frame.size.width, 30);
            
            UITextView *anotacoesView = [[UITextView alloc]init];
            anotacoesView.frame = CGRectMake(anotacoes.frame.origin.x, anotacoes.frame.origin.y + anotacoes.frame.size.height, cell.contentView.frame.size.width - 40, 170);
              anotacoesView.editable = NO;
            NSString *title = @"Anotações adicionais";
            anotacoes.text = title;
            anotacoesView.textAlignment = NSTextAlignmentJustified;
            
            anotacoesView.text = consulta.anotacoes;
            [[cell contentView] addSubview:anotacoes];
            [[cell contentView] addSubview:anotacoesView];
            anotacoes.textColor =[UIColor colorWithRed:84/255.0f green:84/255.0f blue:84/255.0f alpha:1];
            anotacoes.highlightedTextColor = [UIColor whiteColor];
          }
        }
    
    if (indexPath.section == 2){
        if(indexPath.row == 0){
//            NSString *title =;
            
            
            [[cell textLabel] setText: @"Cor Perfil"];

            
            PessoaManager *managerPessoa = [PessoaManager sharedInstance];
            
            UIView *imagemtest = [managerPessoa criarViewCorBolinhaDaPessoa:consulta.pessoa naPosicao:CGPointMake(270, 10)];
            
            if (consulta.pessoa.nome == nil) {
                [[cell detailTextLabel] setText:@"Sem Nome"];
            }else{
                [[cell detailTextLabel] setText:consulta.pessoa.nome];
            }
            
            if (consulta.pessoa.cor == nil) {
                [[cell detailTextLabel] setText:@"Sem cor"];
            }else{
//                [[cell contentView] addSubview:imagemtest];
                [cell setAccessoryView:imagemtest];
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
    ConsultaManager *manager = [ConsultaManager sharedInstance];
    [manager deletarConsulta:consulta];
    
    [self removerTela];
}



- (void)adicionar:(id)sender
{
    ConsultaManager *manager = [ConsultaManager sharedInstance];
    [manager saveContext];
    
    [self removerTela];
}

- (void)removerTela
{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    
    //chamando o método do NotificationCenter para atualizar a tableView
    [[NSNotificationCenter defaultCenter] postNotificationName:@"atualizarTableViewReloadData" object:nil];
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
