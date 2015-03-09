//
//  MostrarVacinaViewController.h
//  Projeto Final
//
//  Created by Leonardo Felipe da Silva on 10/27/14.
//  Copyright (c) 2014 Mack Mobile - BEPiD. All rights reserved.
//

#import "BoxesCreatorViewController.h"
#import "VacinaManager.h"
#import "ListaPrescricaoViewController.h"
#import "ListaHistVacinaViewController.h"

@interface MostrarVacinaViewController : BoxesCreatorViewController
{
    Vacina *vacina;
    HistoricoVacina *histVacina;
    UITableView *tableView;
    ListaHistVacinaViewController *viewControllerVacina;
    ListaPrescricaoViewController *viewControllerPrescricao;
    UIButton *btnHistorico;
    UIButton *btnPrescricao;
    
}
@property Vacina *vacina;
@property UISegmentedControl *segmentedControl;
-(void)segmentedControlValueDidChange:(UISegmentedControl *)segment;
- (void)adicionarHistVacina:(id)sender;

@end
