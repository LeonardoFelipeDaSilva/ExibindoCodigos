//
//  NomeViewController.h
//  Projeto Final
//
//  Created by Leonardo Felipe da Silva on 04/09/14.
//  Copyright (c) 2014 Mack Mobile - BEPiD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BoxesCreatorViewController.h"
#import "MMPrincipal.h"
#import "PessoaManager.h"
#import "CadPessoaViewController.h"

@interface NomeViewController : BoxesCreatorViewController <UITableViewDataSource, UITableViewDelegate>
{
    Pessoa *pessoa;
}
@property Pessoa *pessoa;
@property UITableView *tableViewNome;
@property UITextField *nomeTexField;
@property UIButton *clearButton;


- (void)selBtnDone:(id)sender;

@end
