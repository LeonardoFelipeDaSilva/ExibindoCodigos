//
//  NomeVacinaViewController.h
//  Projeto Final
//
//  Created by Leonardo Felipe da Silva on 12/09/14.
//  Copyright (c) 2014 Mack Mobile - BEPiD. All rights reserved.
//

#import "BoxesCreatorViewController.h"
#import "VacinaManager.h"

@interface NomeVacinaViewController : BoxesCreatorViewController<UITableViewDataSource, UITableViewDelegate>
@property Vacina *vacina;
@property UITableView *tableViewNome;
@property UITextField *nomeTexField;
@property UIButton *clearButton;



@end
