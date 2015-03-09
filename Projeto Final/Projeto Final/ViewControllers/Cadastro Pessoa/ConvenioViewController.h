//
//  ConvenioViewController.h
//  Projeto Final
//
//  Created by Leonardo Felipe da Silva on 24/09/14.
//  Copyright (c) 2014 Mack Mobile - BEPiD. All rights reserved.
//

#import "BoxesCreatorViewController.h"
#import "ConvenioManager.h"
@interface ConvenioViewController : BoxesCreatorViewController<UITableViewDataSource, UITableViewDelegate>
{
    UITableView *TableView;
}
@property UITableView *TableView;
@property Pessoa *pessoa;
@property Convenio *convenio;
@property NSString *dataValidade;
- (void)salvarConvenio;
@end
