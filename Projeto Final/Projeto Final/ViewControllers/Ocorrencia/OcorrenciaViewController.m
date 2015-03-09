//
//  OcorrenciaViewController.m
//  Projeto Final
//
//  Created by Leonardo Felipe da Silva on 01/10/14.
//  Copyright (c) 2014 Mack Mobile - BEPiD. All rights reserved.
//

#import "OcorrenciaViewController.h"
#import "NomeOcorrenciaViewController.h"
#import "SintomasDaOcorViewController.h"
#import "DataOcorrenciaViewController.h"
#import "ListaPerfilViewController.h"

@interface OcorrenciaViewController ()

@end

@implementation OcorrenciaViewController
@synthesize ocorrencia, tableView2, dataOcorrencia, tableViewSint, btn, slider, flag, max, min, label1;
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
    
    
    
    OcorrenciaManager *ocorrenciaManager = [OcorrenciaManager sharedInstance];
    
    
    
    if (!ocorrencia) {
        ocorrencia = [ocorrenciaManager criarOcorrencia];
        UIBarButtonItem *saveButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(adicionar:)];
        
        [[self navigationItem] setRightBarButtonItem:saveButton];
        
        UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelar:)];
        
        [[self navigationItem] setLeftBarButtonItem:cancelButton];
        [self setTitle:@"Nova Ocorrência"];
    } else {
        [self setTitle:ocorrencia.titulo];
    }
    
   
    btn = [[UISwitch alloc] init];
    slider = [[UISlider alloc]initWithFrame:CGRectMake((self.view.frame.size.width - 200)/2 , 20, 200, 30)];
    [slider addTarget:self action:@selector(mudouSlider:) forControlEvents:UIControlEventAllEvents];
    
    tableView2 = [[UITableView alloc]init];
    [tableView2 setFrame:CGRectMake(self.view.window.bounds.origin.x, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [tableView2 setDelegate:self];
    [tableView2 setDataSource:self];
    UIView *viewTableView = [self criarView:0];
    [viewTableView setFrame:CGRectMake(viewTableView.frame.origin.x, viewTableView.frame.origin.y, viewTableView.frame.size.width, viewTableView.frame.size.height + tableView2.frame.size.height)];
    [viewTableView addSubview:tableView2];
     label1.text = @"0";
    
    [self setContentSizeScrollView];
    // Do any additional setup after loading the view.
    
}

- (void)viewDidAppear:(BOOL)animated
{
    OcorrenciaManager *ocorrenciaManager = [OcorrenciaManager sharedInstance];
    
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
        if (indexPath.row == 3) {
            return 55.0;
        } else {
            return 40.0;
        }
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
            NomeOcorrenciaViewController *viewController = [[NomeOcorrenciaViewController alloc]initWithNibName:nil bundle:nil];
            //            UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            viewController.ocorrencia = ocorrencia;
            [[self navigationController] pushViewController:viewController animated:YES];
        }
        if (indexPath.row == 1) {
            DataOcorrenciaViewController *viewController = [[DataOcorrenciaViewController alloc]initWithNibName:nil bundle:nil];
            //            UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            viewController.ocorrencia = ocorrencia;
            [[self navigationController] pushViewController:viewController animated:YES];
        }
    }
        if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            
//            viewControllerSintomas = [[SintomasDaOcorViewController alloc]initWithOcorrencia];
//            tableViewSint = [[UITableView alloc]initWithFrame:CGRectMake(self.view.frame.origin.x + 10, self.view.frame.origin.y + 10, self.view.frame.size.width - 30, self.view.frame.size.height - 30)];
//            [tableViewSint setDelegate:viewControllerSintomas];
//            [tableViewSint setDataSource:viewControllerSintomas];
//            [self.view addSubview: tableViewSint];
            
