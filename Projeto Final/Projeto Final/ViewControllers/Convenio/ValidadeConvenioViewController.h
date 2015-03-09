//
//  ValidadeConvenioViewController.h
//  Projeto Final
//
//  Created by Leonardo Felipe da Silva on 24/09/14.
//  Copyright (c) 2014 Mack Mobile - BEPiD. All rights reserved.
//

#import "BoxesCreatorViewController.h"
#import "ConvenioManager.h"

@interface ValidadeConvenioViewController : BoxesCreatorViewController
<UITableViewDataSource, UITableViewDelegate>
@property UITableView *tableViewNome;
@property UILabel *dataValidade;
@property Convenio *convenio;
@property NSDate *data;
@end
