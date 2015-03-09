//
//  NumeroConvenioViewController.h
//  Projeto Final
//
//  Created by Leonardo Felipe da Silva on 24/09/14.
//  Copyright (c) 2014 Mack Mobile - BEPiD. All rights reserved.
//

#import "BoxesCreatorViewController.h"
#import "ConvenioManager.h"
@interface NumeroConvenioViewController : BoxesCreatorViewController
{
    Convenio *convenio;
}
@property Convenio *convenio;
@property UITableView *tableViewNumero;
@property UITextField *numeroTextField;
@property UIButton *clearButton;
@end
