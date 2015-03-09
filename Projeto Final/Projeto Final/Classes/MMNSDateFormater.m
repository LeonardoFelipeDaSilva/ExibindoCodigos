//
//  MMNSDateFormater.m
//  Projeto Final
//
//  Created by Leonardo Felipe da Silva on 29/08/14.
//  Copyright (c) 2014 Mack Mobile - BEPiD. All rights reserved.
//

#import "MMNSDateFormater.h"

@implementation MMNSDateFormater

+(NSDateFormatter *)criarDateFormatter
{
    NSDateFormatter *dateFormatter;
    
    
    dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.timeStyle = NSDateFormatterNoStyle;
    dateFormatter.dateFormat = @"dd/MM/yyyy";
    
    return dateFormatter;
}


@end
