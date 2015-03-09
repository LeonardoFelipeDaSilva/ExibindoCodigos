//
//  MedicoManager.m
//  Projeto Final
//
//  Created by Leonardo Felipe da Silva on 12/3/14.
//  Copyright (c) 2014 Mack Mobile - BEPiD. All rights reserved.
//

#import "MedicoManager.h"

@implementation MedicoManager
-(Medico *)criarMedico
{
    // Obtem referencia ao AppDelegate
    NSManagedObjectContext *context = [self getContext];
    
    Medico *medico = [NSEntityDescription insertNewObjectForEntityForName:@"Medico" inManagedObjectContext:context];
    
    return medico;
}

- (NSArray *)obterMedicos
{
    // Obtem o contexto de persistencia que permite executar comando e consultas
    NSManagedObjectContext *context = [self getContext];
    
    // Cria objeto para realizacao de consulta com base em uma entidade
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"Medico"];
    
    //Definindo filtros
    //    NSPredicate *predicate = [NSPredicate predicateWithFormat:@""];
    //    [request setPredicate:predicate];
    
    //Ordenando os resultados
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"nome" ascending:NO];
    [request setSortDescriptors:@[sortDescriptor]];
    
    //Armazenando os resultados
    NSError *error;
    NSArray *array = [context executeFetchRequest:request error:&error];
    
    return array;
}

- (void)deletarMedico: (Medico *)medico
{
    [self deletarObjeto:medico];
}

@end
