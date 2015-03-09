//
//  OcorrenciaViewController.h
//  Projeto Final
//
//  Created by Leonardo Felipe da Silva on 01/10/14.
//  Copyright (c) 2014 Mack Mobile - BEPiD. All rights reserved.
//

#import "BoxesCreatorViewController.h"
#import "OcorrenciaManager.h"
#import "SintomasDaOcorViewController.h"

@interface OcorrenciaViewController : BoxesCreatorViewController
{
    SintomasDaOcorViewController *viewControllerSintomas;
   
   }
@property OcorrenciaDoenca *ocorrencia;
@property UITableView *tableViewSint;

//Variaveis usadas para o UISlider
@property UISwitch *btn;
@property (nonatomic) int flag;
@property UISlider *slider;
@property UILabel *label1;
@property UIButton *min;
@property UIButton *max;


//
@property UITableView *tableView2;
@property NSString *dataOcorrencia;

@end
