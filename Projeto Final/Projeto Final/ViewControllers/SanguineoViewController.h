//
//  SanguineoViewController.h
//  Projeto Final
//
//  Created by Leonardo Felipe da Silva on 04/09/14.
//  Copyright (c) 2014 Mack Mobile - BEPiD. All rights reserved.
//

#import "BoxesCreatorViewController.h"
#import "PessoaManager.h"

@interface SanguineoViewController : BoxesCreatorViewController <UITableViewDataSource, UITableViewDelegate>
@property UIPickerView *pickerView;
@property UITableView *tableViewNome;
@property NSString *tipoSanguineo;
@property Pessoa *pessoa;
@end
