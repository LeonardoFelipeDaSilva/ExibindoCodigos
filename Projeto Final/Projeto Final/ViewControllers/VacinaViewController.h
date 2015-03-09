//
//  VacinaViewController.h
//  Projeto Final
//
//  Created by Leonardo Felipe da Silva on 08/09/14.
//  Copyright (c) 2014 Mack Mobile - BEPiD. All rights reserved.
//

#import "BoxesCreatorViewController.h"
#import "BaseViewController.h"
#import "VacinaManager.h"
#import "HistoricoVacina.h"

@interface VacinaViewController : BoxesCreatorViewController
@property Vacina *vacina;

@property UITableView *tableView2;
@property NSString *dataTomada;

- (void)salvarVacina:(id)sender;

@end
