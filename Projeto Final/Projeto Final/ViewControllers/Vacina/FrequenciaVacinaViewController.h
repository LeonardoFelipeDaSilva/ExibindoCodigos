//
//  FrequenciaVacinaViewController.h
//  Projeto Final
//
//  Created by Leonardo Felipe da Silva on 23/09/14.
//  Copyright (c) 2014 Mack Mobile - BEPiD. All rights reserved.
//

#import "BoxesCreatorViewController.h"
#import "VacinaManager.h"

@interface FrequenciaVacinaViewController : BoxesCreatorViewController<UITableViewDataSource, UITableViewDelegate>
{
    Vacina *vacina;
}
@property NSDate *data;
@property UITableView *tableViewNome;
@property UILabel *frequencia;
@property Vacina *vacina;


- (void)selBtnDone:(id)sender;
- (void)salvar;

@end
