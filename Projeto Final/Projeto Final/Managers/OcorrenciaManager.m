//
//  OcorrenciaManager.m
//  Projeto Final
//
//  Created by Leonardo Felipe da Silva on 01/10/14.
//  Copyright (c) 2014 Mack Mobile - BEPiD. All rights reserved.
//

#import "OcorrenciaManager.h"

@implementation OcorrenciaManager

- (OcorrenciaDoenca *)criarOcorrencia
{
    // Obtem o contexto de persistencia que permite executar comando e consultas
    NSManagedObjectContext *context = [self getContext];
    
    OcorrenciaDoenca *ocorrencia = [NSEntityDescription insertNewObjectForEntityForName:@"OcorrenciaDoenca" inManagedObjectContext:context];
    
    return ocorrencia;
}

- (NSArray *)obterOcorrencias
{
    // Obtem o contexto de persistencia que permite executar comando e consultas
    NSManagedObjectContext *context = [self getContext];
    
    // Cria objeto para realizacao de consulta com base em uma entidade
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"OcorrenciaDoenca"];
    
    //Definindo filtros
    //    NSPredicate *predicate = [NSPredicate predicateWithFormat:@""];
    //    [request setPredicate:predicate];
    
    //Ordenando os resultados
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"sintomas" ascending:YES];
    [request setSortDescriptors:@[sortDescriptor]];
    
    //Armazenando os resultados
    NSError *error;
    NSArray *array = [context executeFetchRequest:request error:&error];
    
    return array;
}

- (void)deletarOcorrencia:(OcorrenciaDoenca *)ocorrencia
{
    [self deletarObjeto:ocorrencia];
}

@end
