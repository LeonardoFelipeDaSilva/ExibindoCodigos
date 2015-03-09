//
//  ConsultaManager.m
//  Projeto Final
//
//  Created by Leonardo Felipe da Silva on 12/7/14.
//  Copyright (c) 2014 Mack Mobile - BEPiD. All rights reserved.
//

#import "ConsultaManager.h"

@implementation ConsultaManager

- (Consulta *)criarConsulta
{
    // Obtem o contexto de persistencia que permite executar comando e consultas
    NSManagedObjectContext *context = [self getContext];
    
    Consulta *consulta = [NSEntityDescription insertNewObjectForEntityForName:@"Consulta" inManagedObjectContext:context];
    
    return consulta;
}

- (NSArray *)obterConsultas
{
    // Obtem o contexto de persistencia que permite executar comando e consultas
    NSManagedObjectContext *context = [self getContext];
    
    // Cria objeto para realizacao de consulta com base em uma entidade
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"Consulta"];
    
    //Definindo filtros
    //    NSPredicate *predicate = [NSPredicate predicateWithFormat:@""];
    //    [request setPredicate:predicate];
    
    //Ordenando os resultados
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"data" ascending:NO];
    [request setSortDescriptors:@[sortDescriptor]];
    
    //Armazenando os resultados
    NSError *error;
    NSArray *array = [context executeFetchRequest:request error:&error];
    
    return array;
}

- (void)deletarConsulta:(Consulta *)consulta
{
    [self deletarObjeto:consulta];
}

@end
