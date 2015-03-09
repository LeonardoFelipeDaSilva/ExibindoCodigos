//
//  ListaPrescricaoViewController.m
//  Projeto Final
//
//  Created by Leonardo Felipe da Silva on 01/10/14.
//  Copyright (c) 2014 Mack Mobile - BEPiD. All rights reserved.
//

#import "ListaPrescricaoViewController.h"
#import "CadastroPrescricaoMedViewController.h"
#import "PessoaManager.h"
#import "MostrarPrescriçãoViewController.h"


@interface ListaPrescricaoViewController ()

@end

@implementation ListaPrescricaoViewController

@synthesize viewControllerPai, nome, data, dataLabel;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        UIImage *image = [UIImage imageNamed:@"prescricao_line.png"];
        self.tabBarItem.image = [self imageWithImage:image scaledToSize:CGSizeMake(30, 30)];
        UIImage *imageSelect = [UIImage imageNamed:@"prescricao_color.png"];
        
        self.tabBarItem.selectedImage = [self imageWithImage:imageSelect scaledToSize:CGSizeMake(30, 30)];
        //        [[tabBarController.tabBar.items objectAtIndex:0] setImage:[UIImage imageNamed:@"remedio_line"] forState:UIControlStateDisabled];
        //        [[tabBarController.tabBar.items objectAtIndex:0] setImage:[UIImage imageNamed:@"remedio_color"] forState:UIControlStateSelected];
    }
    return self;
}


//- (id)initWithVacina:(Vacina *)vacina2
//    {
//        self = [super init];
//        
//        if (self) {
//            vacina2 = vacina;
//            [self atualizarItensHistorico];
//            [self carregarItens];
//        }
//        
//        return self;
//    }
//    
- (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize {
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}


- (void)carregarItens
{
    PrescicaoMedManager *prescicaoManager = [PrescicaoMedManager sharedInstance];
    prescicoes = [prescicaoManager obterPrescricao];
    [self.view setBackgroundColor:[UIColor colorWithRed:220/100.0f green:200/100.0f blue:238/20.0f alpha:0.6]];
    
    //adicionando as notificações para atualizar a tableView
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tableViewReloadData:) name:@"atualizarTableView" object:nil];
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        
        
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self carregarItens];
    
    
    
    [self setTitle:@"Prescrições"];
    
    UIBarButtonItem *barButtonAdd = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(adicionar:)];
    [[self navigationItem] setRightBarButtonItem:barButtonAdd];
    
    //background
   
}

- (void)viewDidAppear:(BOOL)animated {
    //Botão de Adicionar
    UIBarButtonItem *barButtonAdd = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(adicionar:)];
    
    [[[self tabBarController] navigationItem] setRightBarButtonItem:barButtonAdd];
//    [[self navigationItem] setRightBarButtonItem:barButtonAdd];
}

- (void)viewDidDisappear:(BOOL)animated {
    [[[self tabBarController] navigationItem] setRightBarButtonItem:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return prescicoes.count;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *reuseIdentifier = @"CelulaVacina";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:nil];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    }
    
    
    // Configure the cell...
    
    
    PrescricaoMed *prescicaoMed = [prescicoes objectAtIndex:indexPath.row];
    
    PessoaManager *managerPessoa = [PessoaManager sharedInstance];
    
    UIImage *imagem = [UIImage imageNamed:@"prescricao_me"];
    
    UIImageView *viewImagem = [[UIImageView alloc] init];
    [viewImagem setFrame:CGRectMake(10, 10, 60, 60)];
    [viewImagem setBackgroundColor:self.navigationController.navigationBar.barTintColor];
    viewImagem.layer.cornerRadius = viewImagem.frame.size.width/2;
    viewImagem.layer.borderWidth = 3.0f;
    viewImagem.layer.borderColor = ((UIColor*)prescicaoMed.pessoa.cor).CGColor;
    UIImageView *viewImagemReduzida = [[UIImageView alloc] init];
    [viewImagemReduzida setFrame:CGRectMake(viewImagem.frame.size.width/4, viewImagem.frame.size.height/4, viewImagem.frame.size.width/2, viewImagem.frame.size.height/2)];
    [viewImagemReduzida setImage:imagem];
    [viewImagem addSubview:viewImagemReduzida];
    
    [[cell contentView] addSubview:viewImagem];
    
    nome = [[UILabel alloc]init];
    nome.frame = CGRectMake(cell.frame.origin.x+viewImagem.frame.size.width + 20, cell.frame.origin.y+(cell.frame.size.height / 3), cell.frame.size.width - viewImagem.frame.size.width, cell.frame.size.height/3);
    [nome setText:prescicaoMed.titulo];
    
    data = [[UILabel alloc]init];
    data.frame = CGRectMake(cell.frame.origin.x+viewImagem.frame.size.width + 20, nome.frame.size.height + cell.frame.size.height/(cell.frame.size.height / 30), cell.frame.size.width - viewImagem.frame.size.width, cell.frame.size.height/3);
    if (prescicaoMed.data == nil) {
        data.text = @"--/--/----";
    }else{
        NSDateFormatter *dateFormatter;
        dateFormatter = [MMNSDateFormater criarDateFormatter];
        
        dataLabel = [NSString stringWithFormat:@"%@",
                     [dateFormatter stringFromDate:prescicaoMed.data]];
        [data setText:dataLabel];
    }
   
    
    //    [Data setText:exame.da];
    
    [[cell contentView] addSubview:nome];
    [[cell contentView] addSubview:data];
//    [[cell textLabel] setTextColor:[UIColor blackColor]];
    
    [[cell textLabel] setBackgroundColor:[UIColor clearColor]];
    
//    [[cell textLabel] setText:prescicaoMed.titulo];
    
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    
    
    
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        PrescricaoMed *prescricao = [prescicoes objectAtIndex:indexPath.row];
        
        PrescicaoMedManager *manager = [PrescicaoMedManager sharedInstance];
        
        [manager deletarPrescicao:prescricao];
        
        [manager saveContext];
        
        [self atualizarItensHistorico];
        
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
}

- (void)atualizarItensHistorico
{
    PrescicaoMedManager *manager = [PrescicaoMedManager sharedInstance];
    prescicoes = [manager obterPrescricao];
    [self.tableView reloadData];
}

- (CGFloat)tableView: (UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80.0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    PrescricaoMed *prescMed = [prescicoes objectAtIndex:indexPath.row];
//    NSLog(@"%@", prescMed);
    
    MostrarPrescric_a_oViewController *viewPrescricao = [[MostrarPrescric_a_oViewController alloc] init];
    viewPrescricao.prescMed = prescMed;
    
    [[self navigationController] pushViewController:viewPrescricao animated:YES];
}

#pragma mark - Selectors dos botões da navigationBar



#pragma mark - Métodos do NotificationCenter para atualizar tableView

- (void)tableViewReloadData:(NSNotification *)notification {
    PrescicaoMedManager *prescicaoManager = [PrescicaoMedManager sharedInstance];
    prescicoes = [prescicaoManager obterPrescricao];
    
    [self.tableView reloadData];
}

- (void)adicionar:(id)sender
{
    CadastroPrescricaoMedViewController *viewController = [[CadastroPrescricaoMedViewController alloc] init];
    UINavigationController *navigation = [[UINavigationController alloc]initWithRootViewController:viewController];
    [[self navigationController] presentViewController:navigation animated:YES completion:nil];
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
