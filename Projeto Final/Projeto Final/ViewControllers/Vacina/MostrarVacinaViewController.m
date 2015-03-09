//
//  MostrarVacinaViewController.m
//  Projeto Final
//
//  Created by Leonardo Felipe da Silva on 10/27/14.
//  Copyright (c) 2014 Mack Mobile - BEPiD. All rights reserved.
//

#import "MostrarVacinaViewController.h"
#import "ItensViewDeExibicaoViewController.h"
#import "VacinaManager.h"
#import "CadastroPrescricaoMedViewController.h"
#import "ListaHistVacinaViewController.h"
#import "HistóricoVacinaViewController.h"
#import "UIImage+ImageEffects.h"
#import "UnidadeDeTempoManager.h"
#import "VacinaViewController.h"
#import "IndexManager.h"
#import "MMPrincipal.h"
#import "PessoaManager.h"


@interface MostrarVacinaViewController ()

@end

@implementation MostrarVacinaViewController
@synthesize segmentedControl, vacina;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    VacinaManager *vacinaManager = [VacinaManager sharedInstance];
//    UnidadeDeTempoManager *managerTempo = [UnidadeDeTempoManager sharedInstance];
    
    UIBarButtonItem *barButtonEdit = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(editar:)];
    [[self navigationItem] setRightBarButtonItem:barButtonEdit];
    
    [self setTitle:@"Vacina"];
    
    self.view.backgroundColor=[UIColor whiteColor];
    
    
//    UIBarButtonItem *editButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelar:)];
    
//    [[self navigationItem] setLeftBarButtonItem:editButton];
   
    
//    UIImage *imagem = [UIImage imageNamed:@"vacina"];
//    
//    UIImageView *imagemtest = [[UIImageView alloc]init];
//    
//    [imagemtest setFrame:CGRectMake(20, 35, 80, 80)];
//    
//    //    [imagemtest sizeThatFits:CGSizeMake(30, 30)];
//    
//    [imagemtest setImage:imagem];
//    
//    
//    
//    imagemtest.layer.borderWidth = 3.0f;
//    
//    imagemtest.layer.shadowColor = [UIColor blackColor].CGColor;
//    
//    
//    imagemtest.layer.borderColor = ((UIColor *)prescMed.pessoa.cor).CGColor;
//    
//    
//    imagemtest.layer.masksToBounds = NO;
//    
//    imagemtest.layer.cornerRadius = 40;
//    
//    imagemtest.clipsToBounds = YES;
    
    UIImage *imagem = [UIImage imageNamed:@"vacina"];
    
    UIImageView *viewImagem = [[UIImageView alloc] init];
    [viewImagem setFrame:CGRectMake(20, 35, 80, 80)];
    [viewImagem setBackgroundColor:self.navigationController.navigationBar.barTintColor];
    viewImagem.layer.cornerRadius = viewImagem.frame.size.width/2;
    
    UIImageView *viewImagemReduzida = [[UIImageView alloc] init];
    [viewImagemReduzida setFrame:CGRectMake(viewImagem.frame.size.width/4, viewImagem.frame.size.height/4, viewImagem.frame.size.width/2, viewImagem.frame.size.height/2)];
    [viewImagemReduzida setImage:imagem];
    [viewImagem addSubview:viewImagemReduzida];
    
    
    
    NSMutableArray *arrayCores = [[NSMutableArray alloc] init];
    for (Pessoa *pessoa in [vacinaManager obterPessoasComHistoricoDaVacina:vacina]) {
        [arrayCores addObject:pessoa.cor];
    }
    MMUIViewDrawRect *viewCirculoColorido = [[MMUIViewDrawRect alloc] initWithPosition:CGPointMake(0, 0) andSize:viewImagem.frame.size.width andCores:arrayCores];
    [viewImagem addSubview:viewCirculoColorido];
    
    
    ItensViewDeExibicaoViewController *itens = [[ItensViewDeExibicaoViewController alloc]init];
    NSArray *teste = [[NSArray alloc]initWithObjects:@"Histórico", @"Prescrição", nil];
    segmentedControl = [[UISegmentedControl alloc] initWithItems:teste];
    segmentedControl.frame = [itens criarSegmentedControl:self.view];
