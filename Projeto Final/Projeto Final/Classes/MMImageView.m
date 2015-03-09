//
//  MMImageView.m
//  Projeto Final
//
//  Created by Lucas Saito on 26/08/14.
//  Copyright (c) 2014 Mack Mobile - BEPiD. All rights reserved.
//

#import "MMImageView.h"

@implementation MMImageView

- (id)init {
    self = [super init];
    
    if (self) {
        //personalizar ImageView
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

#pragma mark - Implementação dos métodos para criar os objetos

+ (UIImageView *)criarObjetoRedondo:(CGRect)rect
{
    UIImageView *imageView = [[UIImageView alloc] init];

    [imageView setFrame:rect];
    
    imageView.layer.cornerRadius = (rect.size.width/2);
    imageView.layer.borderColor = [UIColor whiteColor].CGColor;
    imageView.layer.borderWidth = 2;
    imageView.clipsToBounds = YES;
    
//    imageView.backgroundColor = [UIColor greenColor];
    
    return imageView;
}

+ (UIImageView *)criarObjetoRetangulo:(CGRect)rect
{
    UIImageView *imageView = [[UIImageView alloc] init];
   
    [imageView setFrame:rect];
    
    return imageView;
}

+(UIImageView *)criarObjetoAdicionar:(CGRect)rect
{
    UIImageView *image = [[UIImageView alloc] init];
    
    image.frame = rect;
    [image setFrame:rect];
    image.backgroundColor = [UIColor greenColor];
//    [image setImage:<#(UIImage *)#>];
    return image;
}



@end
