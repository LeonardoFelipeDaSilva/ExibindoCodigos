//
//  RemedioManager.m
//  Projeto Final
//
//  Created by Leonardo Felipe da Silva on 22/08/14.
//  Copyright (c) 2014 Mack Mobile - BEPiD. All rights reserved.
//

#import "RemedioManager.h"
#import "EventoRepeticaoManager.h"
#import "UnidadeDeTempoManager.h"
#import "Pessoa.h"

@implementation RemedioManager

#pragma mark - Métodos de criação

- (Remedio *)criarRemedio
{
    // Obtem o contexto de persistencia que permite executar comando e consultas
    NSManagedObjectContext *context = [self getContext];
    
    Remedio *remedio = [NSEntityDescription insertNewObjectForEntityForName:@"Remedio" inManagedObjectContext:context];
    
    return remedio;
}

- (HistoricoRem *)criarHistoricoRemDoRemedio:(Remedio *)remedio
{
    // Obtem o contexto de persistencia que permite executar comando e consultas
    NSManagedObjectContext *context = [self getContext];
    
    HistoricoRem *historicoRem = [NSEntityDescription insertNewObjectForEntityForName:@"HistoricoRem" inManagedObjectContext:context];
    
    historicoRem.remedio = remedio;
    
    return historicoRem;
}

- (RemedioCaixa *)criarRemedioCaixaNoRemedio:(Remedio *)remedio
{
    // Obtem o contexto de persistencia que permite executar comando e consultas
    NSManagedObjectContext *context = [self getContext];
    
    RemedioCaixa *remedioCaixa = [NSEntityDescription insertNewObjectForEntityForName:@"RemedioCaixa" inManagedObjectContext:context];
    
    remedioCaixa.remedio = remedio;
    
    return remedioCaixa;
}

#pragma mark - Métodos de obtenção

- (NSArray *)obterRemedios
{
    // Obtem o contexto de persistencia que permite executar comando e consultas
    NSManagedObjectContext *context = [self getContext];
    
    // Cria objeto para realizacao de consulta com base em uma entidade
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"Remedio"];
    
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

- (NSArray *)obterHistoricoDoRemedio:(Remedio *)remedio
{
    // Obtem o contexto de persistencia que permite executar comando e consultas
    NSManagedObjectContext *context = [self getContext];
    
    // Cria objeto para realizacao de consulta com base em uma entidade
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"HistoricoRem"];
    
    //Definindo filtros
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"remedio = %@", remedio];
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

- (NSArray *)obterCaixaDoRemedio:(Remedio *)remedio
{
    // Obtem o contexto de persistencia que permite executar comando e consultas
    NSManagedObjectContext *context = [self getContext];
    
    // Cria objeto para realizacao de consulta com base em uma entidade
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"RemedioCaixa"];
    
    //Definindo filtros
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"remedio = %@", remedio];
    [request setPredicate:predicate];
    
    //Ordenando os resultados
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"dataValidade" ascending:YES];
    [request setSortDescriptors:@[sortDescriptor]];
    
    //Armazenando os resultados
    NSError *error;
    NSArray *array = [context executeFetchRequest:request error:&error];
    
    return array;
}

#pragma mark - Métodos do Remédio

- (HistoricoRem *)proximoEventoDoRemedio:(Remedio *)remedio
{
    HistoricoRem *historicoRem;
    
    NSDictionary *itensHistoricoStatus = [self obterHistoricoPorStatusDoRemedio:remedio];
    
    NSArray *itensHistoricoAtuais = [itensHistoricoStatus objectForKey:@"atuais"];
    
    if (itensHistoricoAtuais.count > 0) {
        historicoRem = [itensHistoricoAtuais objectAtIndex:0];
    }
    
    return historicoRem;
}

