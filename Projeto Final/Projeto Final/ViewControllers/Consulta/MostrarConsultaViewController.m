//
//  MostrarConsultaViewController.m
//  Projeto Final
//
//  Created by Leonardo Felipe da Silva on 12/8/14.
//  Copyright (c) 2014 Mack Mobile - BEPiD. All rights reserved.
//

#import "MostrarConsultaViewController.h"
#import "ItensViewDeExibicaoViewController.h"
#import "PessoaManager.h"
#import "ConsultaViewController.h"
#import "UIImage+ImageEffects.h"

#import "MedicoManager.h"
@interface MostrarConsultaViewController ()

@end

@implementation MostrarConsultaViewController
@synthesize consulta, imageView, anotacoesLabel;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIBarButtonItem *barButtonEdit = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(editar:)];
    [[self navigationItem] setRightBarButtonItem:barButtonEdit];
    
    
    
    ConsultaManager *manager = [ConsultaManager sharedInstance];
    
    [self setTitle:@"Consulta"];
    
    self.view.backgroundColor=[UIColor whiteColor];
    
    ItensViewDeExibicaoViewController *itens = [[ItensViewDeExibicaoViewController alloc]init];
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIImage *imagem = [[UIImage alloc]initWithData: consulta.pessoa.foto];
    
    UIImageView *imagemtest = [[UIImageView alloc]init];
    
    [imagemtest setFrame:CGRectMake(20, 35, 80, 80)];
    
    //    [imagemtest sizeThatFits:CGSizeMake(30, 30)];
    
    [imagemtest setImage:imagem];
    
    
    
    imagemtest.layer.borderWidth = 3.0f;
    
    imagemtest.layer.shadowColor = [UIColor blackColor].CGColor;
    
    
    imagemtest.layer.borderColor = ((UIColor *)consulta.pessoa.cor).CGColor;
    
    
    imagemtest.layer.masksToBounds = NO;
    
    imagemtest.layer.cornerRadius = 40;
    
    imagemtest.clipsToBounds = YES;
    
    
    
    UIView *cabecalho = [itens criarViewCabecalho:self.view];
    //    UIImageView *imageView = [itens criarImagemViewCabecalho:cabecalho];
    
    //    imageView.image =
    
    //----NOME EXAME----//
    UILabel *labelNome = [itens criarLabelNome:CGRectMake(cabecalho.frame.origin.x+imagemtest.frame.origin.x+imagemtest.frame.size.width, cabecalho.frame.size.height - 155, self.view.frame.size.width - (imagemtest.frame.size.width + imagemtest.frame.origin.x), 30)];
    labelNome.font = [UIFont boldSystemFontOfSize:[UIFont systemFontSize]];
    [labelNome setText:consulta.titulo];
    //----NOME MEDICO---//
    UILabel *labelMedico = [itens criarLabelNome:CGRectMake(cabecalho.frame.origin.x+imagemtest.frame.origin.x+imagemtest.frame.size.width, cabecalho.frame.size.height + labelNome.frame.size.height - 155, self.view.frame.size.width - (imagemtest.frame.size.width + imagemtest.frame.origin.x) , 30)];
    labelMedico.text = consulta.medico.nome;
    //    labelMedico.textColor = [UIColor whiteColor];
    //----DATA DO EXAME---//
    UILabel *labelData = [itens criarLabelNome:CGRectMake(cabecalho.frame.origin.x+imagemtest.frame.origin.x+imagemtest.frame.size.width, cabecalho.frame.size.height + labelNome.frame.size.height + labelMedico.frame.size.height - 155, self.view.frame.size.width - (imagemtest.frame.size.width + imagemtest.frame.origin.x) , 30)];
    //----SINTOMAS DA OCORRENCIA---//
    anotacoesLabel = [[UILabel alloc]init];
    anotacoesLabel.frame = CGRectMake(self.view.frame.origin.x, cabecalho.frame.size.height +cabecalho.frame.origin.y, self.view.frame.size.width, 30);
    anotacoesLabel.backgroundColor = self.navigationController.navigationBar.barTintColor;
    anotacoesLabel.text = @"  Anotações adicionais da Consulta";
    anotacoesLabel.textColor = [UIColor whiteColor];
    
    
    UITextView *labelAnotacoes = [[UITextView alloc]initWithFrame:CGRectMake(self.view.frame.origin.x,anotacoesLabel.frame.origin.y+anotacoesLabel.frame.size.height, self.view.frame.size.width , 250)];
    labelAnotacoes.font = [UIFont systemFontOfSize:[UIFont systemFontSize]];
    labelAnotacoes.editable = NO;
    if (consulta.anotacoes == nil) {
        labelAnotacoes.text = @"  *sem anotações feitas";
    }else{
    labelAnotacoes.text = consulta.anotacoes;
    }
    //    labelSintomas.textColor = [UIColor whiteColor];
    //----DATA DA OCORRENCIA---//
    
    
    [labelMedico setTextAlignment:NSTextAlignmentCenter];
    [labelNome setTextAlignment:NSTextAlignmentCenter];
    labelAnotacoes.textAlignment = NSTextAlignmentJustified;
    [labelData setTextAlignment:NSTextAlignmentCenter];
    //    [labelSintomas setTextAlignment:NSTextAlignmentLeft];
    //    [labelData.font:[UIFont systemFontSize]];
    
    [labelAnotacoes setText:consulta.anotacoes];
    
    if (consulta.data == nil) {
        labelData.text = @"Sem data adicionada";
    }else{
        NSDateFormatter *dateFormatter;
        dateFormatter = [MMNSDateFormater criarDateFormatter];
        
        data = [NSString stringWithFormat:@"%@",
                [dateFormatter stringFromDate:consulta.data]];
        [labelData setText:data];
    }
    [cabecalho addSubview:imagemtest];
    [cabecalho addSubview:labelNome];
    [cabecalho addSubview:labelMedico];
    [cabecalho addSubview:labelData];
    
    [self.view addSubview:cabecalho];
    [self.view addSubview:anotacoesLabel];
    [self.view addSubview:labelAnotacoes];
    
    
}

- (void)editar:(id)sender
{
    ConsultaViewController *viewController = [[ConsultaViewController alloc] init];
    
    viewController.consulta = consulta;
    
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
