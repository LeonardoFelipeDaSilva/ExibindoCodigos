//
//  MostrarExameViewController.m
//  Projeto Final
//
//  Created by Leonardo Felipe da Silva on 12/2/14.
//  Copyright (c) 2014 Mack Mobile - BEPiD. All rights reserved.
//

#import "MostrarExameViewController.h"
#import "UIImage+ImageEffects.h"
#import "ItensViewDeExibicaoViewController.h"
#import "FotoManager.h"
#import "Medico.h"
#import "ExameViewController.h"
#import "PessoaManager.h"
@interface MostrarExameViewController ()
{
    NSArray *fotosPageControl;
}
@end

@implementation MostrarExameViewController
@synthesize exame, imageView, soprapegar, fotoLabel;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIBarButtonItem *barButtonEdit = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(editar:)];
    [[self navigationItem] setRightBarButtonItem:barButtonEdit];
    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tableViewReloadData:) name:@"atualizarTableView" object:nil];
//    self.view.backgroundColor=[UIColor whiteColor];
    ExameManager *manager = [ExameManager sharedInstance];
    
    [self setTitle:@"Exame"];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    
    UIImage *imagem = [[UIImage alloc]initWithData: exame.pessoa.foto];
    
    
    UIImageView *imagemtest = [[UIImageView alloc]init];
    
    [imagemtest setFrame:CGRectMake(20, 35, 80, 80)];
    
    //    [imagemtest sizeThatFits:CGSizeMake(30, 30)];
    
    [imagemtest setImage:imagem];
    
    
    
    imagemtest.layer.borderWidth = 3.0f;
    
    imagemtest.layer.shadowColor = [UIColor blackColor].CGColor;
    
    
    imagemtest.layer.borderColor = ((UIColor *) exame.pessoa.cor).CGColor;
    
    
    imagemtest.layer.masksToBounds = NO;
    
    imagemtest.layer.cornerRadius = 40;
    
    imagemtest.clipsToBounds = YES;
    
    
    ItensViewDeExibicaoViewController *itens = [[ItensViewDeExibicaoViewController alloc]init];
    

    
    
    
    UIView *cabecalho = [itens criarViewCabecalho:self.view];
    soprapegar=[[UIView alloc]init];
    soprapegar.frame = cabecalho.frame;
    NSLog(@"%f", cabecalho.frame.size.height);
    //    UIImageView *imageView = [itens criarImagemViewCabecalho:cabecalho];
    
    //    imageView.image =
    
    fotoLabel = [[UILabel alloc]init];
    fotoLabel.frame = CGRectMake(self.view.frame.origin.x, cabecalho.frame.size.height +cabecalho.frame.origin.y, self.view.frame.size.width, 30);
    fotoLabel.backgroundColor = self.navigationController.navigationBar.barTintColor;
    fotoLabel.text = @"  Fotos dos Exames";
    fotoLabel.textColor = [UIColor whiteColor];
    
    
    
    //----NOME EXAME----//
    UILabel *labelNome = [itens criarLabelNome:CGRectMake(cabecalho.frame.origin.x+imagemtest.frame.origin.x+imagemtest.frame.size.width, cabecalho.frame.size.height - 155,self.view.frame.size.width - (imagemtest.frame.size.width + imagemtest.frame.origin.x) , 30)];
    labelNome.font = [UIFont boldSystemFontOfSize:[UIFont systemFontSize]];
//    labelNome.textColor = [UIColor whiteColor];
    //----NOME MEDICO---//
    UILabel *labelMedico = [itens criarLabelNome:CGRectMake(cabecalho.frame.origin.x+imagemtest.frame.origin.x+imagemtest.frame.size.width, cabecalho.frame.size.height + labelNome.frame.size.height - 155, self.view.frame.size.width - (imagemtest.frame.size.width + imagemtest.frame.origin.x) , 30)];
//    labelMedico.textColor = [UIColor whiteColor];
    //----LOCAL DO EXAME---//
    UILabel *labelLocal = [itens criarLabelNome:CGRectMake(cabecalho.frame.origin.x+imagemtest.frame.origin.x+imagemtest.frame.size.width, cabecalho.frame.size.height + labelNome.frame.size.height + labelMedico.frame.size.height - 155, self.view.frame.size.width - (imagemtest.frame.size.width + imagemtest.frame.origin.x) , 30)];
