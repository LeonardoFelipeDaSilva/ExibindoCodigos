//
//  MMDatePicker.h
//  Projeto Final
//
//  Created by Leonardo Felipe da Silva on 28/08/14.
//  Copyright (c) 2014 Mack Mobile - BEPiD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MMDatePicker : UIDatePicker <UIPickerViewDelegate>
{
    UITextField *label;
}
@property UITextField *label;


+(UIDatePicker *)criarDatePickerNasc:(CGRect)rect;

@end
