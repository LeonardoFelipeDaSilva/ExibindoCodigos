//
//  ExameViewController.h
//  Projeto Final
//
//  Created by Leonardo Felipe da Silva on 17/10/14.
//  Copyright (c) 2014 Mack Mobile - BEPiD. All rights reserved.
//

#import "BaseViewController.h"
#import "ExameManager.h"
@interface ExameViewController : BaseViewController <UITableViewDataSource, UITableViewDelegate>

@property Exame *exame;
@property Medico *medico;
@property UITableView *tableView2;
@property NSString *dataExame;
@property UIImageView *imageView;

- (void)atualizarImagemImageView:(NSNotification *)notification;

@end
