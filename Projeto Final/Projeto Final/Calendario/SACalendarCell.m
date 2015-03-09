//
//  SACalendarCell.m
//  SACalendarExample
//
//  Created by Nop Shusang on 7/12/14.
//  Copyright (c) 2014 SyncoApp. All rights reserved.
//
//  Distributed under MIT License

#import "SACalendarCell.h"
#import "SACalendarConstants.h"

@implementation SACalendarCell

/**
 *  Draw the basic components of the cell, including the top grey line, the red current date circle,
 *  the black selected circle and the date label. Customized the cell apperance by editing this function.
 *
 *  @param frame - size of the cell
 *
 *  @return initialized cell
 */
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.weekLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height * labelToCellRatio)];
        self.weekLabel.textAlignment = NSTextAlignmentCenter;
        
        //        self.backgroundColor = cellBackgroundColor;
        
        self.topLineView = [[UIView alloc]initWithFrame:CGRectMake(-1, 0, frame.size.width + 2, 1)];
        self.topLineView.backgroundColor = cellTopLineColor;
        
        self.sideLineView = [[UIView alloc]initWithFrame:CGRectMake(0, -1, 1,frame.size.height )];
        self.sideLineView.backgroundColor = cellTopLineColor;
        
        
        self.dateLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height-20)];
        self.dateLabel.textAlignment = NSTextAlignmentCenter;
        
        CGRect labelFrame = self.dateLabel.frame;
        CGSize labelSize = labelFrame.size;
        
        CGPoint origin;
        int length;
        if (labelSize.width > labelSize.height) {
            
            origin.x = (labelSize.width - labelSize.height * circleToCellRatio) / 2;
            origin.y = (labelSize.height * (1 - circleToCellRatio)) / 2;
            length = labelSize.height * circleToCellRatio;
        }
        else{
            origin.x = (labelSize.width * (1 - circleToCellRatio)) / 2;
            origin.y = (labelSize.height - labelSize.width * circleToCellRatio) / 2;
            length = labelSize.width * circleToCellRatio;
        }
        
        self.circleView = [[UIView alloc] initWithFrame:CGRectMake(origin.x-8, origin.y+3, 35, 15)];
        //        self.bolinha = [[UIView alloc]initWithFrame:CGRectMake(frame.size.width/2-7, 40, 15, 15)];
        
        //        self.circleView.layer.cornerRadius = length / 2;
        self.circleView.layer.cornerRadius = length/2;
        
        self.circleView.backgroundColor = currentDateCircleColor;
        
        self.selectedView = [[UIView alloc] initWithFrame:CGRectMake(origin.x, origin.y, length, length)];
        
        self.selectedView.layer.cornerRadius = length / 2;
        self.selectedView.backgroundColor = selectedDateCircleColor;
        
        self.bolinha.layer.cornerRadius = length/2.5;
        self.bolinha.backgroundColor = [UIColor colorWithRed:11/255.0f green:96/255.0f blue:186/255.0f alpha:1];
        
        [self.viewForBaselineLayout addSubview:self.weekLabel];
        //        [self.viewForBaselineLayout addSubview:self.topLineView];
        //        [self.viewForBaselineLayout addSubview:self.sideLineView];
        [self.viewForBaselineLayout addSubview:self.circleView];
        //        [self.viewForBaselineLayout addSubview:self.selectedView];
        [self.viewForBaselineLayout addSubview:self.dateLabel];
        //        [self.viewForBaselineLayout addSubview:self.sideRightLineView];
        //        [self.viewForBaselineLayout addSubview:self.downLineView];
        //        [self.viewForBaselineLayout addSubview:self.bolinha];
        
    }
    return self;
}



@end
