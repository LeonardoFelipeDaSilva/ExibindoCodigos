//
//  ListaPerfilViewController.h
//  Projeto Final
//
//  Created by Adriana Yuri on 01/09/14.
//  Copyright (c) 2014 Mack Mobile - BEPiD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PessoaManager.h"
#import "TelaSelecionarPerfil.h"

@interface ListaPerfilViewController : UITableViewController

{
    NSArray *perfis;
    NSString *dataNascimento;
    
    NSString *modoTela;
    id <TelaSelecionarPerfil> refObjetoSelecionarPerfil;
    Pessoa *perfilSelecionado;
}

@property Pessoa *perfil;
@property UIImageView *blurView, *iconeView;

@property NSString *modoTela;
@property id <TelaSelecionarPerfil> refObjetoSelecionarPerfil;

-(void)adicionarPerfil:(id)sender;

@end
