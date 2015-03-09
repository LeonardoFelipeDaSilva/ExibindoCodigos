//
//  DataExameViewController.h
//  Projeto Final
//
//  Created by Leonardo Felipe da Silva on 17/10/14.
//  Copyright (c) 2014 Mack Mobile - BEPiD. All rights reserved.
//

#import "BoxesCreatorViewController.h"
#import "ExameManager.h"

@interface DataExameViewController : BoxesCreatorViewController <UITableViewDataSource, UITableViewDelegate>

@property UITableView *tableView2;
@property UILabel *label;
@property Exame *exame;
@property NSDate *data;


@end