- (NSDictionary *)obterRemediosPorStatusDoPerfil
{
    //inicializando os 3 key's do dictonary para colocar os remédios de acordo com o status (ativados, não associados e desativados)
    NSDictionary *itensPorStatus = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:[[NSMutableArray alloc] init], [[NSMutableArray alloc] init], [[NSMutableArray alloc] init], nil] forKeys:[NSArray arrayWithObjects:@"ativados", @"naoAssociados", @"desativados", nil]];
    
    NSArray *remedios = [self obterRemedios]; //obter todos os remédios
    
    //efetuar a separação pelos status
    for (Remedio *remedio in remedios) {
        BOOL temPerfilAssociado = NO;
        BOOL temPerfilAtivo = NO;
        for (HistoricoRem *historicoRem in remedio.historico) {
            if (historicoRem.pessoa) {
                temPerfilAssociado = YES;
                if ([historicoRem.pessoa.ativo boolValue]) {
                    temPerfilAtivo = YES;
                    [[itensPorStatus objectForKey:@"ativados"] addObject:remedio];
                    break;
                }
            }
        }
        if (!temPerfilAtivo) {
            if (temPerfilAssociado) {
                [[itensPorStatus objectForKey:@"desativados"] addObject:remedio];
            } else {
                [[itensPorStatus objectForKey:@"naoAssociados"] addObject:remedio];
            }
        }
    }
    
    return itensPorStatus;
}

- (NSArray *)obterPessoasComHistoricoDoRemedio:(Remedio *)remedio
{
    NSMutableArray *pessoas = [[NSMutableArray alloc] init];
    
    for (HistoricoRem *historicoRem in remedio.historico) {
        if (historicoRem.pessoa && [pessoas indexOfObject:historicoRem.pessoa] == NSNotFound) {
            [pessoas addObject:historicoRem.pessoa];
        }
    }
    
    return pessoas;
}

#pragma mark - Métodos do HistoricoRem

- (NSDictionary *)obterHistoricoPorStatusDoRemedio:(Remedio *)remedio
{
    //inicializando os 3 key's do dictonary para colocar os históricos de acordo com o status (em progresso, ainda não começou e finalizados)
    NSDictionary *itensPorStatus = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:[[NSMutableArray alloc] init], [[NSMutableArray alloc] init], [[NSMutableArray alloc] init], nil] forKeys:[NSArray arrayWithObjects:@"atuais", @"futuros", @"finalizados", nil]];
    
    NSArray *itens = [self obterHistoricoDoRemedio:remedio]; //obter todos os itens
    
    //efetuar a separação pelos status
    for (HistoricoRem *historicoRem in itens) {
        if ([self jaTerminouHistoricoRem:historicoRem]) {
            [[itensPorStatus objectForKey:@"finalizados"] addObject:historicoRem];
        } else if ([self jaIniciouHistoricoRem:historicoRem]) {
            [[itensPorStatus objectForKey:@"atuais"] addObject:historicoRem];
        } else {
            [[itensPorStatus objectForKey:@"futuros"] addObject:historicoRem];
        }
    }
    
    NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] init];
    
    [dictionary setObject:[self ordenarHistoricoRemPelaProximaData:[itensPorStatus objectForKey:@"atuais"]] forKey:@"atuais"];
    [dictionary setObject:[self ordenarHistoricoRemPelaDataInicio:[itensPorStatus objectForKey:@"futuros"]] forKey:@"futuros"];
    [dictionary setObject:[self ordenarHistoricoRemPelaDataTermino:[itensPorStatus objectForKey:@"finalizados"]] forKey:@"finalizados"];
    
    return (NSDictionary *)dictionary;
}

- (NSArray *)ordenarHistoricoRemPelaDataInicio:(NSArray *)itens
{
    NSArray *array;
    
    array = [itens sortedArrayUsingComparator:^NSComparisonResult(HistoricoRem *historicoRem1, HistoricoRem *historicoRem2) {
        return [historicoRem1.dataInicio compare:historicoRem2.dataInicio];
    }];
    
    return array;
}

- (NSArray *)ordenarHistoricoRemPelaProximaData:(NSArray *)itens
{
    NSArray *array;
    
    array = [itens sortedArrayUsingComparator:^NSComparisonResult(HistoricoRem *historicoRem1, HistoricoRem *historicoRem2) {
        RemedioManager *manager = [RemedioManager sharedInstance];
        
        NSDate *date1 = [manager proximaDataDoHistoricoRem:historicoRem1];
        NSDate *date2 = [manager proximaDataDoHistoricoRem:historicoRem2];
        
        return [date1 compare:date2];
    }];
    
    return array;
}

