//
//  ListaConsultaViewController.h
//  Projeto Final
//
//  Created by Leonardo Felipe da Silva on 12/7/14.
//  Copyright (c) 2014 Mack Mobile - BEPiD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConsultaManager.h"
#import "BaseManager.h"

@interface ListaConsultaViewController : UITableViewController<
UITableViewDelegate, UITableViewDataSource>

@property NSArray *consultas;
@property ConsultaManager *consulta;
@property UILabel *nome;
@property UILabel *Data;
@property NSString *dataLabel;
-(void)adicionarConsulta:(id)sender;

@end
