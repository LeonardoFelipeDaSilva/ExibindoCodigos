//
//  SubstanciaAlergiaViewController.h
//  Projeto Final
//
//  Created by Leonardo Felipe da Silva on 11/17/14.
//  Copyright (c) 2014 Mack Mobile - BEPiD. All rights reserved.
//

#import "BaseViewController.h"
#import "PessoaManager.h"

@interface SubstanciaAlergiaViewController : BaseViewController<UITableViewDataSource, UITableViewDelegate>
@property Alergia *alergia;
@property UITableView *tableViewSubs;
@property UITextField *subsTextField;
@property UIButton *clearButton;
- (void)selBtnDone:(id)sender;
@end
