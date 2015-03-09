//
//  MMView.h
//  Projeto Final
//
//  Created by Lucas Saito on 26/08/14.
//  Copyright (c) 2014 Mack Mobile - BEPiD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MMView : UIView

+(UIView *)criarRetangulo:(CGRect)rect;
+(UIView *)criarRetanguloTitulo:(CGRect)rect;
+(UIView *)criarRetanguloAdicionar:(CGRect)rect;
+(UIView *)criarRetanguloDataScroll:(CGRect)rect;
+(UIView *)criarRetanguloDaPickerView:(CGRect)rect;

@end
