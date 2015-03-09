//
//  ListaPerfilViewController.m
//  Projeto Final
//
//  Created by Adriana Yuri on 01/09/14.
//  Copyright (c) 2014 Mack Mobile - BEPiD. All rights reserved.
//

#import "ListaPerfilViewController.h"
#import "CadPessoaViewController.h"
#import "UIImage+ImageEffects.h"
@interface ListaPerfilViewController ()

@end

@implementation ListaPerfilViewController

@synthesize modoTela, refObjetoSelecionarPerfil;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        UIImage *image = [UIImage imageNamed:@"perfil_line_2.png"];
        self.tabBarItem.image = [self imageWithImage:image scaledToSize:CGSizeMake(30, 30)];
        UIImage *imageSelect = [UIImage imageNamed:@"perfil_color_2.png"];
        
        self.tabBarItem.selectedImage = [self imageWithImage:imageSelect scaledToSize:CGSizeMake(30, 30)];
//        [[UITabBar appearance] setSelectedImageTintColor:[UIColor clearColor]];
    }
    return self;
}
- (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize {
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
//    //Botão de Adicionar
//    UIBarButtonItem *barButtonAdd = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(adicionar:)];
//    [[self navigationItem] setRightBarButtonItem:barButtonAdd];
//    
    PessoaManager *pessoaManager = [PessoaManager sharedInstance];
    
    perfis = [pessoaManager obterUsuarios];
    
    if ([modoTela isEqualToString:@"telaSelecionarPerfil"]) {
        [self setTitle:@"Perfil"];
        
        //Botão de Cancelar
        UIBarButtonItem *barButtonCancel = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(selBtnCancel:)];
        [[self navigationItem] setLeftBarButtonItem:barButtonCancel];
        
        //Botão de Ok
        UIBarButtonItem *barButtonDone = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(selBtnDone:)];
        [[self navigationItem] setRightBarButtonItem:barButtonDone];
    }
//
//    //background
//    [self.view setBackgroundColor:[UIColor colorWithRed:220/100.0f green:200/100.0f blue:238/20.0f alpha:0.6]];
//    
//    //adicionando as notificações para atualizar a tableView
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tableViewReloadData:) name:@"atualizarTableView" object:nil];

}

-(void)viewDidAppear:(BOOL)animated{
    [[[self tabBarController] navigationItem] setTitle:@"Perfis"];
    [[[self tabBarController] navigationItem] setTitleView:nil]; //remover a view com os perfis (bolinhas)
    
    UIBarButtonItem *barButtonAdd = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(adicionar:)];
    [[[self tabBarController] navigationItem] setRightBarButtonItem:barButtonAdd];
    
    PessoaManager *pessoaManager = [PessoaManager sharedInstance];
    
    perfis = [pessoaManager obterUsuarios];
    
    //background
    [self.view setBackgroundColor:[UIColor colorWithRed:220/100.0f green:200/100.0f blue:238/20.0f alpha:0.6]];
    
    //adicionando as notificações para atualizar a tableView
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tableViewReloadData:) name:@"atualizarTableView" object:nil];
}

