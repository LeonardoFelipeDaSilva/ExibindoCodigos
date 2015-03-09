//
//  MMCarregarImagem.h
//  Projeto Final
//
//  Created by Lucas Saito on 08/09/14.
//  Copyright (c) 2014 Mack Mobile - BEPiD. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MMCarregarImagem : NSObject {
    UIActivityIndicatorView *activityIndicator;
}

- (void)processarDado:(NSData *)dado naImageView:(UIImageView *)imageView;
- (void)processarImagem:(UIImage *)imagem naImageView:(UIImageView *)imageView;

@end
