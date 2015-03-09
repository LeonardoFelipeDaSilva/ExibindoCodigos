//
//  MMPickerView.h
//  Projeto Final
//
//  Created by Leonardo Felipe da Silva on 29/08/14.
//  Copyright (c) 2014 Mack Mobile - BEPiD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MMPrincipal.h"
#import "UnidadeDeTempo.h"

@interface MMPickerView : UIPickerView <UIPickerViewDelegate>
{
    UITextField *label;
    UnidadeDeTempo *unidadeDeTempo;
}

@property UITextField *label;
@property UnidadeDeTempo *unidadeDeTempo;

+(UIPickerView *)criarPickerView:(CGRect)rect;

@end
