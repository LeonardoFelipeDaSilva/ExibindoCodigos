//
//  ExameViewController.m
//  Projeto Final
//
//  Created by Leonardo Felipe da Silva on 17/10/14.
//  Copyright (c) 2014 Mack Mobile - BEPiD. All rights reserved.
//

#import "ExameViewController.h"
#import "NomeExameTableViewController.h"
#import "NomeMedicoTableViewController.h"
#import "LocalExameTableViewController.h"
#import "DataExameViewController.h"
#import "ListaPerfilViewController.h"
#import "PessoaManager.h"
#import "FotoManager.h"
#import "Medico.h"
#import "MedicoManager.h"
@interface ExameViewController ()

@end

@implementation ExameViewController

@synthesize exame, tableView2, dataExame, imageView, medico;
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
    
    
    
    ExameManager *manager = [ExameManager sharedInstance];
    
    
    
    if (!exame) {
        exame = [manager criarExame];
        UIBarButtonItem *saveButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(adicionar:)];
        
        [[self navigationItem] setRightBarButtonItem:saveButton];
        
        UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelar:)];
        
        [[self navigationItem] setLeftBarButtonItem:cancelButton];
        [self setTitle:@"Novo Exame"];
    } else {
        [self setTitle:exame.titulo];
    }
    
    
    tableView2 = [[UITableView alloc]init];
    [tableView2 setFrame:CGRectMake(self.view.window.bounds.origin.x, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [tableView2 setDelegate:self];
    [tableView2 setDataSource:self];
    UIView *viewTableView = [self criarView:0];
    [viewTableView setFrame:CGRectMake(viewTableView.frame.origin.x, viewTableView.frame.origin.y, viewTableView.frame.size.width, viewTableView.frame.size.height + tableView2.frame.size.height)];
    [viewTableView addSubview:tableView2];
    
    [self setContentSizeScrollView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(atualizarImagemImageView:) name:@"atualizarImagemImageView" object:nil];
    // Do any additional setup after loading the view.
    
}

- (void)viewDidAppear:(BOOL)animated
{
    ExameManager *manager = [ExameManager sharedInstance];
    
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
        return 10.0;
    }
    if (section == 1) {
        return 30.0;
    }
    if (section == 2) {
        return 0.0;
    }
    return 0.0;
}
- (CGFloat)tableView: (UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 40.0;
    }
    if (indexPath.section == 1){
        return 300.0;
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
            NomeExameTableViewController *viewController = [[NomeExameTableViewController alloc]initWithNibName:nil bundle:nil];
            //            UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            viewController.exame = exame;
            [[self navigationController] pushViewController:viewController animated:YES];
        }
        if (indexPath.row == 1) {
            NomeMedicoTableViewController *viewController = [[NomeMedicoTableViewController alloc]initWithNibName:nil bundle:nil];
            //            UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            viewController.exame = exame;
            [[self navigationController] pushViewController:viewController animated:YES];
        }
        if (indexPath.row == 3) {
            DataExameViewController *viewController = [[DataExameViewController alloc]initWithNibName:nil bundle:nil];
            //            UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            viewController.exame = exame;
            [[self navigationController] pushViewController:viewController animated:YES];
        }
        if (indexPath.row == 2) {
            LocalExameTableViewController *viewController = [[LocalExameTableViewController alloc]initWithNibName:nil bundle:nil];
            //            UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            viewController.exame = exame;
            [[self navigationController] pushViewController:viewController animated:YES];
        }
        if (indexPath.row == 4) {
            ListaPerfilViewController *perfilViewController = [[ListaPerfilViewController alloc] init];
            
            perfilViewController.modoTela = @"telaSelecionarPerfil";
            perfilViewController.refObjetoSelecionarPerfil = exame;
            
            [[self navigationController] pushViewController:perfilViewController animated:YES];

        }
    }
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
//            SintomasDaOcorViewController *ViewController = [[SintomasDaOcorViewController alloc]initWithNibName:nil bundle:nil];
//            ViewController.ocorrencia = ocorrencia;
//            
//            [[self navigationController] pushViewController:ViewController animated:YES];
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
            return 1; //of rows in section;
            break;
        case 2:
            return 0;
            break;
    }
    return 0;
}

