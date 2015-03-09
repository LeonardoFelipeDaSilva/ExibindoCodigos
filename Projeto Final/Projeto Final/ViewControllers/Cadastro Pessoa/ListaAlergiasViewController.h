//
//  ListaAlergiasViewController.h
//  Projeto Final
//
//  Created by Leonardo Felipe da Silva on 11/17/14.
//  Copyright (c) 2014 Mack Mobile - BEPiD. All rights reserved.
//

#import "BoxesCreatorViewController.h"
#import "PessoaManager.h"

@interface ListaAlergiasViewController :  UITableViewController<UITableViewDataSource, UITableViewDelegate>

{
    NSArray *alergias;
}

@property PessoaManager *pessoa;
@property Alergia *alergia;
@property Pessoa  *perfil;

-(void)adicionar:(id)sender;
@end
