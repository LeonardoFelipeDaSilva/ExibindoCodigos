//
//  AlergiaPerfilViewController.h
//  Projeto Final
//
//  Created by Leonardo Felipe da Silva on 11/17/14.
//  Copyright (c) 2014 Mack Mobile - BEPiD. All rights reserved.
//

#import "BoxesCreatorViewController.h"
#import "PessoaManager.h"

@interface AlergiaPessoaViewController : BoxesCreatorViewController<UITableViewDataSource, UITableViewDelegate>
{
    UITableView *TableView;
}
@property UITableView *TableView;
@property Pessoa *pessoa;
@property Alergia *alergia;
- (void)salvarAlergias;
@end
