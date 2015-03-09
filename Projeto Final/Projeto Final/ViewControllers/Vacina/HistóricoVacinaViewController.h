//
//  HistóricoVacinaViewController.h
//  Projeto Final
//
//  Created by Leonardo Felipe da Silva on 10/24/14.
//  Copyright (c) 2014 Mack Mobile - BEPiD. All rights reserved.
//

#import "BoxesCreatorViewController.h"
#import "VacinaManager.h"
#import "HistoricoVacina.h"
@interface Histo_ricoVacinaViewController : BoxesCreatorViewController <UITableViewDataSource, UITableViewDelegate>

@property Vacina *vacina;
@property HistoricoVacina *histVacina;
@property UITableView *tableView2;
@property NSString *dataTomada;

-(void)salvarHistVacina:(id)sender;
- (id)initWithHist:(HistoricoVacina *)histVacina;



@end
