//
//  CadastroPrescricaoMedViewController.m
//  Projeto Final
//
//  Created by Leonardo Felipe da Silva on 01/10/14.
//  Copyright (c) 2014 Mack Mobile - BEPiD. All rights reserved.
//

#import "CadastroPrescricaoMedViewController.h"
#import "DataPresicaoViewControllerTableViewController.h"
#import "TituloPrescViewController.h"
#import "ListaPerfilViewController.h"
#import "FotoManager.h"

@interface CadastroPrescricaoMedViewController ()

@end

@implementation CadastroPrescricaoMedViewController
@synthesize prescicao, dataPrescicao, tableView2, imageView;

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
    
    
    
    PrescicaoMedManager *prescicaoManager = [PrescicaoMedManager sharedInstance];
   
    
    
    if (!prescicao) {
        prescicao = [prescicaoManager criarPrescricao];
        [self setTitle:@"Nova Prescição"];
        UIBarButtonItem *saveButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(adicionar:)];
        
        [[self navigationItem] setRightBarButtonItem:saveButton];
        
        UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelar:)];
        
        [[self navigationItem] setLeftBarButtonItem:cancelButton];
    } else {
        [self setTitle:prescicao.titulo];
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
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(atualizarImagemImageView:) name:@"atualizarImagemImageView" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tableViewReloadData:) name:@"atualizarTableView" object:nil];
}

- (void)viewDidAppear:(BOOL)animated
{
    PrescicaoMedManager *prescicaoManager = [PrescicaoMedManager sharedInstance];
   
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
        return @" Foto ";
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
        return 385.0;
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
        if (indexPath.row == 1) {
            DataPresicaoViewControllerTableViewController *viewController = [[DataPresicaoViewControllerTableViewController alloc]initWithNibName:nil bundle:nil];
            //            UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            viewController.prescicaoData = prescicao;
            [[self navigationController] pushViewController:viewController animated:YES];
        }
        
        if (indexPath.row == 0) {
            TituloPrescViewController *ViewController = [[TituloPrescViewController alloc]initWithNibName:nil bundle:nil];
            ViewController.prescricao = prescicao;
            
            [[self navigationController] pushViewController:ViewController animated:YES];
        }
        if (indexPath.row == 2) {
            ListaPerfilViewController *perfilViewController = [[ListaPerfilViewController alloc] init];
            
            perfilViewController.modoTela = @"telaSelecionarPerfil";
            perfilViewController.refObjetoSelecionarPerfil = prescicao;
            
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
        if(indexPath.row == 1){
            NSString *title = @"Data da prescrição ";
            [[cell textLabel] setText:title];
            NSDateFormatter *dateFormatter;
            dateFormatter = [MMNSDateFormater criarDateFormatter];
            
            dataPrescicao = [NSString stringWithFormat:@"%@",
                          [dateFormatter stringFromDate:prescicao.data]];
            [[cell detailTextLabel] setText:dataPrescicao];
            if (prescicao.data == nil) {
                NSDateFormatter *dateFormatter2;
                dateFormatter2 = [MMNSDateFormater criarDateFormatter];
                
                [[cell detailTextLabel] setText: [NSString stringWithFormat:@"%@",
                                                  [dateFormatter2 stringFromDate:[NSDate date]]]];
            }
            
            cell.textLabel.textColor = [UIColor colorWithRed:84/255.0f green:84/255.0f blue:84/255.0f alpha:1];
            cell.textLabel.highlightedTextColor = [UIColor whiteColor];
        }
        if(indexPath.row == 0){
            NSString *title = @"Titulo ";
            [[cell textLabel] setText:title];
            [[cell detailTextLabel] setText:prescicao.titulo];
            cell.textLabel.textColor = [UIColor colorWithRed:84/255.0f green:84/255.0f blue:84/255.0f alpha:1];
            cell.textLabel.highlightedTextColor = [UIColor whiteColor];
        }
        if(indexPath.row == 2){
            NSString *title = @"Associar à um Perfil";
            
            
            
            [[cell textLabel] setText:title];
            
            PessoaManager *managerPessoa = [PessoaManager sharedInstance];
            
            UIView *imagemtest = [managerPessoa criarViewCorBolinhaDaPessoa:prescicao.pessoa naPosicao:CGPointMake(180, 10)];
            
            if (prescicao.pessoa.nome == nil) {
                [[cell detailTextLabel] setText:@"Sem Nome"];
            }else{
                [[cell detailTextLabel] setText:prescicao.pessoa.nome];
            }
            
            if (prescicao.pessoa.cor == nil) {
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
- (void)adicionar:(id)sender
{
    PrescicaoMedManager *manager = [PrescicaoMedManager sharedInstance];
    
    
    [manager saveContext];
     [self removerTela];
//    [self salvarPrescicao:sender];
}


- (void)cancelar:(id)sender
{
    PrescicaoMedManager *manager = [PrescicaoMedManager sharedInstance];
    [manager deletarPrescicao:prescicao];
    [self removerTela];

}
- (void)tableViewReloadData:(NSNotification *)notification {
    [tableView2 reloadData];
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
        [prescicao addFotosObject:[managerFoto inserirFoto:foto]];
        //        NSLog(@"%lu %lu", (unsigned long)remedio.foto.length, (unsigned long)foto.length);
    }
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
