//
//  LocalExameTableViewController.h
//  Projeto Final
//
//  Created by Leonardo Felipe da Silva on 17/10/14.
//  Copyright (c) 2014 Mack Mobile - BEPiD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ExameManager.h"

@interface LocalExameTableViewController : UITableViewController <UITableViewDelegate, UITableViewDataSource>

@property Exame *exame;
@property UITextField *textField;
@property UIButton *clearButton;
@end
