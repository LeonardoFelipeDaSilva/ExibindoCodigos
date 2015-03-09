//
//  ConsultaViewController.h
//  Projeto Final
//
//  Created by Leonardo Felipe da Silva on 12/7/14.
//  Copyright (c) 2014 Mack Mobile - BEPiD. All rights reserved.
//

#import "BaseViewController.h"
#import "ConsultaManager.h"
@interface ConsultaViewController : BaseViewController
<UITableViewDataSource, UITableViewDelegate>

@property Consulta *consulta;
@property Medico *medico;
@property UITableView *tableView2;
@property NSString *dataConsulta;
@property UIImageView *imageView;

- (void)atualizarImagemImageView:(NSNotification *)notification;
@end
