//
//  MMTableViewControllerDropDown.h
//  Projeto Final
//
//  Created by Lucas Saito on 28/11/14.
//  Copyright (c) 2014 Mack Mobile - BEPiD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MMPrincipal.h"

@interface MMTableViewControllerDropDown : UITableViewController
{
    NSArray *itensTableView;
    NSMutableArray *flagTableView;
}

- (UIView *)criarFilete:(UIColor *)color andSice:(CGSize)size;

@end