- (NSArray *)ordenarHistoricoRemPelaDataTermino:(NSArray *)itens
{
    NSArray *array;

    array = [itens sortedArrayUsingComparator:^NSComparisonResult(HistoricoRem *historicoRem1, HistoricoRem *historicoRem2) {
        RemedioManager *manager = [RemedioManager sharedInstance];
        
        NSDate *date1 = [manager dataFinalHistoricoRem:historicoRem1];
        NSDate *date2 = [manager dataFinalHistoricoRem:historicoRem2];
        
        return (NSComparisonResult)[date1 compare:date2]*(-1);
    }];
    
    return array;
}

- (NSDate *)proximaDataDoHistoricoRem:(HistoricoRem *)historicoRem
{
    EventoRepeticaoManager *managerEvento = [EventoRepeticaoManager sharedInstance];
    
    return [managerEvento proximaDataDoEvento:historicoRem];
}

- (NSDate *)dataFinalHistoricoRem:(HistoricoRem *)historicoRem
{
    EventoRepeticaoManager *managerEvento = [EventoRepeticaoManager sharedInstance];
    
    return [managerEvento dataFinalDoEvento:historicoRem];
}

- (int)qtdEventosDoHistoricoRem:(HistoricoRem *)historicoRem
{
    EventoRepeticaoManager *managerEvento = [EventoRepeticaoManager sharedInstance];
    
    return [managerEvento qtdItensDoEvento:historicoRem];
}

- (BOOL)jaIniciouHistoricoRem:(HistoricoRem *)historicoRem
{
    EventoRepeticaoManager *managerEvento = [EventoRepeticaoManager sharedInstance];
    
    return [managerEvento jaIniciouEvento:historicoRem];
}

- (BOOL)jaTerminouHistoricoRem:(HistoricoRem *)historicoRem
{
    EventoRepeticaoManager *managerEvento = [EventoRepeticaoManager sharedInstance];
    
    return [managerEvento jaTerminouEvento:historicoRem];
}

- (BOOL)tomarRemedioDoHistoricoRem:(HistoricoRem *)historicoRem
{
    // Obtem o contexto de persistencia que permite executar comando e consultas
    NSManagedObjectContext *context = [self getContext];
    
    // Cria objeto para realizacao de consulta com base em uma entidade
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"RemedioCaixa"];
    
    //Definindo filtros
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(remedio = %@) AND (qtdAtual >= %@) AND (dataValidade >= %@)", historicoRem.remedio, historicoRem.qtda, [NSDate date]];
    [request setPredicate:predicate];
    
    //Ordenando os resultados
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"dataValidade" ascending:YES];
    [request setSortDescriptors:@[sortDescriptor]];
    
    //Armazenando os resultados
    NSError *error;
    NSArray *array = [context executeFetchRequest:request error:&error];
    
    if (array.count > 0) {
        RemedioCaixa *caixa = [array objectAtIndex:0];
        
        caixa.qtdAtual = [NSNumber numberWithInt:[caixa.qtdAtual intValue] - [historicoRem.qtda intValue]];
        
        return true;
    }
    
    return false;
}

#pragma mark - Métodos do RemedioCaixa

- (NSDictionary *)obterCaixaPorStatusDoRemedio:(Remedio *)remedio
{
    //inicializando os 3 key's do dictonary para colocar os históricos de acordo com o status (em progresso, ainda não começou e finalizados)
    NSDictionary *itensPorStatus = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:[[NSMutableArray alloc] init], [[NSMutableArray alloc] init], [[NSMutableArray alloc] init], nil] forKeys:[NSArray arrayWithObjects:@"atuais", @"utilizados", @"vencidos", nil]];
    
    NSArray *itens = [self obterCaixaDoRemedio:remedio]; //obter todos os itens
    
    //efetuar a separação pelos status
    for (RemedioCaixa *remedioCaixa in itens) {
        if ([remedioCaixa.qtdAtual isEqualToNumber:[NSNumber numberWithInt:0]]) {
            [[itensPorStatus objectForKey:@"utilizados"] addObject:remedioCaixa];
        } else if ([self jaVenceuCaixaDoRemedio:remedioCaixa]) {
            [[itensPorStatus objectForKey:@"vencidos"] addObject:remedioCaixa];
        } else {
            [[itensPorStatus objectForKey:@"atuais"] addObject:remedioCaixa];
        }
    }
    
    NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] init];
    
    [dictionary setObject:[self ordenarRemedioCaixaPelaDataValidade:[itensPorStatus objectForKey:@"atuais"] emOrdemCrescente:YES] forKey:@"atuais"];
    [dictionary setObject:[self ordenarRemedioCaixaPelaDataValidade:[itensPorStatus objectForKey:@"utilizados"] emOrdemCrescente:NO] forKey:@"utilizados"];
    [dictionary setObject:[self ordenarRemedioCaixaPelaDataValidade:[itensPorStatus objectForKey:@"vencidos"] emOrdemCrescente:NO] forKey:@"vencidos"];
    
    return (NSDictionary *)dictionary;
}

