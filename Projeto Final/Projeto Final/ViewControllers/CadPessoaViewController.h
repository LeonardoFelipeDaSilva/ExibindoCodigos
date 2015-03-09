//
//  CadPessoaViewController.h
//  Projeto Final
//
//  Created by Leonardo Felipe da Silva on 22/08/14.
//  Copyright (c) 2014 Mack Mobile - BEPiD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BoxesCreatorViewController.h"
#import "MMPrincipal.h"
#import "PessoaManager.h"

@interface CadPessoaViewController : BoxesCreatorViewController <UITableViewDataSource, UITableViewDelegate>
{
    //UIView
    UIView *dataScroll;
    UIView *adicionarConvenio;
    UIView *fundoTitulo;
    UIView *tipoSanguineo;
    UIView *sexo;
    //UILabel
    UILabel *titulo;
    UILabel *nascimentoLabel;
    
    //UIImageView
    UIImageView *imgFotoBlur;
    UIImageView *imgFotoIcone;
    //UITextField
    UITextField *nome;
    UITextField *sobrenome;
    
    
    //TableView
    UITableView *TableView;
    
    NSString *dataNascimento;
    //Pessoa
    Pessoa *pessoa;
    Alergia *alergia;
    Convenio *convenio;
    
    id nomeAtributo;
    id refObjeto;
    id tipo;
   
    
}
@property Pessoa *pessoa;

@property id nomeAtributo;
@property UILabel *titulo;
@property UIView *fundoTitulo;
@property NSString *dataNascimento;
@property UITableView *TableView;
@property UIImageView *imgFotoBlur, *imgFotoIcone;

- (void)salvarPerfil;
- (void)datePickerLabelNascimento;
- (void)toqueScrolDataView:(id)sender;
- (void)toqueBotaoConvenio:(id)sender;
- (void)atualizarImagemImageView:(NSNotification *)notification;
- (void)cancelar:(id)sender;
- (void)adicionar:(id)sender;
@end
