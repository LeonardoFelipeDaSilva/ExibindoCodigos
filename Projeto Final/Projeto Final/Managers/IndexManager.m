//
//  IndexManager.m
//  Projeto Final
//
//  Created by Adriana Yuri on 02/09/14.
//  Copyright (c) 2014 Mack Mobile - BEPiD. All rights reserved.
//

#import "IndexManager.h"

@implementation IndexManager

- (Index *)criarIndex
{
    // Obtem referencia ao AppDelegate
    NSManagedObjectContext *context = [self getContext];
    
    Index *index = [NSEntityDescription insertNewObjectForEntityForName:@"Index" inManagedObjectContext:context];
    
    return index;
}

- (UIColor *)retornaCorIndice:(NSInteger)indice
{
    UIColor *cor;
    
    if (indice == 0) {
        cor = [UIColor colorWithRed:15/255.0f green:132/255.0f blue:255/255.0f alpha:1];
    } else if (indice == 1) {
        cor =[UIColor colorWithRed:14/255.0f green:121/255.0f blue:230/255.0f alpha:1];
    } else if (indice == 2) {
        cor = [UIColor colorWithRed:11/255.0f green:96/255.0f blue:186/255.0f alpha:1];
    } else if (indice == 3) {
        cor = [UIColor colorWithRed:9/255.0f green:82/255.0f blue:158/255.0f alpha:1];
    } else if (indice == 4) {
        cor = [UIColor colorWithRed:8/255.0f green:66/255.0f blue:127/255.0f alpha:1];
    } else if (indice == 5) {
        cor = [UIColor colorWithRed:7/255.0f green:61/255.0f blue:117/255.0f alpha:1];
    } else {
        cor = [UIColor redColor];
    }
    
    return cor;
}

- (UIColor *)retornaCorIndexPosicao:(Index *)index
{
    return [self retornaCorIndice:[index.posicao integerValue]];
}

- (void)atualizarCorIndexPosicao:(Index *)index
{
    index.corCell = [self retornaCorIndexPosicao:index];
}

- (void)criarDefaultListaIndex
{
    Index *index;
    
    index = [self criarIndex];
    index.posicao = [NSNumber numberWithInt:0];
    index.corCell = [self retornaCorIndexPosicao:index];
    index.item = @"CONSULTAS";
    
    index = [self criarIndex];
    index.posicao = [NSNumber numberWithInt:1];
    index.corCell = [self retornaCorIndexPosicao:index];
    index.item = @"EXAMES";
    
    index = [self criarIndex];
    index.posicao = [NSNumber numberWithInt:2];
    index.corCell = [self retornaCorIndexPosicao:index];
    index.item = @"OCORRÊNCIAS";
    
    index = [self criarIndex];
    index.posicao = [NSNumber numberWithInt:3];
    index.corCell = [self retornaCorIndexPosicao:index];
    index.item = @"PRESCRIÇÕES";
    
    index = [self criarIndex];
    index.posicao = [NSNumber numberWithInt:4];
    index.corCell = [self retornaCorIndexPosicao:index];
    index.item = @"REMÉDIOS";
    
    index = [self criarIndex];
    index.posicao = [NSNumber numberWithInt:5];
    index.corCell = [self retornaCorIndexPosicao:index];
    index.item = @"VACINAS";
    
    [self saveContext];
}

- (void)atualizarListaIndex:(NSInteger)from para:(NSInteger)to{
    if (from != to) {
        NSArray *itensIndex = [self obterListaIndex];
        
        NSLog(@"FROM: %ld\nTO: %ld", (long)from, (long)to);
        
        if (from > to) {
            for (int i=to; i<from; i++) {
                Index *index = [itensIndex objectAtIndex:i];
                index.posicao = [NSNumber numberWithInteger:[index.posicao intValue]+1];
                [self atualizarCorIndexPosicao:index];
            }
            Index *index = [itensIndex objectAtIndex:from];
            index.posicao = [NSNumber numberWithInteger:to];
            [self atualizarCorIndexPosicao:index];
        } else {
            for (int i=from; i<to; i++) {
                Index *index = [itensIndex objectAtIndex:i];
                index.posicao = [NSNumber numberWithInteger:[index.posicao intValue]+1];
                [self atualizarCorIndexPosicao:index];
            }
            Index *index = [itensIndex objectAtIndex:to];
            index.posicao = [NSNumber numberWithInteger:from];
            [self atualizarCorIndexPosicao:index];
        }

//        for (int i=0; i<itensIndex.count; i++) {
//            Index *index = [itensIndex objectAtIndex:i];
//            
//            NSLog(@"%d %@ %@", i, index.posicao, index.item);
//        }

        [self saveContext];
    }
}

- (NSArray *)obterListaIndexBanco {
    // Obtem o contexto de persistencia que permite executar comando e consultas
    NSManagedObjectContext *context = [self getContext];
    
    // Cria objeto para realizacao de consulta com base em uma entidade
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"Index"];
    
    //Definindo filtros
    //    NSPredicate *predicate = [NSPredicate predicateWithFormat:@""];
    //    [request setPredicate:predicate];
    
    //Ordenando os resultados
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"posicao" ascending:YES];
    [request setSortDescriptors:@[sortDescriptor]];
    
    //Armazenando os resultados
    NSError *error;
    NSArray *array = [context executeFetchRequest:request error:&error];
    return array;
}

- (NSArray *)obterListaIndex
{
    NSArray *array = [self obterListaIndexBanco];
    
    if (array.count == 0) {
        [self criarDefaultListaIndex];
        
        return [self obterListaIndexBanco];
    }
    
    return array;
}


@end
