//
//  MMCarregarImagem.m
//  Projeto Final
//
//  Created by Lucas Saito on 08/09/14.
//  Copyright (c) 2014 Mack Mobile - BEPiD. All rights reserved.
//

#import "MMCarregarImagem.h"

@implementation MMCarregarImagem

- (void)processarDado:(NSData *)dado naImageView:(UIImageView *)imageView {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void){
        dispatch_async(dispatch_get_main_queue(), ^{
            activityIndicator = [[UIActivityIndicatorView alloc] init];
            [activityIndicator setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleGray];
            [activityIndicator setCenter:CGPointMake(imageView.bounds.size.width/2, imageView.bounds.size.height/2)];
            [activityIndicator startAnimating];
            [activityIndicator setHidden:NO];
            [imageView addSubview:activityIndicator];
        });
        
        UIImage *imagem;
        if (dado) {
//            imagem = (UIImage *)[NSKeyedUnarchiver unarchiveObjectWithData:dado];
            imagem = [UIImage imageWithData:dado];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [activityIndicator stopAnimating];
            activityIndicator = nil;
            
            [imageView setImage:imagem];
        });
    });
}

- (void)processarImagem:(UIImage *)imagem naImageView:(UIImageView *)imageView {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void){
        dispatch_async(dispatch_get_main_queue(), ^{
            activityIndicator = [[UIActivityIndicatorView alloc] init];
            [activityIndicator setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleGray];
            [activityIndicator setCenter:CGPointMake(imageView.bounds.size.width/2, imageView.bounds.size.height/2)];
            [activityIndicator startAnimating];
            [activityIndicator setHidden:NO];
            [imageView addSubview:activityIndicator];
        });
        
        UIImage *newImage;
        if (imagem) {
            NSData *dado = UIImageJPEGRepresentation(imagem, 1.0);
            newImage = [UIImage imageWithData:dado];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [activityIndicator stopAnimating];
            activityIndicator = nil;
            
            [imageView setImage:newImage];
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"atualizarImagem" object:imageView];
        });
    });
}

@end
