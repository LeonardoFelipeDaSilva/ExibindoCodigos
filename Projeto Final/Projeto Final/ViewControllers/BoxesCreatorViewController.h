//
//  BoxesCreatorViewController.h
//  Projeto Final
//
//  Created by Leonardo Felipe da Silva on 23/08/14.
//  Copyright (c) 2014 Mack Mobile - BEPiD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MMPrincipal.h"
#import "BaseViewController.h"

@interface BoxesCreatorViewController : BaseViewController <UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource>
{
    UILabel *labelData;
    
    int posicaoYPegaValor;
}
@property int posicaoYPegaValor;

//VIEWS
-(UIView *)criarBotaoAdicionarComTexto:(NSString *)texto;
-(UIView *)criarRetanguloScrollData;
-(UIView *)criarViewTitulo;
-(UIView *)criarViewAltura:(int)alt;
-(UIView *)criarSwitchComLabel:(NSString *)texto;
-(UIView *)criarPickerTipoSanguineo:(NSString *)nome;
-(UIView *)criarPickerSexoBiologico:(NSString *)nome;
-(UIView *)criarDateFormatterComLabel:(NSString *)nome;
//IMAGEVIEW
-(UIImageView *)criarViewFotoBlur;
-(UIImageView *)criarViewIconeFoto;
//TEXTFIELD
-(UITextField *)criarTextFieldLargura:(int)larg altura:(int)alt nomeTextField:(NSString *)textNome;
//DATEPICKER
-(UIDatePicker *)criarDatePickerNascimento;
//LABEL

-(UILabel *)criarLabelComPosiçãoExistente:(NSString *)text corTexto:(UIColor *)corText;
-(UILabel *)criarLabel:(NSString *)text corTexto:(UIColor *)corText;







- (BOOL)textFieldShouldReturn:(UITextField *)textField;
- (void)toqueScrolDataView:(id)sender ;
- (void)DatePickerLabel:(UILabel *)label;
@end
