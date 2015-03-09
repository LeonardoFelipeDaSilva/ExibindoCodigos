//
//  DataNascimentoViewController.h
//  Projeto Final
//
//  Created by Leonardo Felipe da Silva on 04/09/14.
//  Copyright (c) 2014 Mack Mobile - BEPiD. All rights reserved.
//

#import "BoxesCreatorViewController.h"
#import "PessoaManager.h"

@interface DataNascimentoViewController : BoxesCreatorViewController <UITableViewDataSource, UITableViewDelegate>
@property UITableView *tableViewNome;
@property UILabel *dataNasimento;
@property Pessoa *pessoa;
@property NSDate *data;
@end
