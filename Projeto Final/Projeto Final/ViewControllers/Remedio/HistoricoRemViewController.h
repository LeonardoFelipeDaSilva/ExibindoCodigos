//
//  HistoricoRemViewController.h
//  Projeto Final
//
//  Created by Lucas Saito on 14/09/14.
//  Copyright (c) 2014 Mack Mobile - BEPiD. All rights reserved.
//

#import "BaseViewController.h"
#import "HistoricoRem.h"
#import "TableViewItensEventoSource.h"
#import "MMTableViewSource.h"

@interface HistoricoRemViewController : BaseViewController <UITableViewDataSource, UITableViewDelegate>
{
    HistoricoRem *historicoRem;
    Remedio *remedio;
}

@property HistoricoRem *historicoRem;
@property Remedio *remedio;

@property TableViewItensEventoSource *tableViewItensEventosSource;
@property MMTableViewSource *tableViewNotificationsSource;

@end
