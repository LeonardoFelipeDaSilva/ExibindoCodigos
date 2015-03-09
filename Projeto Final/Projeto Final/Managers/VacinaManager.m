//
//  VacinaManager.m
//  Projeto Final
//
//  Created by Leonardo Felipe da Silva on 08/09/14.
//  Copyright (c) 2014 Mack Mobile - BEPiD. All rights reserved.
//

#import "VacinaManager.h"
#import "EventoRepeticaoManager.h"
#import "UnidadeDeTempoManager.h"
@implementation VacinaManager

#pragma mark - Métodos de criação

- (Vacina *)criarVacina
{
    // Obtem o contexto de persistencia que permite executar comando e consultas
    NSManagedObjectContext *context = [self getContext];
    
    Vacina *vacina = [NSEntityDescription insertNewObjectForEntityForName:@"Vacina" inManagedObjectContext:context];
    
    return vacina;
}

- (HistoricoVacina *)criarHistoricoVacinaDaVacina:(Vacina *)vacina
{
    // Obtem o contexto de persistencia que permite executar comando e consultas
    NSManagedObjectContext *context = [self getContext];
    
    HistoricoVacina *historico = [NSEntityDescription insertNewObjectForEntityForName:@"HistoricoVacina" inManagedObjectContext:context];
    
    historico.vacina = vacina;
    
    return historico;
}


#pragma mark - Métodos de obtenção

- (NSArray *)obterVacinas
{
    // Obtem o contexto de persistencia que permite executar comando e consultas
    NSManagedObjectContext *context = [self getContext];
    
    // Cria objeto para realizacao de consulta com base em uma entidade
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"Vacina"];
    
    //Definindo filtros
    //    NSPredicate *predicate = [NSPredicate predicateWithFormat:@""];
    //    [request setPredicate:predicate];
    
    //Ordenando os resultados
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"nome" ascending:YES];
    [request setSortDescriptors:@[sortDescriptor]];
    
    //Armazenando os resultados
    NSError *error;
    NSArray *array = [context executeFetchRequest:request error:&error];
    
    return array;
}

- (NSArray *)obterHistoricoDaVacina:(Vacina *)vacina
{
    // Obtem o contexto de persistencia que permite executar comando e consultas
    NSManagedObjectContext *context = [self getContext];
    
    // Cria objeto para realizacao de consulta com base em uma entidade
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"HistoricoVacina"];
    
    //Definindo filtros
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"vacina = %@", vacina];
    [request setPredicate:predicate];
    
    //Ordenando os resultados
    //    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"data" ascending:NO];
    //    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"self" ascending:NO comparator:compareProximaDataHistoricoRem]; //não funciona com o self
    //    [request setSortDescriptors:@[sortDescriptor]];
    
    //Armazenando os resultados
    NSError *error;
    NSArray *array = [context executeFetchRequest:request error:&error];
    
    return array;
}

- (NSArray *)obterPessoasComHistoricoDaVacina:(Vacina *)vacina
{
    NSMutableArray *pessoas = [[NSMutableArray alloc] init];
    
    for (HistoricoVacina *historicoVacina in vacina.historico) {
        if (historicoVacina.pessoa && [pessoas indexOfObject:historicoVacina.pessoa] == NSNotFound) {
            [pessoas addObject:historicoVacina.pessoa];
        }
    }
    
    return pessoas;
}

#pragma mark - Métodos do Remédio

- (HistoricoVacina *)proximoEventoDaVacina:(Vacina *)vacina
{
    HistoricoVacina *historico;
    
    NSDictionary *itensHistoricoStatus = [self obterHistoricoPorStatusDaVacina:vacina];
    
    NSArray *itensHistoricoAtuais = [itensHistoricoStatus objectForKey:@"atuais"];
    
    if (itensHistoricoAtuais.count > 0) {
        historico = [itensHistoricoAtuais objectAtIndex:0];
    }
    
    return historico;
}

#pragma mark - Métodos do HistoricoRem

