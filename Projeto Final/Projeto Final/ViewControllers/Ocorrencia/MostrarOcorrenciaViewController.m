//
//  MostrarOcorrenciaViewController.m
//  Projeto Final
//
//  Created by Leonardo Felipe da Silva on 12/2/14.
//  Copyright (c) 2014 Mack Mobile - BEPiD. All rights reserved.
//


#import "MostrarOcorrenciaViewController.h"
#import "UIImage+ImageEffects.h"
#import "ItensViewDeExibicaoViewController.h"
#import "FotoManager.h"
#import "OcorrenciaViewController.h"
#import "PessoaManager.h"
@interface MostrarOcorrenciaViewController ()
{
    NSArray *fotosPageControl;
}
@end

@implementation MostrarOcorrenciaViewController
@synthesize ocorrencia, imageView, sintomasLabel;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIBarButtonItem *barButtonEdit = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(editar:)];
    [[self navigationItem] setRightBarButtonItem:barButtonEdit];
    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tableViewReloadData:) name:@"atualizarTableView" object:nil];
    
    OcorrenciaManager *manager = [OcorrenciaManager sharedInstance];
    
    [self setTitle:@"Ocorrência"];
    
    self.view.backgroundColor=[UIColor whiteColor];
    
    ItensViewDeExibicaoViewController *itens = [[ItensViewDeExibicaoViewController alloc]init];
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIImage *imagem = [[UIImage alloc]initWithData: ocorrencia.pessoa.foto];
    
    UIImageView *imagemtest = [[UIImageView alloc]init];
    
    [imagemtest setFrame:CGRectMake(20, 35, 80, 80)];
    
    //    [imagemtest sizeThatFits:CGSizeMake(30, 30)];
    
    [imagemtest setImage:imagem];
    
    
    
    imagemtest.layer.borderWidth = 3.0f;
    
    imagemtest.layer.shadowColor = [UIColor blackColor].CGColor;
    
    
    imagemtest.layer.borderColor = ((UIColor *)ocorrencia.pessoa.cor).CGColor;
    
    
    imagemtest.layer.masksToBounds = NO;
    
    imagemtest.layer.cornerRadius = 40;
    
    imagemtest.clipsToBounds = YES;

    
    
    UIView *cabecalho = [itens criarViewCabecalho:self.view];
    //    UIImageView *imageView = [itens criarImagemViewCabecalho:cabecalho];
    
    //    imageView.image =
    
    //----NOME EXAME----//
    UILabel *labelNome = [itens criarLabelNome:CGRectMake(cabecalho.frame.origin.x+imagemtest.frame.origin.x+imagemtest.frame.size.width, cabecalho.frame.size.height - 155, self.view.frame.size.width - (imagemtest.frame.size.width + imagemtest.frame.origin.x), 30)];
    labelNome.font = [UIFont boldSystemFontOfSize:[UIFont systemFontSize]];
   [labelNome setText:ocorrencia.titulo];
    //----SINTOMAS DA OCORRENCIA---//
    sintomasLabel = [[UILabel alloc]init];
    sintomasLabel.frame = CGRectMake(self.view.frame.origin.x, cabecalho.frame.size.height +cabecalho.frame.origin.y, self.view.frame.size.width, 30);
    sintomasLabel.backgroundColor = self.navigationController.navigationBar.barTintColor;
    sintomasLabel.text = @"  Sintomas tidos na Ocorrencia";
    sintomasLabel.textColor = [UIColor whiteColor];
    
   
    UITextView *labelSintomas = [[UITextView alloc]initWithFrame:CGRectMake(self.view.frame.origin.x,sintomasLabel.frame.origin.y+sintomasLabel.frame.size.height, self.view.frame.size.width , 250)];
    labelSintomas.font = [UIFont systemFontOfSize:[UIFont systemFontSize]];
    labelSintomas.text = ocorrencia.sintomas;
    labelSintomas.editable = NO;
//    labelSintomas.textColor = [UIColor whiteColor];
    //----DATA DA OCORRENCIA---//
    UILabel *labelData = [itens criarLabelNome:CGRectMake(cabecalho.frame.origin.x +labelNome.frame.size.height + labelNome.frame.origin.y, cabecalho.frame.size.height + labelNome.frame.size.height - 155, cabecalho.frame.size.width , 30)];


    [labelNome setTextAlignment:NSTextAlignmentCenter];
    labelSintomas.textAlignment = NSTextAlignmentJustified;
    [labelData setTextAlignment:NSTextAlignmentCenter];
//    [labelSintomas setTextAlignment:NSTextAlignmentLeft];
//    [labelData.font:[UIFont systemFontSize]];
    
    [labelSintomas setText:ocorrencia.sintomas];
    
    if (ocorrencia.data == nil) {
        labelData.text = @"Sem data adicionada";
    }else{
    NSDateFormatter *dateFormatter;
    dateFormatter = [MMNSDateFormater criarDateFormatter];
    
    data = [NSString stringWithFormat:@"%@",
            [dateFormatter stringFromDate:ocorrencia.data]];
    [labelData setText:data];
    }
    [cabecalho addSubview:imagemtest];
    [cabecalho addSubview:labelNome];

    [cabecalho addSubview:labelData];
    
    [self.view addSubview:cabecalho];
    [self.view addSubview:sintomasLabel];
    [self.view addSubview:labelSintomas];
    
    
}

- (void)editar:(id)sender
{
    OcorrenciaViewController *viewController = [[OcorrenciaViewController alloc] init];
    
    viewController.ocorrencia = ocorrencia;
    
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
