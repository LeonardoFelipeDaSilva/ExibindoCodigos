//
//  NomeMedicoTableViewController.h
//  Projeto Final
//
//  Created by Leonardo Felipe da Silva on 17/10/14.
//  Copyright (c) 2014 Mack Mobile - BEPiD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ExameManager.h"
@interface NomeMedicoTableViewController : UITableViewController <UITableViewDataSource, UITableViewDelegate>

@property Exame *exame;
@property Medico *medico;
@property UITextField *textField;
@property UIButton *clearButton;
//-(void) selBtnDone:(id)sender;
-(void) salvar;
@end
