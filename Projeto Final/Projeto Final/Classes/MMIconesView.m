//
//  MMIconesView.m
//  Projeto Final
//
//  Created by Leonardo Felipe da Silva on 12/3/14.
//  Copyright (c) 2014 Mack Mobile - BEPiD. All rights reserved.
//

#import "MMIconesView.h"

@implementation MMIconesView


-(UIImageView *)criarViewIcone:(NSString *)nomeIcone eSize:(CGRect)size
{
    UIImageView *view = [[UIImageView alloc]init];
    view.frame = CGRectMake(size.origin.x, size.origin.y, size.size.width, size.size.height);
    UIImage *image = [UIImage imageNamed:nomeIcone];
    [view setImage:image];
    return view;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
