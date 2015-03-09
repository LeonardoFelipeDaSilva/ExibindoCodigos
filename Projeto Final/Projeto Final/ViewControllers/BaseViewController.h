//
//  BaseViewController.h
//  Projeto Final
//
//  Created by Lucas Saito on 29/08/14.
//  Copyright (c) 2014 Mack Mobile - BEPiD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MMPrincipal.h"
#import "UnidadeDeTempo.h"

@interface BaseViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate, UIActionSheetDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UIPickerViewDataSource, UIPickerViewDelegate>
{
    UIScrollView *mainView;
    int posicaoY;
    UIView *refViewScroll;
    UIImageView *refImageViewPicker;
}

- (UIView *)criarView:(CGFloat)altura;

- (UIView *)criarViewSubTituloNaView:(UIView *)view comLabel:(NSString *)texto;

- (UILabel *)criarLabelNaView:(UIView *)view comLabel:(NSString*)label comTexto:(NSString *)texto;

- (UITableView *)criarTableViewNaView:(UIView *)view comAltura:(CGFloat)altura;

- (UIImageView *)criarImageViewBlurNaView:(UIView *)view;
- (UIImageView *)criarImageViewIconeNaView:(UIView *)view;

- (UITextField *)criarTextFieldNaView:(UIView *)view comLabel:(NSString *)label;
- (UITextField *)criarTextFieldNaView:(UIView *)view comTexto:(NSString *)texto;
- (UITextField *)criarTextFieldDataNaView:(UIView *)view comData:(NSDate *)data;
- (UITextField *)criarTextFieldDataHoraNaView:(UIView *)view comDataHora:(NSDate *)dataHora;
- (UISwitch *)criarSwitchNaView:(UIView *)view comLabel:(NSString *)texto;
- (UISegmentedControl *)criarSegmentedControlNaView:(UIView *)view comValores:(NSArray *)valores;
- (UIPickerView *)criarPickerViewNoTextField:(UITextField *)textField comUnidadeDeTempo:(UnidadeDeTempo *)unidadeDeTempo;

- (UIView *)criarViewBtnAdicionarNaView:(UIView *)view comLabel:(NSString *)texto;

- (void)toqueImageView:(id)sender;

- (void)setContentSizeScrollView;

@end
