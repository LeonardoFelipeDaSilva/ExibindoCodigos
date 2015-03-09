//
//  HistoricoDeOcorrenciaViewController.h
//  Projeto Final
//
//  Created by Leonardo Felipe da Silva on 01/10/14.
//  Copyright (c) 2014 Mack Mobile - BEPiD. All rights reserved.
//

#import "BoxesCreatorViewController.h"
#import "OcorrenciaManager.h"
#import "BaseManager.h"
#import <UIKit/UIKit.h>

@interface HistoricoDeOcorrenciaViewController : UITableViewController

{
    NSArray *ocorrencias;
}

@property OcorrenciaDoenca *ocorrencia;
@property UILabel *nome;
@property UILabel *Data;
@property NSString *dataLabel;
-(void)adicionar:(id)sender;

@end
