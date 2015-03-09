//
//  UnidadeDeTempoManager.m
//  Projeto Final
//
//  Created by Lucas Saito on 24/09/14.
//  Copyright (c) 2014 Mack Mobile - BEPiD. All rights reserved.
//

#import "UnidadeDeTempoManager.h"
#import "NSDate+Utilities.h"

@implementation UnidadeDeTempoManager

- (UnidadeDeTempo *)criarUnidadeDeTempo
{
    // Obtem o contexto de persistencia que permite executar comando e consultas
    NSManagedObjectContext *context = [self getContext];
    
    UnidadeDeTempo *unidadeDeTempo = [NSEntityDescription insertNewObjectForEntityForName:@"UnidadeDeTempo" inManagedObjectContext:context];
    
    return unidadeDeTempo;
}

- (void)deletarUnidadeDeTempo:(UnidadeDeTempo *)unidadeDeTempo
{
    // Obtem o contexto de persistencia que permite executar comando e consultas
    NSManagedObjectContext *context = [self getContext];
    
    [context deleteObject:unidadeDeTempo];
}

- (NSUInteger)quantidadeDeUnidades
{
    return [self obterUnidadesDeTempo:NO].count;
}

- (NSArray *)obterUnidadesDeTempo:(BOOL)plural
{
    NSArray *tempos;
    
    if (plural) {
        tempos = [[NSArray alloc] initWithObjects:@"Segundos", @"Minutos", @"Horas", @"Dias", @"Semanas", @"Meses", @"Anos", nil];
    } else {
        tempos = [[NSArray alloc] initWithObjects:@"Segundo", @"Minuto", @"Hora", @"Dia", @"Semana", @"Mês", @"Ano", nil];
    }
    
    return tempos;
}

- (NSArray *)obterUnidadesDeTempoDoTempo:(UnidadeDeTempo *)unidadeDeTempo
{
    NSArray *tempos;
    
    BOOL plural;
    if ([unidadeDeTempo.quantidade intValue] > 1) {
        plural = YES;
    } else {
        plural = NO;
    }
    
    tempos = [self obterUnidadesDeTempo:plural];
    
    return tempos;
}

- (NSString *)criarLabel:(UnidadeDeTempo *)unidadeDeTempo
{
    if (!unidadeDeTempo) {
        return @"";
    }
    if (!unidadeDeTempo.quantidade || !unidadeDeTempo.unidade) {
        return @"";
    }
    
    NSString *strUnidade = [[self obterUnidadesDeTempoDoTempo:unidadeDeTempo] objectAtIndex:[unidadeDeTempo.unidade intValue]];
    
    return [NSString stringWithFormat:@"%@ %@", unidadeDeTempo.quantidade, [strUnidade lowercaseString]];
}

- (MMUnidadeDeTempo)obterUnidadeDaUnidadeDeTempo:(UnidadeDeTempo *)unidadeDeTempo
{
    return (MMUnidadeDeTempo)[unidadeDeTempo.unidade integerValue];
}

- (NSDate *)data:(NSDate *)data comUnidadeDeTempo:(UnidadeDeTempo *)unidadeDeTempo
{
    MMUnidadeDeTempo unidade = [self obterUnidadeDaUnidadeDeTempo:unidadeDeTempo];
    
    if (unidade == MMSegundo) {
        data = [data dateByAddingSeconds:[unidadeDeTempo.quantidade integerValue]];
    } else if (unidade == MMMinuto) {
        data = [data dateByAddingMinutes:[unidadeDeTempo.quantidade integerValue]];
    } else if (unidade == MMHora) {
        data = [data dateByAddingHours:[unidadeDeTempo.quantidade integerValue]];
    } else if (unidade == MMDia) {
        data = [data dateByAddingDays:[unidadeDeTempo.quantidade integerValue]];
    } else if (unidade == MMSemana) {
        data = [data dateByAddingDays:7*[unidadeDeTempo.quantidade integerValue]];
    } else if (unidade == MMMes) {
        data = [data dateByAddingMonths:[unidadeDeTempo.quantidade integerValue]];
    } else if (unidade == MMAno) {
        data = [data dateByAddingYears:[unidadeDeTempo.quantidade integerValue]];
    }
    
    return data;
}

- (int)qtdSegundosDaUnidadeDeTempo:(UnidadeDeTempo *)unidadeDeTempo
{
    int qtd = [unidadeDeTempo.quantidade intValue];
    
    MMUnidadeDeTempo unidade = [self obterUnidadeDaUnidadeDeTempo:unidadeDeTempo];
    
    if (unidade == MMSegundo) {
        qtd = qtd * 1;
    } else if (unidade == MMMinuto) {
        qtd = qtd * 60;
    } else if (unidade == MMHora) {
        qtd = qtd * 60 * 60;
    } else if (unidade == MMDia) {
        qtd = qtd * 60 * 60 * 24;
    } else if (unidade == MMSemana) {
        qtd = qtd * 60 * 60 * 24 * 7;
    } else if (unidade == MMMes) {
        qtd = qtd * 60 * 60 * 24 * 30;
    } else if (unidade == MMAno) {
        qtd = qtd * 60 * 60 * 24 * 30 * 365;
    }
    
    return qtd;
}

- (NSCalendarUnit)obterCalendarUnitFrequenciaDaUnidadeDeTempo:(UnidadeDeTempo *)unidadeDeTempo
{
    NSCalendarUnit calendarUnit;
    
    MMUnidadeDeTempo unidade = [self obterUnidadeDaUnidadeDeTempo:unidadeDeTempo];
    
    if (unidade == MMSegundo) {
        calendarUnit = NSCalendarUnitSecond;
    } else if (unidade == MMMinuto) {
        calendarUnit = NSCalendarUnitMinute;
    } else if (unidade == MMHora) {
        calendarUnit = NSCalendarUnitHour;
    } else if (unidade == MMDia) {
        calendarUnit = NSCalendarUnitDay;
    } else if (unidade == MMSemana) {
        calendarUnit = NSWeekCalendarUnit;
    } else if (unidade == MMMes) {
        calendarUnit = NSCalendarUnitMonth;
    } else if (unidade == MMAno) {
        calendarUnit = NSCalendarUnitYear;
    }
    
    return calendarUnit;
}

@end