//    [segmentedControl setSegmentedControlStyle:UISegmentedControlStyleBar];
   
    [segmentedControl addTarget:self action:@selector(segmentedControlValueDidChange:) forControlEvents:UIControlEventValueChanged];
    
    segmentedControl.backgroundColor = [UIColor whiteColor];
    segmentedControl.tintColor = [UIColor blackColor];
    
    
    
    UIView *cabecalho = [itens criarViewCabecalho:self.view];
//    UIImageView *imageView = [itens criarImagemViewCabecalho:cabecalho];
    
//    imageView.image = 
    UILabel *labelNome = [itens criarLabelNome:CGRectMake(viewImagem.frame.origin.x +viewImagem.frame.size.width, viewImagem.frame.origin.y, cabecalho.frame.size.width - (viewImagem.frame.origin.x + viewImagem.frame.size.width) , 30)];
//    labelNome.textColor = [UIColor whiteColor];
    
    UILabel *labelTipo = [itens criarLabelNome:CGRectMake(viewImagem.frame.origin.x +viewImagem.frame.size.width, labelNome.frame.origin.y + labelNome.frame.size.height, cabecalho.frame.size.width - (viewImagem.frame.origin.x + viewImagem.frame.size.width), 30)];
    
 
    [labelTipo setTextAlignment:NSTextAlignmentCenter];
    [labelNome setTextAlignment:NSTextAlignmentCenter];
    labelNome.font
    = [UIFont boldSystemFontOfSize:[UIFont systemFontSize]];
    [labelTipo setFont:[UIFont systemFontOfSize:[UIFont systemFontSize]]];
 
    [labelNome setText:vacina.nome];
    [labelTipo setText:vacina.tipo];
  
//    [cabecalho addSubview:imageView];
    [cabecalho addSubview:viewImagem];
    [cabecalho addSubview:labelNome];
    [cabecalho addSubview:labelTipo];
    [self.view addSubview:cabecalho];
    
    viewControllerVacina = [[ListaHistVacinaViewController alloc] initWithVacina:vacina];
    viewControllerVacina.viewControllerPai = self;
    tableView = [[UITableView alloc]initWithFrame:CGRectMake(self.view.frame.origin.x, 170, self.view.frame.size.width, 280)];
    [tableView setDelegate:viewControllerVacina];
    [tableView setDataSource:viewControllerVacina];
    [self.view addSubview:tableView];
    
    btnHistorico = [[UIButton alloc] init];
//    [btnHistorico setFrame:CGRectMake(self.view.frame.size.width/20, self.view.frame.size.height - self.view.frame.size.height/10, self.view.frame.size.width - (self.view.frame.size.width/16 *2), self.view.frame.size.height/14)];
//    [btnHistorico setFrame:CGRectMake(0, self.view.frame.size.height-50-self.navigationController.navigationBar.frame.size.height, self.view.frame.size.width, 50)];
//    NSLog(@"%f %f %f %f", btnHistorico.frame.origin.x, btnHistorico.frame.origin.y, btnHistorico.frame.size.width, btnHistorico.frame.size.height);
//    btnHistorico.backgroundColor = [];
    NSLog(@"%f", tableView.frame.origin.y+tableView.frame.size.height);
    [btnHistorico setTitle:@"ADICIONAR" forState:UIControlStateNormal];
    [btnHistorico addTarget:self action:@selector(adicionarHistVacina:) forControlEvents:UIControlEventTouchDown];
    [btnHistorico setFrame:CGRectMake(self.view.frame.origin.x, tableView.frame.origin.y + tableView.frame.size.height, self.view.frame.size.width, (self.view.frame.size.height-(tableView.frame.origin.y+tableView.frame.size.height))/2)];
    [self.view addSubview:btnHistorico];
    btnHistorico.backgroundColor = self.navigationController.navigationBar.barTintColor;
    
