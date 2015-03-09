//
//  LocalVacinaViewController.h
//  Projeto Final
//
//  Created by Leonardo Felipe da Silva on 23/09/14.
//  Copyright (c) 2014 Mack Mobile - BEPiD. All rights reserved.
//

#import "BoxesCreatorViewController.h"
#import "VacinaManager.h"

@interface LocalVacinaViewController : BoxesCreatorViewController<UITableViewDataSource, UITableViewDelegate>
{
    HistoricoVacina *histVacina;
}

@property HistoricoVacina *histVacina;
@property UITableView *tableViewNome;
@property UITextField *nomeTexField;
@property Vacina *vacina;
@property UIButton *clearButton;

- (void)selBtnDone:(id)sender;
- (void)salvar;


@end
