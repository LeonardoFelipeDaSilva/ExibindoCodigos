//
//  ListaVacinaViewController.h
//  Projeto Final
//
//  Created by Leonardo Felipe da Silva on 08/09/14.
//  Copyright (c) 2014 Mack Mobile - BEPiD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BoxesCreatorViewController.h"
#import "EventoRepeticaoManager.h"
#import "VacinaManager.h"
#import "VacinaViewController.h"
@interface ListaVacinaViewController : UITableViewController
{
    NSArray *vacinas;
}
@property NSArray *vacinas;
@property VacinaManager *vacina;
@property HistoricoVacina *histVacina;
@property UILabel *nomeVacina;
@property UILabel *tipoVacina;
@property UIImageView *bolinha;

-(void)adicionarVacina:(id)sender;
- (UIViewController *)criarViewControllerVacina:(Vacina *)vacina;
@end
