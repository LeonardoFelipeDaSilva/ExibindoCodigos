//
//  MMImageView.h
//  Projeto Final
//
//  Created by Lucas Saito on 26/08/14.
//  Copyright (c) 2014 Mack Mobile - BEPiD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MMImageView : UIImageView

+ (UIImageView *)criarObjetoRedondo:(CGRect)rect;
+ (UIImageView *)criarObjetoRetangulo:(CGRect)rect;
+(UIImageView *)criarObjetoAdicionar:(CGRect)rect;

@end
