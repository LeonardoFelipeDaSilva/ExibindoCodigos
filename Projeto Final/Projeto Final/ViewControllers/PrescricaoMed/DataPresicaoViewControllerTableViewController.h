//
//  DataPresicaoViewControllerTableViewController.h
//  Projeto Final
//
//  Created by Leonardo Felipe da Silva on 09/10/14.
//  Copyright (c) 2014 Mack Mobile - BEPiD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BoxesCreatorViewController.h"
#import "EventoRepeticaoManager.h"
#import "PrescicaoMedManager.h"
#import "CadastroPrescricaoMedViewController.h"

@interface DataPresicaoViewControllerTableViewController : BoxesCreatorViewController <UITableViewDataSource, UITableViewDelegate>
{
    PrescricaoMed *prescicaoData;
}

@property UITableView *tableViewNome;
@property UILabel *dataPrescicao;
@property PrescricaoMed *prescicaoData;
@property NSDate *data;

-(void)selBtnDone:(id)sender;
-(void)salvar;

@end
