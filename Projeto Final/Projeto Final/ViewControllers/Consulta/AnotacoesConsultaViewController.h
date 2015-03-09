//
//  AnotacoesConsultaViewController.h
//  Projeto Final
//
//  Created by Leonardo Felipe da Silva on 12/8/14.
//  Copyright (c) 2014 Mack Mobile - BEPiD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConsultaManager.h"

@interface AnotacoesConsultaViewController : UITableViewController<
UITableViewDataSource, UITableViewDelegate>
@property Consulta *consulta;
@property UITextView *textView;

- (id)initWithConsulta;
@end
