//
//  ListaExamesTableViewController.h
//  Projeto Final
//
//  Created by Leonardo Felipe da Silva on 17/10/14.
//  Copyright (c) 2014 Mack Mobile - BEPiD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ExameManager.h"
#import "BaseManager.h"
@interface ListaExamesTableViewController : UITableViewController<UITableViewDelegate, UITableViewDataSource>

@property NSArray *exames;
@property ExameManager *exame;
@property UILabel *nome;
@property UILabel *Data;
@property NSString *dataLabel;
-(void)adicionarExame:(id)sender;
@end
