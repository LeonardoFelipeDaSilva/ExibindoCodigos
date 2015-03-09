//
//  TituloPrescViewController.h
//  Projeto Final
//
//  Created by Leonardo Felipe da Silva on 09/10/14.
//  Copyright (c) 2014 Mack Mobile - BEPiD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PrescicaoMedManager.h"
@interface TituloPrescViewController : UITableViewController<UITableViewDelegate, UITableViewDataSource>

@property PrescricaoMed *prescricao;
@property UITextField *textField;
@property UIButton *clearButton;
-(void)selBtnDone:(id)sender;
-(void)salvar;
@end
