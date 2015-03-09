//
//  MMTextField.m
//  Projeto Final
//
//  Created by Lucas Saito on 26/08/14.
//  Copyright (c) 2014 Mack Mobile - BEPiD. All rights reserved.
//

#import "MMTextField.h"

@implementation MMTextField

- (id)init {
    self = [super init];
    
    if (self) {
        //personalizar TextField
    }
    
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

+ (UITextField *)criarObjeto:(CGRect)rect
{
    UITextField *textField = [[UITextField alloc] init];
    
    [textField setFrame:rect];
    [textField setBorderStyle:UITextBorderStyleNone];
    [textField setReturnKeyType:UIReturnKeyDone];
    
    
    return textField;
}

@end
