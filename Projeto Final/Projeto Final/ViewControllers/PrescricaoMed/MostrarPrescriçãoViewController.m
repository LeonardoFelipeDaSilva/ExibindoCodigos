//
//  MostrarPrescriçãoViewController.m
//  Projeto Final
//
//  Created by Leonardo Felipe da Silva on 11/21/14.
//  Copyright (c) 2014 Mack Mobile - BEPiD. All rights reserved.
//

#import "MostrarPrescriçãoViewController.h"
#import "UIImage+ImageEffects.h"
#import "ItensViewDeExibicaoViewController.h"
#import "FotoManager.h"
#import "CadastroPrescricaoMedViewController.h"
#import "PessoaManager.h"

@interface MostrarPrescric_a_oViewController ()
{
    NSArray *fotosPageControl;
}
@end

@implementation MostrarPrescric_a_oViewController

@synthesize segmentedControl, prescMed, imageView;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIBarButtonItem *barButtonEdit = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(editar:)];
    [[self navigationItem] setRightBarButtonItem:barButtonEdit];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tableViewReloadData:) name:@"atualizarTableView" object:nil];
    self.view.backgroundColor=[UIColor whiteColor];
//    PrescicaoMedManager *manager = [PrescicaoMedManager sharedInstance];
    
    [self setTitle:@"Prescrição"];
    

    
    UIImage *imagem = [[UIImage alloc]initWithData: prescMed.pessoa.foto];
    
    UIImageView *imagemtest = [[UIImageView alloc]init];
    
    [imagemtest setFrame:CGRectMake(20, 35, 80, 80)];
    
    //    [imagemtest sizeThatFits:CGSizeMake(30, 30)];
    
    [imagemtest setImage:imagem];
    
    
    
    imagemtest.layer.borderWidth = 3.0f;
    
    imagemtest.layer.shadowColor = [UIColor blackColor].CGColor;
    
    
    imagemtest.layer.borderColor = ((UIColor *)prescMed.pessoa.cor).CGColor;
    
    
    imagemtest.layer.masksToBounds = NO;
    
    imagemtest.layer.cornerRadius = 40;
    
    imagemtest.clipsToBounds = YES;
    
    
    ItensViewDeExibicaoViewController *itens = [[ItensViewDeExibicaoViewController alloc]init];
    
    NSArray *teste = [[NSArray alloc]initWithObjects:@"Fotos", @"Remédios", nil];
    segmentedControl = [[UISegmentedControl alloc] initWithItems:teste];
    segmentedControl.frame = [itens criarSegmentedControl:self.view];
   
    //    [segmentedControl setSegmentedControlStyle:UISegmentedControlStyleBar];
    [segmentedControl setSelected:YES];
    [segmentedControl addTarget:self action:@selector(segmentedControlValueDidChange:) forControlEvents:UIControlEventValueChanged];
    segmentedControl.backgroundColor = self.navigationController.navigationBar.barTintColor;
    segmentedControl.tintColor = [UIColor colorWithRed:255/255.0f green:255/255.0f blue:255/255.0f alpha:0.9];
    
  
    
    UIView *cabecalho = [itens criarViewCabecalho:self.view];
    cabecalho.frame =CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y,self.view.frame.size.width, 150);
    //    UIImageView *imageView = [itens criarImagemViewCabecalho:cabecalho];
    
    //    imageView.image =
    UILabel *labelNome = [itens criarLabelNome:CGRectMake(cabecalho.frame.origin.x+imagemtest.frame.origin.x+imagemtest.frame.size.width, imagemtest.frame.origin.y, cabecalho.frame.size.width -(imagemtest.frame.origin.x+imagemtest.frame.size.width), 30)];
//    labelNome.textColor = [UIColor whiteColor];
    
    UILabel *labelTipo = [itens criarLabelNome:CGRectMake(cabecalho.frame.origin.x+imagemtest.frame.origin.x+imagemtest.frame.size.width, labelNome.frame.origin.y + labelNome.frame.size.height, cabecalho.frame.size.width -(imagemtest.frame.origin.x+imagemtest.frame.size.width) , 30)];