- (void)viewWillAppear:(BOOL)animated
{
    if (refObjetoSelecionarPerfil) {
        [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:[perfis indexOfObject:refObjetoSelecionarPerfil.pessoa] inSection:0] animated:NO scrollPosition:UITableViewScrollPositionNone];
    }
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
    return perfis.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *reuseIdentifier = @"CelulaPerfil";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    }

    // Configure the cell...
    [cell setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
    
    PessoaManager *manager = [PessoaManager sharedInstance];
    
    Pessoa *perfil = [perfis objectAtIndex:indexPath.row];
//    UIView *viewFoto = [[UIView alloc] init];
//    [viewFoto setFrame:CGRectMake(0, 0, cell.frame.size.width, 170)];
    
    UIImage *imagem = [[UIImage alloc] initWithData: perfil.foto];
    
    UIImageView *BlurView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, cell.frame.size.width, 150)];
    [BlurView setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
//    [BlurView setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
    
    
    UIImageView *imagemtest = [[UIImageView alloc]init];
//    [imagemtest setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
    
    [imagemtest setFrame:CGRectMake(10, 35, 80, 80)];
    
//    [imagemtest sizeThatFits:CGSizeMake(30, 30)];
    
    [imagemtest setImage:imagem];
   
    BlurView.image = [imagemtest.image applyLightEffect];
    
    imagemtest.layer.borderWidth = 1.0f;
    
    imagemtest.layer.shadowColor = [UIColor blackColor].CGColor;
    
    
    imagemtest.layer.borderColor = [UIColor whiteColor].CGColor;
    
    
    imagemtest.layer.masksToBounds = NO;
    
    imagemtest.layer.cornerRadius = 40;
    
    imagemtest.clipsToBounds = YES;
    
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(imagemtest.frame.size.width + 30, 30, 120, 20)];
    if (perfil.nome == nil) {
        [label setText:@"Sem nome"];
    }else{
    [label setText:perfil.nome];
    }
    label.textColor = [UIColor blackColor];
    
    UILabel *labelSobrenome = [[UILabel alloc] initWithFrame:CGRectMake(imagemtest.frame.size.width + label.frame.size.width ,30, BlurView.frame.size.width - imagemtest.frame.size.width+10, 20)];
    [labelSobrenome setFont:[UIFont fontWithName:@"Arial" size:12]];
    
    if (perfil.sobrenome == nil) {
        [labelSobrenome setText:@" "];
    }else{
    [labelSobrenome setText:perfil.sobrenome];
    }
    labelSobrenome.textColor = [UIColor blackColor];
   
    UILabel *labelNascimento = [[UILabel alloc] initWithFrame:CGRectMake(imagemtest.frame.size.width + 30, label.frame.size.height + 40, 70, 20)];
    
    NSDateFormatter *dateFormatter;
    dateFormatter = [MMNSDateFormater criarDateFormatter];
    
    dataNascimento = [NSString stringWithFormat:@"%@",
                      [dateFormatter stringFromDate:perfil.dNascimento]];
    [labelNascimento setFont:[UIFont fontWithName:@"Arial" size:12]];
    [labelNascimento setText:dataNascimento];
    labelNascimento.textColor=[UIColor blackColor];
    
    UILabel *labelSexo = [[UILabel alloc] initWithFrame:CGRectMake(imagemtest.frame.size.width + 30 + labelNascimento.frame.size.width +22 , label.frame.size.height + 40, 60, 20)];
    labelSexo.textColor =[UIColor blackColor];
    [labelSexo setFont:[UIFont fontWithName:@"Arial" size:12]];
    [labelSexo setText:perfil.sexo];
    
    UILabel *labelTipoSanguineo = [[UILabel alloc] initWithFrame:CGRectMake(imagemtest.frame.size.width + 28, label.frame.size.height + labelNascimento.frame.size.height + 50, 70, 20)];
    labelTipoSanguineo.textColor =[UIColor blackColor];
    [labelTipoSanguineo setFont:[UIFont fontWithName:@"Arial" size:12]];
    [labelTipoSanguineo setText:perfil.tipoSanguineo];
    
    //BOLINHA COM A COR
    UIView *corView = [manager criarViewCorBolinhaDaPessoa:perfil naPosicao:CGPointMake(imagemtest.frame.size.width + 30 + labelNascimento.frame.size.width +22 , label.frame.size.height + labelSexo.frame.size.height + 50)];
    [BlurView addSubview:corView];
    
    [BlurView addSubview:labelTipoSanguineo];
    [BlurView addSubview:labelSexo];
    [BlurView addSubview:labelNascimento];
    [cell  addSubview:BlurView];
    [BlurView addSubview:label];
    [BlurView addSubview:labelSobrenome];
    [BlurView addSubview:imagemtest];
    
    
    
//    [[cell textLabel] setText:perfil.nome];
    
//    CGSize itemSize = CGSizeMake(30, 30); //Controla o tamanho do espacamento da imagem
    
//    UIGraphicsBeginImageContext(itemSize);
    
//    CGRect imageRect = CGRectMake(0.0, 0.0, itemSize.width, itemSize.height);
    
//    [imagem drawInRect:imageRect];
    
//    cell.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
    
//    UIGraphicsEndImageContext();
    
    if ([modoTela isEqualToString:@"telaSelecionarPerfil"]) {
        [cell setAccessoryType:UITableViewCellAccessoryNone];
    } else {
        [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    }
  
    return cell;
}

- (CGFloat)tableView: (UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 150.0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Pessoa *perfil = [perfis objectAtIndex:indexPath.row];
    
    if ([modoTela isEqualToString:@"telaSelecionarPerfil"]) {
        perfilSelecionado = perfil;
        
        [self selBtnDone:nil];
    } else {
        CadPessoaViewController *pessoaViewController = [[CadPessoaViewController alloc] init];
        
        pessoaViewController.pessoa = perfil;
        
        [[self navigationController] pushViewController:pessoaViewController animated:YES];
    }
}

#pragma mark - Selectors dos botões da navigationBar

- (void)adicionar:(id)sender
{
    CadPessoaViewController *pessoaViewController = [[CadPessoaViewController alloc] init];
    UINavigationController *navigation = [[UINavigationController alloc]initWithRootViewController:pessoaViewController];
    [[self navigationController] presentViewController:navigation animated:YES completion:nil];
}

#pragma mark - Selectors dos botões da navigationBar (para o modoTela = telaSelecionarPerfil)

- (void)selBtnCancel:(id)sender
{
    [[self navigationController] popViewControllerAnimated:YES];
}

- (void)selBtnDone:(id)sender
{
    [refObjetoSelecionarPerfil setPessoa:perfilSelecionado];
    
    PessoaManager *manager = [PessoaManager sharedInstance];
    [manager saveContext];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"atualizarTableView" object:nil];
    
    [[self navigationController] popViewControllerAnimated:YES];
}

#pragma mark - Métodos do NotificationCenter para atualizar tableView

- (void)tableViewReloadData:(NSNotification *)notification {
    PessoaManager *pessoaManager = [PessoaManager sharedInstance];
    
    perfis = [pessoaManager obterUsuarios];
    
    [self.tableView reloadData];
}

@end