- (UITableViewCell *)tableView: (UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *CellIdentifier = @"celula";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
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
            [[cell detailTextLabel] setText:exame.titulo];
            cell.textLabel.textColor = [UIColor colorWithRed:84/255.0f green:84/255.0f blue:84/255.0f alpha:1];
            cell.textLabel.highlightedTextColor = [UIColor whiteColor];
            
        }
        if(indexPath.row == 1){
            NSString *title = @"Médico";
            [[cell textLabel] setText:title];
            [[cell detailTextLabel] setText:exame.medico.nome];
            cell.textLabel.textColor = [UIColor colorWithRed:84/255.0f green:84/255.0f blue:84/255.0f alpha:1];
            cell.textLabel.highlightedTextColor = [UIColor whiteColor];
        }
        if(indexPath.row == 2){
            NSString *title = @"Local";
            [[cell textLabel] setText:title];
            [[cell detailTextLabel] setText:exame.local];
            cell.textLabel.textColor = [UIColor colorWithRed:84/255.0f green:84/255.0f blue:84/255.0f alpha:1];
            cell.textLabel.highlightedTextColor = [UIColor whiteColor];
        }
        if(indexPath.row == 3){
            NSString *title = @"Data";
            [[cell textLabel] setText:title];
            NSDateFormatter *dateFormatter;
            dateFormatter = [MMNSDateFormater criarDateFormatter];
            
            dataExame = [NSString stringWithFormat:@"%@",
                         [dateFormatter stringFromDate:exame.data]];
            [[cell detailTextLabel] setText:dataExame];
            if (exame.data == nil) {
                NSDateFormatter *dateFormatter2;
                dateFormatter2 = [MMNSDateFormater criarDateFormatter];
                
                [[cell detailTextLabel] setText: [NSString stringWithFormat:@"%@",
                                                  [dateFormatter2 stringFromDate:[NSDate date]]]];
            }
            
            cell.textLabel.textColor = [UIColor colorWithRed:84/255.0f green:84/255.0f blue:84/255.0f alpha:1];
            cell.textLabel.highlightedTextColor = [UIColor whiteColor];
        }

        if(indexPath.row == 4){
            NSString *title = @"Cor Perfil";
            
            
            [[cell textLabel] setText:title];
            
            
            PessoaManager *managerPessoa = [PessoaManager sharedInstance];
            
            UIView *imagemtest = [managerPessoa criarViewCorBolinhaDaPessoa:exame.pessoa naPosicao:CGPointMake(270, 10)];
            
            if (exame.pessoa.nome == nil) {
                [[cell detailTextLabel] setText:@"Sem Nome"];
            }else{
                [[cell detailTextLabel] setText:exame.pessoa.nome];
            }
            
            if (exame.pessoa.cor == nil) {
                [[cell detailTextLabel] setText:@"Sem cor"];
            }else{
                [[cell contentView] addSubview:imagemtest];
            }
            
            
            cell.textLabel.textColor = [UIColor colorWithRed:84/255.0f green:84/255.0f blue:84/255.0f alpha:1];
            cell.textLabel.highlightedTextColor = [UIColor whiteColor];
        }
        
    }else if(indexPath.section == 1){
        if (indexPath.row == 0) {
            UIView *view = [[UIView alloc] init];
            [view setFrame:CGRectMake(0, 0, cell.frame.size.width, 170)];
            imageView = [MMImageView criarObjetoRetangulo:CGRectMake(0, 0, self.tableView2.frame.size.width, 385)];
            
            [view addSubview:imageView];
            
            MMTapGestureRecognizer *tapGestureRecognizer = [[MMTapGestureRecognizer alloc] init];
            tapGestureRecognizer.objeto = imageView;
            [tapGestureRecognizer addTarget:self action:@selector(toqueImageView:)];
            [view addGestureRecognizer:tapGestureRecognizer];
            [[cell contentView] addSubview:view];
            
            [cell setAccessoryType:UITableViewCellAccessoryNone];
            
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
    ExameManager *manager = [ExameManager sharedInstance];
    [manager deletarExame:exame];
    
    [self removerTela];
}



- (void)adicionar:(id)sender
{
    ExameManager *manager = [ExameManager sharedInstance];
    [manager saveContext];
    
    [self removerTela];
}

- (void)removerTela
{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    
    //chamando o método do NotificationCenter para atualizar a tableView
    [[NSNotificationCenter defaultCenter] postNotificationName:@"atualizarTableView" object:nil];
}

- (void)atualizarImagemImageView:(NSNotification *)notification {
    UIImageView *imageViewNot = (UIImageView *)notification.object;
    
    if ([imageViewNot isEqual:imageView]) {
        imageViewNot.image = imageView.image;
        
        
        NSData *foto = UIImageJPEGRepresentation(imageView.image, 1.0);
        
        FotoManager *managerFoto = [FotoManager sharedInstance];
        [exame addFotosObject:[managerFoto inserirFoto:foto]];
        //        NSLog(@"%lu %lu", (unsigned long)remedio.foto.length, (unsigned long)foto.length);
    }
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