//    [self.view addSubview:segmentedControl];
//     segmentedControl.selectedSegmentIndex = 0;
//    if ((segmentedControl.selected = 1)) {
//        
//        [self segmentedControlValueDidChange:segmentedControl];
//    }
  
//    UILabel *label = [UILabel alloc]initWithFrame:CGRectMake(, <#CGFloat y#>, <#CGFloat width#>, <#CGFloat height#>)
    
    // Do any additional setup after loading the view.
    
    //adicionando as notificações
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tableViewReloadData:) name:@"atualizarTableView" object:nil];
}

//-(void)segmentedControlValueDidChange:(UISegmentedControl *)segment
//{
//    switch (segment.selectedSegmentIndex) {
//        case 0:{
//            btnHistorico = [[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width/20, self.view.frame.size.height - self.view.frame.size.height/10, self.view.frame.size.width - (self.view.frame.size.width/16 *2), self.view.frame.size.height/14)];
//            btnHistorico.backgroundColor = [UIColor yellowColor];
//            
//            [btnHistorico addTarget:self action:@selector(adicionarHistVacina:) forControlEvents:UIControlEventTouchDown];
//            viewControllerVacina = [[ListaHistVacinaViewController alloc] initWithVacina:vacina];
//            viewControllerVacina.viewControllerPai = self;
//            tableView = [[UITableView alloc]initWithFrame:CGRectMake(self.view.frame.origin.x, 200, self.view.frame.size.width, 250)];
//            [tableView setDelegate:viewControllerVacina];
//            [tableView setDataSource:viewControllerVacina];
//            [self.view addSubview:btnHistorico];
//            [self.view addSubview:tableView];
//            
//
//            
////            [self.navigationController pushViewController:viewController animated:YES];
//            break;}
//        case 1:{
//            btnPrescricao = [[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width/20, self.view.frame.size.height - self.view.frame.size.height/10, self.view.frame.size.width - (self.view.frame.size.width/16 *2), self.view.frame.size.height/14)];
//            btnPrescricao.backgroundColor = [UIColor blackColor];
//            
//            [btnPrescricao addTarget:self action:@selector(adicionarPrescicao:) forControlEvents:UIControlEventAllTouchEvents];
//            
//            viewControllerPrescricao = [[ListaPrescricaoViewController alloc] initWithVacina:vacina];
//            tableView = [[UITableView alloc]initWithFrame:CGRectMake(self.view.frame.origin.x, 200, self.view.frame.size.width, 250)];
//            [tableView setDelegate:viewControllerPrescricao];
//            [tableView setDataSource:viewControllerPrescricao];
//            [self.view addSubview:tableView];
//            [self.view addSubview:btnPrescricao];
//            [tableView reloadData];
//            //action for the first button (Current)
//            break;}
//    }
//}

- (void)adicionarPrescicao:(id)sender
{
    CadastroPrescricaoMedViewController *viewController = [[CadastroPrescricaoMedViewController alloc] init];
    UINavigationController *navigation = [[UINavigationController alloc]initWithRootViewController:viewController];
    [[self navigationController] presentViewController:navigation animated:YES completion:nil];
}

- (void)adicionarHistVacina:(id)sender
{
    Histo_ricoVacinaViewController *historicoView = [[Histo_ricoVacinaViewController alloc] init];
    
    historicoView.histVacina = nil;
    historicoView.vacina = vacina;
    
    UINavigationController *navigation = [[UINavigationController alloc] initWithRootViewController:historicoView];
    
    [self.navigationController presentViewController:navigation animated:YES completion:nil];
}
- (void)editar:(id)sender
{
    VacinaViewController *viewController = [[VacinaViewController alloc] init];
 
    viewController.vacina = vacina;
    
    [[self navigationController] pushViewController:viewController animated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tableViewReloadData:(NSNotification *)notification
{
    [viewControllerVacina atualizarDados];
    
    [tableView reloadData];
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
