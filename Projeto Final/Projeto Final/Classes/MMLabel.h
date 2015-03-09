//
//  MMLabel.h
//  Projeto Final
//
//  Created by Lucas Saito on 26/08/14.
//  Copyright (c) 2014 Mack Mobile - BEPiD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MMLabel : UILabel
{
    UILabel *label;
}
@property UILabel *label;
+ (UILabel *)criarObjeto:(CGRect)rect;
+ (UILabel *)criarTitulo:(CGRect)rect;
+ (UILabel *)criarBtn:(CGRect)rect;

@end
