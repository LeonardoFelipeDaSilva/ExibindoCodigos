//
//  TipoVacinaViewController.h
//  Projeto Final
//
//  Created by Leonardo Felipe da Silva on 12/09/14.
//  Copyright (c) 2014 Mack Mobile - BEPiD. All rights reserved.
//

#import "BoxesCreatorViewController.h"
#import "VacinaManager.h"

@interface TipoVacinaViewController : BoxesCreatorViewController <UITableViewDataSource, UITableViewDelegate>
{
    Vacina *vacina;
    
}
@property Vacina *vacina;
@property UIPickerView *pickerView;
@property UITableView *tableViewNome;
@property UILabel *tipoVacina;
@property NSString *tiposVacina;

- (void)selBtnDone:(id)sender;
- (void)salvar;
@end
