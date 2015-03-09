//
//  DataTomVacinaViewController.h
//  Projeto Final
//
//  Created by Leonardo Felipe da Silva on 23/09/14.
//  Copyright (c) 2014 Mack Mobile - BEPiD. All rights reserved.
//

#import "BoxesCreatorViewController.h"
#import "VacinaManager.h"

@interface DataTomVacinaViewController : BoxesCreatorViewController<UITableViewDataSource, UITableViewDelegate>
{
    HistoricoVacina *histVacina;
    
}
@property UITableView *tableViewNome;
@property UILabel *dataTomada;
@property HistoricoVacina *histVacina;
@property NSDate *data;

- (void)selBtnDone:(id)sender;
- (void)salvar;

@end
