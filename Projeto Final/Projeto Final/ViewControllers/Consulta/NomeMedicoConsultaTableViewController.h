//
//  NomeMedicoConsultaTableViewController.h
//  Projeto Final
//
//  Created by Leonardo Felipe da Silva on 12/7/14.
//  Copyright (c) 2014 Mack Mobile - BEPiD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConsultaManager.h"

@interface NomeMedicoConsultaTableViewController : UITableViewController<
UITableViewDataSource, UITableViewDelegate>

@property Consulta *consulta;
@property Medico *medico;
@property UITextField *textField;
@property UIButton *clearButton;
//-(void) selBtnDone:(id)sender;
-(void) salvar;

@end
