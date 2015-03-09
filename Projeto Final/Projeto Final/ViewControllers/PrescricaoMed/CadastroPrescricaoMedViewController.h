//
//  CadastroPrescricaoMedViewController.h
//  Projeto Final
//
//  Created by Leonardo Felipe da Silva on 01/10/14.
//  Copyright (c) 2014 Mack Mobile - BEPiD. All rights reserved.
//

#import "BoxesCreatorViewController.h"
#import "PrescicaoMedManager.h"


@interface CadastroPrescricaoMedViewController : BoxesCreatorViewController
@property PrescricaoMed *prescicao;
@property UITableView *tableView2;
@property NSString *dataPrescicao;
@property UIImageView *imageView;

- (void)atualizarImagemImageView:(NSNotification *)notification;
@end
