//
//  BoxesCreatorViewController.m
//  Projeto Final
//
//  Created by Leonardo Felipe da Silva on 23/08/14.
//  Copyright (c) 2014 Mack Mobile - BEPiD. All rights reserved.
//

#import "BoxesCreatorViewController.h"

@interface BoxesCreatorViewController () {
    int posicaoY;
    UITextField *caixaTexto;
}

@property int posicaoY;

@end

@implementation BoxesCreatorViewController

@synthesize posicaoY, posicaoYPegaValor;

static int POSICAO_X = 5;
static int POSICAO_Y = 10;
UITextField *datePickerLabel;

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
    
    
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
// BLUR View
-(UIView *)criarViewAltura:(int)alt {
    UIView *view;
    
    view = [MMView criarRetangulo:CGRectMake(0, posicaoY, self.view.frame.size.width, alt)];
    
    UIImageView *imageView = [MMImageView criarObjetoRetangulo:CGRectMake(0, 0, view.frame.size.width, view.frame.size.height)];
    imageView.backgroundColor = [UIColor lightGrayColor];
    
    
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    [scrollView setFrame:CGRectMake(0, 0, view.frame.size.width, view.frame.size.height)];
    [scrollView setContentSize:CGSizeMake(view.frame.size.width, view.frame.size.height)];
    
    [scrollView addSubview:imageView];
    [view addSubview:scrollView];
    
    
    posicaoY += alt;
    posicaoY += POSICAO_Y;
    
    return view;
}
// FOTO view
-(UIImageView *)criarViewIconeFoto{
    
    UIImageView *fotorView;
    
    fotorView = [MMImageView criarObjetoRedondo:CGRectMake((self.view.frame.size.width/2)-50, (170/2)-50, 100, 100)];
    
    
    return fotorView;
}
// Titulo Sessao View
-(UIView *)criarViewTitulo{
    
    UIView *retView;

    retView = [MMView criarRetanguloTitulo:CGRectMake(POSICAO_X, posicaoY, self.view.frame.size.width-(2*POSICAO_X), 20)];

    posicaoY += retView.frame.size.height;
    posicaoY += POSICAO_Y;
    
    return retView;
}
// TextField View
-(UITextField *)criarTextFieldLargura:(int)larg altura:(int)alt nomeTextField:(NSString *)textNome
{
    
    caixaTexto = [MMTextField criarObjeto:CGRectMake(POSICAO_X, posicaoY, larg, alt)];
    caixaTexto.placeholder = textNome;
    [caixaTexto setDelegate:self];
 
    posicaoY += caixaTexto.frame.size.height;
    posicaoY += POSICAO_Y;
    
    return caixaTexto;
}

// Criar Label
-(UILabel *)criarLabel:(NSString *)text corTexto:(UIColor *)corText{
    
    UILabel *labelText;
    
    labelText = [MMLabel criarTitulo:CGRectMake(POSICAO_X, (POSICAO_Y)-5, (self.view.frame.size.width)-(2*POSICAO_X), 10)];
    labelText.text = text;
    labelText.textColor = corText;
    
    return labelText;
}


-(UIImageView *)criarViewFotoBlur
{
    UIImageView *fundoView;
    
    fundoView = [MMImageView criarObjetoRetangulo:CGRectMake(0, posicaoY, self.view.frame.size.width, 170)];
    UIImageView *icone = [MMImageView criarObjetoRedondo:CGRectMake((fundoView.frame.size.width/2)-40, (fundoView.frame.size.height/2)-40, 80, 80)];
    
    [fundoView addSubview:icone];
    
    posicaoY += fundoView.frame.size.height;
    posicaoY += POSICAO_Y;
    
    return fundoView;
}

-(UIView *)criarBotaoAdicionarComTexto:(NSString *)texto{
    
    
    UIView *view;
    UILabel *label;
    UIImageView *image;
    
    view = [MMView criarRetanguloAdicionar:CGRectMake(POSICAO_X, posicaoY, (self.view.frame.size.width)-(2*POSICAO_X), 35)];
    
    image = [MMImageView criarObjetoAdicionar:CGRectMake(0, 0, view.frame.size.height, view.frame.size.height)];
    label = [MMLabel criarTitulo:CGRectMake((image.frame.size.width)+20, 0, (view.frame.size.width)-(image.frame.size.width), view.frame.size.height)];
    
    
    
    label.text = texto;
    label.textColor = [UIColor blackColor];
    
    [view addSubview:image];
    [view addSubview:label];
    
    
    posicaoY += view.frame.size.height;
    posicaoY += POSICAO_Y;
    
    posicaoYPegaValor = posicaoY;

    
    return view;
}


-(UIDatePicker *)criarDatePickerNascimento
{
    UIDatePicker *datePicker;
    datePicker = [MMDatePicker criarDatePickerNasc:CGRectMake(0, 300, (self.view.frame.size.width), 170)];
    
//    posicaoY += datePicker.frame.size.height;
//    posicaoY += POSICAO_Y;
    
    return datePicker;
}

