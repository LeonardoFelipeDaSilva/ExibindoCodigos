//
//  DataConsultaTableViewController.h
//  Projeto Final
//
//  Created by Leonardo Felipe da Silva on 12/7/14.
//  Copyright (c) 2014 Mack Mobile - BEPiD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConsultaManager.h"
@interface DataConsultaTableViewController : BoxesCreatorViewController <UITableViewDataSource, UITableViewDelegate>

@property UITableView *tableView2;
@property UILabel *label;
@property Consulta *consulta;
@property NSDate *data;
@end
