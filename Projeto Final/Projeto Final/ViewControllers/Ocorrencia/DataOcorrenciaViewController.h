//
//  DataOcorrenciaViewController.h
//  Projeto Final
//
//  Created by Leonardo Felipe da Silva on 14/10/14.
//  Copyright (c) 2014 Mack Mobile - BEPiD. All rights reserved.
//

#import "BoxesCreatorViewController.h"
#import "OcorrenciaManager.h"
@interface DataOcorrenciaViewController : BoxesCreatorViewController <UITableViewDataSource, UITableViewDelegate>


@property UITableView *tableViewNome;
@property UILabel *dataOcorrencia;
@property OcorrenciaDoenca *ocorrencia;
@property NSDate *data;


-(void)selBtnDone:(id)sender;
-(void)salvar;

@end
