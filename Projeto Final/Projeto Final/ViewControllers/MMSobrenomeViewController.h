//
//  MMSobrenomeViewController.h
//  Projeto Final
//
//  Created by Leonardo Felipe da Silva on 04/09/14.
//  Copyright (c) 2014 Mack Mobile - BEPiD. All rights reserved.
//

#import "BoxesCreatorViewController.h"
#import "CadPessoaViewController.h"

@interface MMSobrenomeViewController : BoxesCreatorViewController <UITableViewDataSource, UITableViewDelegate>
@property UITextField *sobrenomeTextField;
@property UITableView *tableViewNome;
@property Pessoa *pessoa;
@property UIButton *clearButton;
@end