- (NSArray *)ordenarRemedioCaixaPelaDataValidade:(NSArray *)itens emOrdemCrescente:(BOOL)crescente
{
    NSArray *array;
    
    array = [itens sortedArrayUsingComparator:^NSComparisonResult(RemedioCaixa *remedioCaixa1, RemedioCaixa *remedioCaixa2) {
        int ordenacao;
        
        if (crescente) {
            ordenacao = 1;
        } else {
            ordenacao = -1;
        }
        
        return (NSComparisonResult)[remedioCaixa1.dataValidade compare:remedioCaixa2.dataValidade]*ordenacao;
    }];
    
    return array;
}

- (NSDictionary *)obterQuantidadeRemedioCaixaDoRemedio:(Remedio *)remedio
{
    NSDictionary *resultado;
    
    // Obtem o contexto de persistencia que permite executar comando e consultas
    NSManagedObjectContext *context = [self getContext];
    
    // Cria objeto para realizacao de consulta com base em uma entidade
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"RemedioCaixa"];
    
    //Definindo filtros
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(remedio = %@) AND (qtdAtual > %@) AND (dataValidade >= %@)", remedio, [NSNumber numberWithInt:0], [NSDate date]];
    [request setPredicate:predicate];
    
    //Definindo o tipo de resultado (NSDictionary)
    [request setResultType:NSDictionaryResultType];
    
    //Definindo os parâmetros (campos)
    NSExpression *keyPathExpression = [NSExpression expressionForKeyPath:@"qtdTotal"];
    NSExpression *expression = [NSExpression expressionForFunction:@"sum:" arguments:[NSArray arrayWithObject:keyPathExpression]];
    
    NSExpressionDescription *expressionDescription = [[NSExpressionDescription alloc] init];
    [expressionDescription setName:@"qtdTotal"];
    [expressionDescription setExpression:expression];
    [expressionDescription setExpressionResultType:NSDecimalAttributeType];
    
    NSExpressionDescription *expressionDescription2 = [[NSExpressionDescription alloc] init];
    [expressionDescription2 setName:@"qtdAtual"];
    [expressionDescription2 setExpression:[NSExpression expressionForFunction:@"sum:" arguments:[NSArray arrayWithObject:[NSExpression expressionForKeyPath:@"qtdAtual"]]]];
    [expressionDescription2 setExpressionResultType:NSDecimalAttributeType];
    
    [request setPropertiesToFetch:[NSArray arrayWithObjects:expressionDescription, expressionDescription2, nil]];
    
    //Armazenando os resultados
    NSError *error;
    NSArray *objects = [context executeFetchRequest:request error:&error];
    
    if (objects == nil) {
        // Handle the error.
    } else {
        if ([objects count] > 0) {
            resultado = [objects objectAtIndex:0];
        }
    }
    
    return resultado;
}

- (BOOL)jaVenceuCaixaDoRemedio:(RemedioCaixa *)remedioCaixa
{
    if ([remedioCaixa.dataValidade timeIntervalSinceNow] < 0) {
        return YES;
    } else {
        return NO;
    }
}

#pragma mark - Métodos de exclusão

- (void)deletarRemedio:(Remedio *)remedio
{
    [self deletarObjeto:remedio];
}

- (void)deletarHistoricoRem:(HistoricoRem *)historicoRem
{
    [self deletarObjeto:historicoRem];
}

- (void)deletarRemedioCaixa:(RemedioCaixa *)remedioCaixa
{
    [self deletarObjeto:remedioCaixa];
}

@end
