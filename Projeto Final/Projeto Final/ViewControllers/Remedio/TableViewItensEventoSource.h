//
//  TableViewItensEventosHistoricoRem.h
//  Projeto Final
//
//  Created by Lucas Saito on 30/10/14.
//  Copyright (c) 2014 Mack Mobile - BEPiD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EventoRepeticao.h"

@interface TableViewItensEventoSource : NSObject <UITableViewDataSource, UITableViewDelegate>

- (id)initWithEvento:(EventoRepeticao *)evento;

@end
