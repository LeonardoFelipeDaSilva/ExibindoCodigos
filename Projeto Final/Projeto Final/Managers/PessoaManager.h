//
//  PessoaManager.h
//  Projeto Final
//
//  Created by Leonardo Felipe da Silva on 22/08/14.
//  Copyright (c) 2014 Mack Mobile - BEPiD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseManager.h"
#import "Pessoa.h"
#import "Convenio.h"
#import "Alergia.h"

@interface PessoaManager : BaseManager

- (Pessoa *)criarPessoa;
- (NSArray *)obterUsuarios;
- (NSArray *)obterAlergias;
- (NSArray *)obterConvenios;
- (void)deletarPessoa:(Pessoa *)pessoa;
- (void)deletarAlergia:(Alergia *)alergia;
- (void)deletarConvenio:(Convenio *)convenio;

- (Alergia *)criarAlergia;
- (Convenio *)criarConvenio;
- (UIColor *)corDaPessoa:(Pessoa *)pessoa;
- (UIView *)criarViewCorBolinhaDaPessoa:(Pessoa *)pessoa naPosicao:(CGPoint)posicao;

@end
