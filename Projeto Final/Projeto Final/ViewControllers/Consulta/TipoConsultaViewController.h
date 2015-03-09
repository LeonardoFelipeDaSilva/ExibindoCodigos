//
//  TipoConsultaViewController.h
//  Projeto Final
//
//  Created by Leonardo Felipe da Silva on 12/7/14.
//  Copyright (c) 2014 Mack Mobile - BEPiD. All rights reserved.
//

#import "BaseViewController.h"
#import "ConsultaManager.h"
@interface TipoConsultaViewController :
UITableViewController <UITableViewDelegate, UITableViewDataSource>

@property Consulta *consulta;
@property UITextField *textField;
@property UIButton *clearButton;
//-(void)selBtnDone:(id)sender;
-(void)salvar;
@end
