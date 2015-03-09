//
//  MMUIViewDrawRect.m
//  Projeto Final
//
//  Created by Leonardo Felipe da Silva on 12/3/14.
//  Copyright (c) 2014 Mack Mobile - BEPiD. All rights reserved.
//

#import "MMUIViewDrawRect.h"

@interface MMUIViewDrawRect ()
{
    NSArray *cores;
}

@end

@implementation MMUIViewDrawRect

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        // Initialization code
    }
    
    return self;
}

- (id)initWithFrame:(CGRect)frame andCores:(NSArray *)arrayCores
{
    self = [super initWithFrame:frame];
    
    if (self) {
        // Initialization code
        
        cores = arrayCores;
        
        [self setBackgroundColor:[UIColor clearColor]];
    }
    
    return self;
}

- (id)initWithPosition:(CGPoint)position andSize:(CGFloat)size andCores:(NSArray *)arrayCores
{
    CGRect frame = CGRectMake(position.x, position.y, size, size);
    
    return [self initWithFrame:frame andCores:arrayCores];
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGFloat tamanhoCor = (M_PI*2)/cores.count;
    for (int i=0; i<cores.count; i++) {
        CGContextSetStrokeColorWithColor(context, [[cores objectAtIndex:i] CGColor]);
        
        UIBezierPath *bezier = [UIBezierPath bezierPath];
        [bezier setLineWidth:5.0];
        [bezier addArcWithCenter:CGPointMake(rect.size.width/2, rect.size.height/2) radius:((rect.size.width/2)-bezier.lineWidth+2.5) startAngle:tamanhoCor*i endAngle:tamanhoCor*(i+1) clockwise:YES];
        [bezier stroke];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