//    labelTipo.textColor = [UIColor whiteColor];
    
    [labelTipo setTextAlignment:NSTextAlignmentCenter];
    [labelNome setTextAlignment:NSTextAlignmentCenter];
    labelNome.font = [UIFont boldSystemFontOfSize:[UIFont systemFontSize]];
    [labelTipo setFont:[UIFont systemFontOfSize:[UIFont systemFontSize]]];
    [labelNome setText:prescMed.titulo];
    
    NSDateFormatter *dateFormatter;
    dateFormatter = [MMNSDateFormater criarDateFormatter];
    
    dataNascimento = [NSString stringWithFormat:@"%@",
                      [dateFormatter stringFromDate:prescMed.data]];
    
    
    [labelTipo setFont:[UIFont systemFontOfSize:12]];
    //    [cabecalho addSubview:imageView];
    [labelTipo setText:dataNascimento];
    [cabecalho addSubview:imagemtest];
    [cabecalho addSubview:labelNome];
    [cabecalho addSubview:labelTipo];
    
    [self.view addSubview:cabecalho];
    segmentedControl.frame = CGRectMake(self.view.frame.origin.x, cabecalho.frame.origin.y + cabecalho.frame.size.height, segmentedControl.frame.size.width, segmentedControl.frame.size.height + 20);
    [self.view addSubview:segmentedControl];
    
    
    //    UILabel *label = [UILabel alloc]initWithFrame:CGRectMake(, <#CGFloat y#>, <#CGFloat width#>, <#CGFloat height#>)
    
    
    
    
    // Do any additional setup after loading the view.
}

-(void)segmentedControlValueDidChange:(UISegmentedControl *)segment
{
    switch (segment.selectedSegmentIndex) {
        case 0:{
            
            fotosPageControl = [prescMed.fotos allObjects];
            
            [self carregarViewDeFotos];
            
            break;
        }
        case 1:{
            btnRemedio = [[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width/20, self.view.frame.size.height - self.view.frame.size.height/10, self.view.frame.size.width - (self.view.frame.size.width/16 *2), self.view.frame.size.height/14)];
            btnRemedio.backgroundColor = self.navigationController.navigationBar.barTintColor;
            
            [btnRemedio addTarget:self action:@selector(adicionarHistVacina:) forControlEvents:UIControlEventAllTouchEvents];
//            viewControllerVacina = [[ListaHistVacinaViewController alloc]initWithHist:histVacina];
            tableView = [[UITableView alloc]initWithFrame:CGRectMake(self.view.frame.origin.x, 200, self.view.frame.size.width, 250)];
//            [tableView setDelegate:viewControllerVacina];
//            [tableView setDataSource:viewControllerVacina];
            [self.view addSubview:btnRemedio];
            [self.view addSubview:tableView];
            
            
            
            //            [self.navigationController pushViewController:viewController animated:YES];
            break;
        }
    }
}



//------------------------------CRIANDO PAGECONTROL PARA A EXIBICACAO DAS FOTOS DA PRESCRICAO--------------------------//


