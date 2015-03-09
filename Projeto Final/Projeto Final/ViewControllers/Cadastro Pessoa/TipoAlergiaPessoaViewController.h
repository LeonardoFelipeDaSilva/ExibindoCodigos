//
//  TipoAlergiaViewController.h
//  Projeto Final
//
//  Created by Leonardo Felipe da Silva on 11/17/14.
//  Copyright (c) 2014 Mack Mobile - BEPiD. All rights reserved.
//

#import "BaseViewController.h"
#import "PessoaManager.h"
@interface TipoAlergiaPessoaViewController : BaseViewController<UITableViewDataSource, UITableViewDelegate>

@property UIPickerView *pickerView;
@property UITableView *tableViewNome;
@property UILabel *tipoAlergia;
@property Alergia *alergia;
@property NSString *tiposAlergia;

- (void)selBtnDone:(id)sender;
- (void)salvar;

@end
