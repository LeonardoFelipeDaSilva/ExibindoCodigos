//
//  PrescicaoMedManager.m
//  Projeto Final
//
//  Created by Leonardo Felipe da Silva on 03/10/14.
//  Copyright (c) 2014 Mack Mobile - BEPiD. All rights reserved.
//

#import "PrescicaoMedManager.h"

@implementation PrescicaoMedManager

- (PrescricaoMed *)criarPrescricao
{
    // Obtem o contexto de persistencia que permite executar comando e consultas
    NSManagedObjectContext *context = [self getContext];
    
    PrescricaoMed *prescicao = [NSEntityDescription insertNewObjectForEntityForName:@"PrescricaoMed" inManagedObjectContext:context];
    
    return prescicao;
}

- (NSArray *)obterPrescricao
{
    // Obtem o contexto de persistencia que permite executar comando e consultas
    NSManagedObjectContext *context = [self getContext];
    
    // Cria objeto para realizacao de consulta com base em uma entidade
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"PrescricaoMed"];
    
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

- (void)deletarPrescicao:(PrescricaoMed *)prescicao
{
    [self deletarObjeto:prescicao];
}

@end
