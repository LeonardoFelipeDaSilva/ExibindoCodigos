//
//  MMView.m
//  Projeto Final
//
//  Created by Lucas Saito on 26/08/14.
//  Copyright (c) 2014 Mack Mobile - BEPiD. All rights reserved.
//

#import "MMView.h"

@implementation MMView

- (id)init {
    self = [super init];
    
    if (self) {
        //personalizar View
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

+ (UIView *)criarRetangulo:(CGRect)rect
{
    UIView *view;
    
    view = [[UIView alloc] init];
    [view setFrame:rect];
    
    return view;
}
+(UIView *)criarRetanguloTitulo:(CGRect)rect
{
    UIView *view;
    
    view = [[UIView alloc]initWithFrame:rect];
    view.layer.borderColor = ([UIColor clearColor].CGColor);
    view.layer.borderWidth = 5;
    view.backgroundColor = [UIColor grayColor];
    return view;
}

+(UIView *)criarRetanguloAdicionar:(CGRect)rect
{
    UIView *view;
    view = [[UIView alloc]initWithFrame:rect];
    return view;
}

+(UIView *)criarRetanguloDataScroll:(CGRect)rect
{
    UIView *view;
    view = [[UIView alloc]initWithFrame:rect];
    view.layer.borderColor = ([UIColor grayColor].CGColor);
    view.layer.borderWidth = 2;
    view.backgroundColor = [UIColor colorWithRed:221/255.0f green:221/255.0f blue:221/255.0f alpha:1];
    return  view;
    
}

+(UIView *)criarRetanguloDaPickerView:(CGRect)rect
{
    UIView *view;
    view = [[UIView alloc]initWithFrame:rect];
//    view.layer.borderColor = ([UIColor grayColor].CGColor);
//    view.layer.borderWidth = 2;
//    view.backgroundColor = [UIColor colorWithRed: 221/255.0f green:221/255.0f blue:221/255.0f alpha:1];
    return view;
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
