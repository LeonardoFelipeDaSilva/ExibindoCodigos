//
//  IndexViewController.h
//  Projeto Final
//
//  Created by Leonardo Felipe da Silva on 22/08/14.
//  Copyright (c) 2014 Mack Mobile - BEPiD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BoxesCreatorViewController.h"
#import "MMIconesView.h"

@interface IndexViewController : UITableViewController<UIGestureRecognizerDelegate, UITabBarDelegate>
@property UITabBarController *tabBar;
@property MMIconesView *principal;
@property UILabel *data;
@property UIView *viewLabel;
@property UIImageView *imagemViewLabel;
-(void)onTap:(NSIndexPath *)indexPath;
-(void)longTap:(NSIndexPath *)indexPath;

@end
