//
//  ListaConveniosViewController.h
//  Projeto Final
//
//  Created by Leonardo Felipe da Silva on 12/8/14.
//  Copyright (c) 2014 Mack Mobile - BEPiD. All rights reserved.
//

#import "BoxesCreatorViewController.h"
#import "PessoaManager.h"

@interface ListaConveniosViewController : UITableViewController<UITableViewDataSource, UITableViewDelegate>

{
    NSArray *convenios;
}

@property PessoaManager *pessoa;
@property Convenio *convenio;
@property Pessoa  *perfil;

-(void)adicionar:(id)sender;
@end