- (UITextField *)criarTextFieldComData:(NSDate *)data {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle: NSDateFormatterMediumStyle]; //Choose the appropriate style for your case
    
    NSString *strData = [dateFormatter stringFromDate:data];
    
    
    //    UIDatePicker *datePicker = [[UIDatePicker alloc] init];
    //    http://stackoverflow.com/questions/3716633/passing-parameters-on-button-actionselector
    MMDatePicker *datePickerTextField = [[MMDatePicker alloc] init];
    datePickerTextField.label = datePickerLabel;
    
    [datePickerTextField setDatePickerMode:UIDatePickerModeDate];
    [datePickerTextField addTarget:self action:@selector(updateTextFieldData:) forControlEvents:UIControlEventAllEvents];
    if (data) {
        [datePickerTextField setDate:data];
    }
    
    [datePickerLabel setInputView:datePickerTextField];
    
    return datePickerLabel;
}
- (void)updateTextFieldData:(id)sender {
    MMDatePicker *datePickerTextField = (MMDatePicker *)sender;
    UITextField *textField = datePickerTextField.label;
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle: NSDateFormatterMediumStyle]; //Choose the appropriate style for your case
    
    textField.text = [dateFormatter stringFromDate:datePickerTextField.date];
    
    //    [[NSNotificationCenter defaultCenter] postNotificationName:UITextFieldTextDidEndEditingNotification object:textField];
}

-(UIView *)criarDateFormatterComLabel:(NSString *)nome
{
    UIView *view;
    view = [MMView criarRetanguloDaPickerView:CGRectMake(POSICAO_X, posicaoY, (self.view.frame.size.width), 35)];
    
    UILabel *labelText;
    
    labelText = [MMLabel criarObjeto:CGRectMake(0, 0, (self.view.frame.size.width)/2, (view.frame.size.height))];
    //    ADICIONAR TAMANHO DA FONTE
    labelText.text = nome;
    labelText.textColor = [UIColor grayColor];
    
    
    datePickerLabel = [MMTextField criarObjeto:CGRectMake((labelText.frame.size.width)+10, 0, (self.view.frame.size.width)/2-(10), (view.frame.size.height)) ];
    
    NSDateFormatter *dateFormatter;
    dateFormatter = [MMNSDateFormater criarDateFormatter];
    
    
    datePickerLabel.text = [NSString stringWithFormat:@"%@",
                            [dateFormatter stringFromDate:[NSDate date]]];
    
    [view addSubview:labelText];
    [view addSubview:datePickerLabel];
    posicaoY += view.frame.size.height;
    posicaoY += POSICAO_Y;
    
   
    return view;
    
}

- (void)DatePickerLabel:(UITextField *)label
{
    datePickerLabel = label;
    
}



-(UIView *)criarRetanguloScrollData
{
    UIView *retanguloScroll;
    retanguloScroll = [MMView criarRetanguloDataScroll:CGRectMake(POSICAO_X*25, posicaoY, 110, 35)];
    
    posicaoY += retanguloScroll.frame.size.height;
    posicaoY += POSICAO_Y;
    
    return retanguloScroll;
}
-(UIView *)criarSwitchComLabel:(NSString *)texto
{
    UIView *view = [self criarViewAltura:30];
   
    UISwitch *btn = [[UISwitch alloc] init];
    [btn setFrame:CGRectMake(POSICAO_X, POSICAO_Y, btn.frame.size.width, view.frame.size.height - (POSICAO_X*2))];
    [view addSubview:btn];
    
    UILabel *lbl = [[UILabel alloc] init];
    [lbl setFrame:CGRectMake(POSICAO_X + 15 + btn.frame.size.width, POSICAO_Y + POSICAO_X, view.frame.size.width - (POSICAO_X + 5 + btn.frame.size.width), view.frame.size.height - (POSICAO_X*2))];
    [lbl setText:texto];
    [view addSubview:lbl];
    
    posicaoY += view.frame.size.height;
    posicaoY += POSICAO_Y;
    
    return view;
}

-(UIView *)criarPickerTipoSanguineo:(NSString *)nome
{
    UIView *view;
    view = [MMView criarRetanguloDaPickerView:CGRectMake(POSICAO_X, posicaoY, (self.view.frame.size.width)-(3*POSICAO_X), 35)];
    
    UILabel *label;
    label = [MMLabel criarObjeto:CGRectMake(0, 0, (self.view.frame.size.width)/2, 35)];
    label.text = nome;
    label.textColor = [UIColor grayColor];
    
    UILabel *conteudoPicker;
    conteudoPicker = [MMLabel criarObjeto:CGRectMake((label.frame.size.width)+15, 0, (self.view.frame.size.width)/2, label.frame.size.height)];
    conteudoPicker.text = @"A+";
    
    [view addSubview:label];
    [view addSubview:conteudoPicker];
    
    posicaoY += view.frame.size.height;
    posicaoY += POSICAO_Y;
    
    return view;
}

-(UIView *)criarPickerSexoBiologico:(NSString *)nome
{
    UIView *view;
    view = [MMView criarRetanguloDaPickerView:CGRectMake(POSICAO_X, posicaoY, (self.view.frame.size.width), 35)];
    
    UILabel *label;
    label = [MMLabel criarObjeto:CGRectMake(0, 0, (self.view.frame.size.width)/2, 35)];
    label.text = nome;
    label.textColor = [UIColor grayColor];
    
    UILabel *conteudoPicker;
    conteudoPicker = [MMLabel criarObjeto:CGRectMake((label.frame.size.width)+15, 0, (self.view.frame.size.width)/2, label.frame.size.height)];
    conteudoPicker.text = @"teste";
    
    [view addSubview:label];
    [view addSubview:conteudoPicker];
    
    posicaoY += view.frame.size.height;
    posicaoY += POSICAO_Y;
    
    return view;
    
    
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    return  YES;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [[event allTouches] anyObject];
    
    //Verifique se o seu textField está com o teclado aberto e se o toque foi fora dele.
        if ([caixaTexto isFirstResponder] && [touch view] != caixaTexto) {
            [caixaTexto resignFirstResponder];
    
    
        }
    
    [super touchesBegan:touches withEvent:event];
}





//IMPLEMENTANDO AS PICKER VIEWS


- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UIView *testeApenax;
    
    return testeApenax;
}



@end
