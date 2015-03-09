//
//  MMLabel.m
//  Projeto Final
//
//  Created by Lucas Saito on 26/08/14.
//  Copyright (c) 2014 Mack Mobile - BEPiD. All rights reserved.
//

#import "MMLabel.h"

@implementation MMLabel
@synthesize label;
- (id)init {
    self = [super init];
    
    if (self) {
        //personalizar Label
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

+ (UILabel *)criarObjeto:(CGRect)rect
{
    UILabel *label = [[UILabel alloc] init];
    
    [label setFrame:rect];
    
    return label;
}

+ (UILabel *)criarTitulo:(CGRect)rect
{
    UILabel *label = [[UILabel alloc] init];
    
    [label setFrame:rect];
    [label setTextAlignment:NSTextAlignmentLeft];
    label.font = [UIFont boldSystemFontOfSize:11];
    label.alpha = 1;
    
    return label;
}

+(UILabel *)criarBtn:(CGRect)rect
{
    UILabel *label = [[UILabel alloc] init];
    
    [label setFrame:rect];
    [label setTextAlignment:NSTextAlignmentLeft];
    [label setFont:[UIFont boldSystemFontOfSize:14]];
    
    return label;
}

@end
