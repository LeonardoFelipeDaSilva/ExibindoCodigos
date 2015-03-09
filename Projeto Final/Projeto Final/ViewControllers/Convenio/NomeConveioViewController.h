//
//  NomeConveioViewController.h
//  Projeto Final
//
//  Created by Leonardo Felipe da Silva on 24/09/14.
//  Copyright (c) 2014 Mack Mobile - BEPiD. All rights reserved.
//

#import "BoxesCreatorViewController.h"
#import "ConvenioManager.h"

@interface NomeConveioViewController : BoxesCreatorViewController
<UITableViewDataSource, UITableViewDelegate>
{
    Convenio *convenio;
}
@property Convenio *convenio;
@property UITableView *tableViewNome;
@property UITextField *nomeTexField;
@property UIButton *clearButton;

- (void)selBtnDone:(id)sender;
@end