//            
            SintomasDaOcorViewController *ViewController = [[SintomasDaOcorViewController alloc]initWithNibName:nil bundle:nil];
            ViewController.ocorrencia = ocorrencia;
            
            [[self navigationController] pushViewController:ViewController animated:YES];
        }
        
    }
     if(indexPath.section == 2)
     {
         if (indexPath.row == 0) {
             ListaPerfilViewController *perfilViewController = [[ListaPerfilViewController alloc] init];
             
             perfilViewController.modoTela = @"telaSelecionarPerfil";
             perfilViewController.refObjetoSelecionarPerfil = ocorrencia;
             
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
            if (flag == 0) {
                NSLog(@"flag%d", flag);
                return 3;
            }
            return flag + 2;
            break;
        case 1:
            return 1;
             //of rows in section;
            break;
        case 2:
            return 1;
            break;
        case 3:
            return 0;
            break;
    }
    return 0;
}

- (UITableViewCell *)tableView: (UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *CellIdentifier = @"celulaOcorrencia";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
    }
    // Configure the cell...
    [cell setBackgroundColor: [UIColor clearColor]];
    
    
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    
    if (indexPath.section == 0) {
        if(indexPath.row == 1){
            NSString *title = @"Data da ocorrência";
            [[cell textLabel] setText:title];
            NSDateFormatter *dateFormatter;
            dateFormatter = [MMNSDateFormater criarDateFormatter];
            
            dataOcorrencia = [NSString stringWithFormat:@"%@",
                             [dateFormatter stringFromDate:ocorrencia.data]];
            [[cell detailTextLabel] setText:dataOcorrencia];
            if (ocorrencia.data == nil) {
                NSDateFormatter *dateFormatter2;
                dateFormatter2 = [MMNSDateFormater criarDateFormatter];
                
                [[cell detailTextLabel] setText: [NSString stringWithFormat:@"%@",
                                                  [dateFormatter2 stringFromDate:[NSDate date]]]];
            }
            
            cell.textLabel.textColor = [UIColor colorWithRed:84/255.0f green:84/255.0f blue:84/255.0f alpha:1];
            cell.textLabel.highlightedTextColor = [UIColor whiteColor];
        }
        if(indexPath.row == 0){
            NSString *title = @"Nome Ocorrencia";
            [[cell textLabel] setText:title];
            [[cell detailTextLabel] setText:ocorrencia.titulo];
            cell.textLabel.textColor = [UIColor colorWithRed:84/255.0f green:84/255.0f blue:84/255.0f alpha:1];
            cell.textLabel.highlightedTextColor = [UIColor whiteColor];
        }
        if(indexPath.row == 2){
            NSString *title = @"Intensidade";
            [[cell textLabel] setText:title];
            //            [[cell detailTextLabel] setText:(NSString *)histAlergia.intensidade];
            cell.textLabel.textColor = [UIColor colorWithRed:84/255.0f green:84/255.0f blue:84/255.0f alpha:1];
            cell.textLabel.highlightedTextColor = [UIColor whiteColor];
            [btn setFrame:CGRectMake(250, 5, 70, 30)];
            [btn addTarget:self action:@selector(switchMudarCelula:) forControlEvents:UIControlEventValueChanged];
            [cell.contentView addSubview:btn];
            [cell setAccessoryType:UITableViewCellAccessoryNone];
            
            
                  }
        
        if (indexPath.row == 3) {
            if (flag == 2) {
                
                
                [cell.contentView addSubview:slider];
                [cell setAccessoryType:UITableViewCellAccessoryNone];
                
                label1 = [[UILabel alloc] init];
                 label1.text = @"0";
                label1.textAlignment = UITextAlignmentCenter;
                [label1 setFont:[UIFont fontWithName:@"Arial" size:14.0]];
                [label1 setFrame:CGRectMake(110  - (label1.frame.size.width/2) , 2, 100, 20)];
                [label1 setBackgroundColor:[UIColor clearColor]];
                
            
                min = [UIButton buttonWithType: UIButtonTypeCustom];
                [min setTitle:@"-" forState:UIControlStateNormal];
                [min setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//                [min setBackgroundColor:[UIColor grayColor]];
                [min setFrame:CGRectMake(15, 20, 30, 30)];
                [min addTarget:self action:@selector(subIntensidade:) forControlEvents:UIControlEventTouchDown];
                
                max = [UIButton buttonWithType:UIButtonTypeCustom];
                [max setTitle:@"+" forState:UIControlStateNormal];
                [max setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//                [max setBackgroundColor:[UIColor grayColor]];
                [max setFrame:CGRectMake(275, 20, 30, 30)];
                [max addTarget:self action:@selector(addIntensidade:) forControlEvents:UIControlEventTouchDown];
                
                [cell addSubview:label1];
                [cell addSubview: min];
                [cell addSubview:max];

            }
        }
        
    }else if(indexPath.section == 1){
        if (indexPath.row == 0) {
            
            UILabel *sintomas = [[UILabel alloc]init];
            sintomas.frame = CGRectMake(cell.frame.origin.x+10, cell.frame.origin.y + 10, cell.frame.size.width, 30);
            
            UITextView *sintomasView = [[UITextView alloc]init];
            sintomasView.frame = CGRectMake(sintomas.frame.origin.x, sintomas.frame.origin.y + sintomas.frame.size.height, cell.contentView.frame.size.width - 40, 200);
            NSString *title = @"Sintomas da Ocorrencia";
            sintomas.text = title;
            sintomasView.textAlignment = NSTextAlignmentJustified;
            
            sintomasView.text = ocorrencia.sintomas;
            [[cell contentView] addSubview:sintomas];
            [[cell contentView] addSubview:sintomasView];
            sintomas.textColor =[UIColor colorWithRed:84/255.0f green:84/255.0f blue:84/255.0f alpha:1];
            sintomas.highlightedTextColor = [UIColor whiteColor];
        }
        
    }else if (indexPath.section == 2){
        if(indexPath.row == 0){
            NSString *title = @"Associar à um Perfil";
            
            
            
            [[cell textLabel] setText:title];
          
            
            PessoaManager *managerPessoa = [PessoaManager sharedInstance];
            
            UIView *imagemtest = [managerPessoa criarViewCorBolinhaDaPessoa:ocorrencia.pessoa naPosicao:CGPointMake(180, 10)];
            
            if (ocorrencia.pessoa.nome == nil) {
                [[cell detailTextLabel] setText:@"Sem Nome"];
            }else{
                [[cell detailTextLabel] setText:ocorrencia.pessoa.nome];
            }
            
            if (ocorrencia.pessoa.cor == nil) {
                [[cell detailTextLabel] setText:@"Sem cor"];
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
    OcorrenciaManager *manager = [OcorrenciaManager sharedInstance];
    [manager deletarOcorrencia:ocorrencia];
    
    [self removerTela];
}



- (void)adicionar:(id)sender
{
    OcorrenciaManager *manager = [OcorrenciaManager sharedInstance];
    [manager saveContext];
    
    [self removerTela];
}

- (void)removerTela
{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    
    //chamando o método do NotificationCenter para atualizar a tableView
    [[NSNotificationCenter defaultCenter] postNotificationName:@"atualizarTableView" object:nil];
}

- (void)switchMudarCelula:(id)sender
{
    if ([sender isOn]) {
        flag = 2;
        
    }else{
        flag = 1;
        
       
        
    }
    [tableView2 reloadData];
    
}

- (void)mudouSlider:(id)sender
{
    label1.text = [NSString stringWithFormat:@"%0.f", slider.value *10];
    label1.textAlignment = UITextAlignmentCenter;
    
}

-(void)addIntensidade: (id)sender{
    slider.value = slider.value + 0.1;
    [self mudouSlider:nil];
  
}

-(void)subIntensidade: (id)sender{
    slider.value = slider.value - 0.1;
    [self mudouSlider:nil];
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