//    labelLocal.textColor = [UIColor whiteColor];
    //----DATA DO EXAME---//
    UILabel *labelData = [itens criarLabelNome:CGRectMake(cabecalho.frame.origin.x+imagemtest.frame.origin.x+imagemtest.frame.size.width, cabecalho.frame.size.height + labelNome.frame.size.height + labelMedico.frame.size.height + labelLocal.frame.size.height - 155, self.view.frame.size.width - (imagemtest.frame.size.width + imagemtest.frame.origin.x) , 30)];
//    labelData.textColor = [UIFont sys];
    
    [labelMedico setTextAlignment:NSTextAlignmentCenter];
    [labelNome setTextAlignment:NSTextAlignmentCenter];
    [labelLocal setTextAlignment:NSTextAlignmentCenter];
    [labelData setTextAlignment:NSTextAlignmentCenter];
    
    [labelMedico setFont:[UIFont systemFontOfSize:[UIFont systemFontSize]]];
    [labelLocal setFont:[UIFont systemFontOfSize:[UIFont systemFontSize]]];
    [labelData setFont:[UIFont systemFontOfSize:[UIFont systemFontSize]]];

    [labelNome setText:exame.titulo];
    [labelMedico setText:exame.medico.nome];
    [labelLocal setText:exame.local];
    
    if (exame.data == nil) {
        data = @"Sem data Cadastrada";
    
    }else{
        NSDateFormatter *dateFormatter;
        dateFormatter = [MMNSDateFormater criarDateFormatter];
        
        data = [NSString stringWithFormat:@"%@",
                [dateFormatter stringFromDate:exame.data]];
        
        [labelData setText:data];
    }
    [cabecalho addSubview:imagemtest];
    [cabecalho addSubview:labelNome];
    [cabecalho addSubview:labelMedico];
    [cabecalho addSubview:labelLocal];
    [cabecalho addSubview:labelData];
    
    [self.view addSubview:cabecalho];
    [self.view addSubview:fotoLabel];
    
    
    fotosPageControl = [exame.fotos allObjects];
    
    [self carregarViewDeFotos];
}




//------------------------------CRIANDO PAGECONTROL PARA A EXIBICACAO DAS FOTOS DA PRESCRICAO--------------------------//


//--CRIANDO A SCROLL E A VIEW DE FOTOS--//
- (void)carregarViewDeFotos
{
    //SCROLL
    scrollViewFotos = [[UIScrollView alloc] init];
    
    NSLog(@"%f", soprapegar.frame.size.height);
    scrollViewFotos.frame = CGRectMake(self.view.frame.origin.x, soprapegar.frame.origin.x + soprapegar.frame.size.height + fotoLabel.frame.size.height, self.view.frame.size.width, 250);
    scrollViewFotos.pagingEnabled = YES;
    scrollViewFotos.contentSize = CGSizeMake(self.view.frame.size.width * fotosPageControl.count, scrollViewFotos.frame.size.height);
    scrollViewFotos.showsHorizontalScrollIndicator = NO;
    scrollViewFotos.showsVerticalScrollIndicator = NO;
    scrollViewFotos.scrollsToTop = NO;
    scrollViewFotos.delegate = self;
    
    UIView *viewPageControl = [[UIView alloc]init];
    viewPageControl.frame = CGRectMake(self.view.frame.origin.x, scrollViewFotos.frame.origin.y + scrollViewFotos.frame.size.height, self.view.frame.size.width,self.view.frame.size.height- ( scrollViewFotos.frame.origin.y+scrollViewFotos.frame.size.height +fotoLabel.frame.size.height));
    viewPageControl.backgroundColor = self.navigationController.navigationBar.barTintColor;
    pageControlFoto = [[UIPageControl alloc]initWithFrame:CGRectMake(0, viewPageControl.frame.size.height/2 - 30, scrollViewFotos.frame.size.width, 30)];
//    pageControlFoto.backgroundColor = [UIColor whiteColor];
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
    ExameViewController *viewController = [[ExameViewController alloc] init];
    
    viewController.exame = exame;
    
    [[self navigationController] pushViewController:viewController animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
