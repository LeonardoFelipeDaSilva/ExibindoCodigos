//
//  ConvenioManager.h
//  Projeto Final
//
//  Created by Leonardo Felipe da Silva on 22/08/14.
//  Copyright (c) 2014 Mack Mobile - BEPiD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseManager.h"
#import "Convenio.h"
#import "Pessoa.h"

@interface ConvenioManager : BaseManager

- (Convenio *)criarConvenioNaPessoa:(Pessoa *)pessoa;
- (NSArray *)obterConvenios;
- (void)deletarConvenio:(Convenio *)convenio;

@end
