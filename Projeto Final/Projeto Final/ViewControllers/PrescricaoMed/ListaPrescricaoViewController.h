//
//  ListaPrescricaoViewController.h
//  Projeto Final
//
//  Created by Leonardo Felipe da Silva on 01/10/14.
//  Copyright (c) 2014 Mack Mobile - BEPiD. All rights reserved.
//

#import "BoxesCreatorViewController.h"
#import "BoxesCreatorViewController.h"
#import "EventoRepeticaoManager.h"
#import "PrescicaoMedManager.h"
#import "CadastroPrescricaoMedViewController.h"
#import "VacinaManager.h"


@interface ListaPrescricaoViewController : UITableViewController
{
    NSArray *prescicoes;
}

@property NSArray *prescicoes;
@property UILabel *nome;
@property UILabel *data;
@property NSString *dataLabel;
@property UIViewController *viewControllerPai;

//- (id)initWithVacina:(Vacina *)vacina;
//-(void)adicionarPrescicao:(id)sender;

@end
