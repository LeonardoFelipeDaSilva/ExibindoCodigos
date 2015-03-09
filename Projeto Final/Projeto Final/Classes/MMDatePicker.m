//
//  MMDatePicker.m
//  Projeto Final
//
//  Created by Leonardo Felipe da Silva on 28/08/14.
//  Copyright (c) 2014 Mack Mobile - BEPiD. All rights reserved.
//

#import "MMDatePicker.h"

@implementation MMDatePicker
@synthesize  label;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

+(UIDatePicker *)criarDatePickerNasc:(CGRect)rect
{
    UIDatePicker *datePicker;
    
    datePicker = [[UIDatePicker alloc]initWithFrame:rect];
    datePicker.datePickerMode = UIDatePickerModeDate;
    datePicker.hidden = NO;
    datePicker.date = [NSDate date];
    

    
//    texto.text=[NSString stringWithFormat:@"%@",
//                [df stringFromDate:[NSDate date]]];
   
    // set action for date picker
    
//    [datePicker addTarget:self  action:@selector(DateChange:)
//         forControlEvents:UIControlEventValueChanged];
    return datePicker;
    //method for change date
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