- (NSDictionary *)obterHistoricoPorStatusDaVacina:(Vacina *)vacina
{
    //inicializando os 3 key's do dictonary para colocar os históricos de acordo com o status (em progresso, ainda não começou e finalizados)
    NSDictionary *itensPorStatus = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:[[NSMutableArray alloc] init], [[NSMutableArray alloc] init], [[NSMutableArray alloc] init], nil] forKeys:[NSArray arrayWithObjects:@"atuais", @"futuros", @"finalizados", nil]];
    
    NSArray *itens = [self obterHistoricoDaVacina:vacina]; //obter todos os itens
    
    //efetuar a separação pelos status
    for (HistoricoVacina *historico in itens) {
        if ([self jaTerminouHistoricoVacina:historico]) {
            [[itensPorStatus objectForKey:@"finalizados"] addObject:historico];
        } else if ([self jaIniciouHistoricoVacina:historico]) {
            [[itensPorStatus objectForKey:@"atuais"] addObject:historico];
        } else {
            [[itensPorStatus objectForKey:@"futuros"] addObject:historico];
        }
    }
    
    NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] init];
    
    [dictionary setObject:[self ordenarHistoricoVacinaPelaProximaData:[itensPorStatus objectForKey:@"atuais"]] forKey:@"atuais"];
    [dictionary setObject:[self ordenarHistoricoVacinaPelaDataInicio:[itensPorStatus objectForKey:@"futuros"]] forKey:@"futuros"];
    [dictionary setObject:[self ordenarHistoricoVacinaPelaDataTermino:[itensPorStatus objectForKey:@"finalizados"]] forKey:@"finalizados"];
    
    return (NSDictionary *)dictionary;
}

- (NSArray *)ordenarHistoricoVacinaPelaDataInicio:(NSArray *)itens
{
    NSArray *array;
    
    array = [itens sortedArrayUsingComparator:^NSComparisonResult(HistoricoVacina *historico1, HistoricoVacina *historico2) {
        return [historico1.dataInicio compare:historico2.dataInicio];
    }];
    
    return array;
}

- (NSArray *)ordenarHistoricoVacinaPelaProximaData:(NSArray *)itens
{
    NSArray *array;
    
    array = [itens sortedArrayUsingComparator:^NSComparisonResult(HistoricoVacina *historico1, HistoricoVacina *historico2) {
        VacinaManager *manager = [VacinaManager sharedInstance];
        
        NSDate *date1 = [manager proximaDataDoHistoricoVacina:historico1];
        NSDate *date2 = [manager proximaDataDoHistoricoVacina:historico2];
        
        return [date1 compare:date2];
    }];
    
    return array;
}

- (NSArray *)ordenarHistoricoVacinaPelaDataTermino:(NSArray *)itens
{
    NSArray *array;
    
    array = [itens sortedArrayUsingComparator:^NSComparisonResult(HistoricoVacina *historico1, HistoricoVacina *historico2) {
        VacinaManager *manager = [VacinaManager sharedInstance];
        
        NSDate *date1 = [manager dataFinalHistoricoVacina:historico1];
        NSDate *date2 = [manager dataFinalHistoricoVacina:historico2];
        
        return (NSComparisonResult)[date1 compare:date2]*(-1);
    }];
    
    return array;
}

- (NSDate *)proximaDataDoHistoricoVacina:(HistoricoVacina *)historico
{
    EventoRepeticaoManager *managerEvento = [EventoRepeticaoManager sharedInstance];
    
    return [managerEvento proximaDataDoEvento:historico];
}

- (NSDate *)dataFinalHistoricoVacina:(HistoricoVacina *)historico
{
    EventoRepeticaoManager *managerEvento = [EventoRepeticaoManager sharedInstance];
    
    return [managerEvento dataFinalDoEvento:historico];
}

- (int)qtdEventosDoHistoricoVacina:(HistoricoVacina *)historico
{
    EventoRepeticaoManager *managerEvento = [EventoRepeticaoManager sharedInstance];
    
    return [managerEvento qtdItensDoEvento:historico];
}

- (BOOL)jaIniciouHistoricoVacina:(HistoricoVacina *)historico
{
    EventoRepeticaoManager *managerEvento = [EventoRepeticaoManager sharedInstance];
    
    return [managerEvento jaIniciouEvento:historico];
}

- (BOOL)jaTerminouHistoricoVacina:(HistoricoVacina *)historico
{
    EventoRepeticaoManager *managerEvento = [EventoRepeticaoManager sharedInstance];
    
    return [managerEvento jaTerminouEvento:historico];
}




#pragma mark - Métodos de exclusão

- (void)deletarVacina:(Vacina *)vacina
{
    [self deletarObjeto:vacina];
}

- (void)deletarHistoricoVacina:(HistoricoVacina *)historico
{
    [self deletarObjeto:historico];
}





@end