//--CRIANDO A SCROLL E A VIEW DE FOTOS--//
- (void)carregarViewDeFotos
{
    //SCROLL
    scrollViewFotos = [[UIScrollView alloc] init];
    scrollViewFotos.frame = CGRectMake(self.view.frame.origin.x, segmentedControl.frame.size.height+segmentedControl.frame.origin.y, self.view.frame.size.width, 250);
    scrollViewFotos.pagingEnabled = YES;
    scrollViewFotos.contentSize = CGSizeMake(self.view.frame.size.width * fotosPageControl.count, scrollViewFotos.frame.size.height);
    scrollViewFotos.showsHorizontalScrollIndicator = NO;
    scrollViewFotos.showsVerticalScrollIndicator = NO;
    scrollViewFotos.scrollsToTop = NO;
    scrollViewFotos.delegate = self;
    
    UIView *viewPageControl = [[UIView alloc]init];
    viewPageControl.frame = CGRectMake(self.view.frame.origin.x, scrollViewFotos.frame.origin.y + scrollViewFotos.frame.size.height, self.view.frame.size.width,self.view.frame.size.height- ( scrollViewFotos.frame.origin.y+scrollViewFotos.frame.size.height));
    viewPageControl.backgroundColor = self.navigationController.navigationBar.barTintColor;
    NSLog(@"%f", viewPageControl.frame.size.height);
    pageControlFoto = [[UIPageControl alloc]initWithFrame:CGRectMake(0, (viewPageControl.frame.size.height - 20)/2, scrollViewFotos.frame.size.width, 20)];
    pageControlFoto.tintColor = [UIColor whiteColor];
    pageControlFoto.numberOfPages = fotosPageControl.count;
    pageControlFoto.currentPage = 0;
  
    [self loadScrollViewWithPage:0];
    [self loadScrollViewWithPage:1];
    [viewPageControl addSubview:pageControlFoto];
    [self.view addSubview:scrollViewFotos];
    [self.view addSubview:viewPageControl];
}


- (void)scrollViewDidScroll:(UIScrollView *)sender {
    // We don't want a "feedback loop" between the UIPageControl and the scroll delegate in
    // which a scroll event generated from the user hitting the page control triggers updates from
    // the delegate method. We use a boolean to disable the delegate logic when the page control is used.
    if (pageControlUsed) {
        // do nothing - the scroll was initiated from the page control, not the user dragging
        return;
    }
    
    // Switch the indicator when more than 50% of the previous/next page is visible
    CGFloat pageWidth = scrollViewFotos.frame.size.width;
    int page = floor((scrollViewFotos.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    pageControlFoto.currentPage = page;
    
    // load the visible page and the page on either side of it (to avoid flashes when the user starts scrolling)
    [self loadScrollViewWithPage:page - 1];
    [self loadScrollViewWithPage:page];
    [self loadScrollViewWithPage:page + 1];
    
    // A possible optimization would be to unload the views+controllers which are no longer visible
}

- (void)changePage:(id)sender {
    int page = pageControlFoto.currentPage;
    
    // load the visible page and the page on either side of it (to avoid flashes when the user starts scrolling)
    [self loadScrollViewWithPage:page - 1];
    [self loadScrollViewWithPage:page];
    [self loadScrollViewWithPage:page + 1];
    
    // update the scroll view to the appropriate page
    CGRect frame = scrollViewFotos.frame;
    frame.origin.x = frame.size.width * page;
    frame.origin.y = 0;
    [scrollViewFotos scrollRectToVisible:frame animated:YES];
    
    // Set the boolean used when scrolls originate from the UIPageControl. See scrollViewDidScroll: above.
    pageControlUsed = YES;
}

- (void)loadScrollViewWithPage:(int)page {
    if (page < 0) return;
    if (page >= fotosPageControl.count) return;
    
    UIImageView *viewImagem = [[UIImageView alloc] init];
    [viewImagem setFrame:CGRectMake(scrollViewFotos.frame.size.width * page, 0, scrollViewFotos.frame.size.width, 250)];
    Foto *foto = [fotosPageControl objectAtIndex:page];
    UIImage *imagem = [UIImage imageWithData:foto.foto];
    [viewImagem setImage:imagem];
    
    [scrollViewFotos addSubview:viewImagem];
}

- (void)editar:(id)sender
{
    CadastroPrescricaoMedViewController *viewController = [[CadastroPrescricaoMedViewController alloc] init];

    viewController.prescicao = prescMed;
    
    [[self navigationController] pushViewController:viewController animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)tableViewReloadData:(NSNotification *)notification
{
   
    
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
