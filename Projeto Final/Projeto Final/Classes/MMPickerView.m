//
//  MMPickerView.m
//  Projeto Final
//
//  Created by Leonardo Felipe da Silva on 29/08/14.
//  Copyright (c) 2014 Mack Mobile - BEPiD. All rights reserved.
//

#import "MMPickerView.h"

@implementation MMPickerView

@synthesize label, unidadeDeTempo;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

+(UIPickerView *)criarPickerView:(CGRect)rect
{
    UIPickerView *picker = [[UIPickerView alloc]initWithFrame:rect];
    picker.showsSelectionIndicator = YES;
    return picker;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
