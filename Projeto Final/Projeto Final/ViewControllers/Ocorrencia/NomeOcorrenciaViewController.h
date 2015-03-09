//
//  NomeOcorrenciaViewController.h
//  Projeto Final
//
//  Created by Leonardo Felipe da Silva on 10/10/14.
//  Copyright (c) 2014 Mack Mobile - BEPiD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OcorrenciaManager.h"

@interface NomeOcorrenciaViewController : UITableViewController<UITableViewDelegate, UITableViewDataSource>

@property OcorrenciaDoenca *ocorrencia;
@property UITextField *textField;
@property UIButton *clearButton;
-(void)selBtnDone:(id)sender;
-(void)salvar;
@end
