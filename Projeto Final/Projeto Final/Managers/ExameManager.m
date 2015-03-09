//
//  ExameManager.m
//  Projeto Final
//
//  Created by Leonardo Felipe da Silva on 17/10/14.
//  Copyright (c) 2014 Mack Mobile - BEPiD. All rights reserved.
//

#import "ExameManager.h"
#import "Medico.h"

@implementation ExameManager

- (Exame *)criarExame
{
    // Obtem o contexto de persistencia que permite executar comando e consultas
    NSManagedObjectContext *context = [self getContext];
    
    Exame *exame = [NSEntityDescription insertNewObjectForEntityForName:@"Exame" inManagedObjectContext:context];
    
    return exame;
}

- (NSArray *)obterExames
{
    // Obtem o contexto de persistencia que permite executar comando e consultas
    NSManagedObjectContext *context = [self getContext];
    
    // Cria objeto para realizacao de consulta com base em uma entidade
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"Exame"];
    
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

- (void)deletarExame:(Exame *)exame
{
    [self deletarObjeto:exame];
}



@end
