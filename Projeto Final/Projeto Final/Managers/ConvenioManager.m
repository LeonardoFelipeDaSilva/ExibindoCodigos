//
//  ConvenioManager.m
//  Projeto Final
//
//  Created by Leonardo Felipe da Silva on 22/08/14.
//  Copyright (c) 2014 Mack Mobile - BEPiD. All rights reserved.
//

#import "ConvenioManager.h"

@implementation ConvenioManager

- (Convenio *)criarConvenioNaPessoa:(Pessoa *)pessoa
{
    // Obtem o contexto de persistencia que permite executar comando e consultas
    NSManagedObjectContext *context = [self getContext];
    
    Convenio *convenio = [NSEntityDescription insertNewObjectForEntityForName:@"Convenio" inManagedObjectContext:context];
//    [pessoa addConveniosObject:convenio];
    convenio.pessoa = pessoa;
    
    return convenio;
}




@end
