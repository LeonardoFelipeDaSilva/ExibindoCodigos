//
//  AlertaManager.m
//  Projeto Final
//
//  Created by Leonardo Felipe da Silva on 22/08/14.
//  Copyright (c) 2014 Mack Mobile - BEPiD. All rights reserved.
//

#import "EventoRepeticaoManager.h"
#import "UnidadeDeTempoManager.h"
#import "HistoricoRem.h"
#import "HistoricoVacina.h"
#import "Pessoa.h"
#import "Remedio.h"
#import "Vacina.h"

@implementation EventoRepeticaoManager

- (NSArray *)obterEventos
{
    // Obtem o contexto de persistencia que permite executar comando e consultas
    NSManagedObjectContext *context = [self getContext];
    
    // Cria objeto para realizacao de consulta com base em uma entidade
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"EventoRepeticao"];
    
    //Ordenando os resultados
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"dataInicio" ascending:YES];
    [request setSortDescriptors:@[sortDescriptor]];
    
    //Armazenando os resultados
    NSError *error;
    NSArray *eventos = [context executeFetchRequest:request error:&error];
    
    return eventos;
}

- (NSArray *)obterEventosNaoFinalizados
{
    NSArray *eventos = [self obterEventos];
    
    NSMutableArray *eventosNaoFinalizados = [[NSMutableArray alloc] init];
    
    for (EventoRepeticao *evento in eventos) {
        if (![self jaTerminouEvento:evento]) {
            [eventosNaoFinalizados addObject:evento];
        }
    }
    
    return eventosNaoFinalizados;
}

- (NSArray *)obterItensDoEvento:(EventoRepeticao *)evento
{
    NSMutableArray *itens = [[NSMutableArray alloc] init];
    
    if (!evento.dataInicio) {
        NSLog(@"Evento sem data inicial");
        
        return itens;
    }
    if (!evento.duracao) {
        NSLog(@"Evento sem duração");
        
        return itens;
    }
    if (!evento.frequencia) {
        NSLog(@"Evento sem frequência");
        
        return itens;
    }
    
    UnidadeDeTempoManager *managerTempo = [UnidadeDeTempoManager sharedInstance];
    
    NSDate *proximaData = evento.dataInicio;
    
    while ([proximaData timeIntervalSinceDate:[self dataFinalDoEvento:evento]] <= 0) {
        [itens addObject:proximaData];
        
        proximaData = [managerTempo data:proximaData comUnidadeDeTempo:evento.frequencia];
    }
    
    return itens;
}

- (NSArray *)obterItensFuturosDoEvento:(EventoRepeticao *)evento
{
    return [self obterItensFuturosDoEvento:evento comLimite:-1];
}

- (NSArray *)obterItensFuturosDoEvento:(EventoRepeticao *)evento comLimite:(NSInteger)limite
{
    NSMutableArray *itens = [[NSMutableArray alloc] init];
    
    if (!evento.dataInicio) {
        NSLog(@"Evento sem data inicial");
        
        return itens;
    }
    if (!evento.duracao) {
        NSLog(@"Evento sem duração");
        
        return itens;
    }
    if (!evento.frequencia) {
        NSLog(@"Evento sem frequência");
        
        return itens;
    }
    if ([self jaTerminouEvento:evento]) {
        NSLog(@"Evento já terminado");
        
        return itens;
    }
    
    UnidadeDeTempoManager *managerTempo = [UnidadeDeTempoManager sharedInstance];
    
    NSDate *proximaData = [self proximaDataDoEvento:evento];
    
    NSInteger contador = 0;
    while ([proximaData timeIntervalSinceDate:[self dataFinalDoEvento:evento]] <= 0 && (limite == -1 || contador < limite)) {
        [itens addObject:proximaData];
        
        proximaData = [managerTempo data:proximaData comUnidadeDeTempo:evento.frequencia];
        contador++;
    }
    
    return itens;
}

- (NSDate *)proximaDataDoEvento:(EventoRepeticao *)evento
{
    NSDate *proximaData = evento.dataInicio;
    
    if (![self jaIniciouEvento:evento]) {
        NSLog(@"Evento ainda não iniciado [%@]", proximaData);
        
        return proximaData;
    }
    if ([self jaTerminouEvento:evento]) {
        NSDate *dataFinal = [self dataFinalDoEvento:evento];
        
        NSLog(@"Evento já terminado [%@]", dataFinal);
        
        return dataFinal;
    }
    if ([evento.frequencia.quantidade isEqualToNumber:[NSNumber numberWithInt:0]]) {
        NSLog(@"Evento sem frequência");
        
        return proximaData;
    }
    
    UnidadeDeTempoManager *managerTempo = [UnidadeDeTempoManager sharedInstance];
    
    while ([proximaData timeIntervalSinceNow] < 0) {
        proximaData = [managerTempo data:proximaData comUnidadeDeTempo:evento.frequencia];
    }
    
    return proximaData;
}

- (NSDate *)dataFinalDoEvento:(EventoRepeticao *)evento
{
    NSDate *dataFinal;
    
    if (!evento.duracao || [evento.duracao.quantidade isEqualToNumber:[NSNumber numberWithInt:0]]) {
        NSLog(@"Evento sem duração");
    }
    
    UnidadeDeTempoManager *managerTempo = [UnidadeDeTempoManager sharedInstance];
    
    dataFinal = [managerTempo data:evento.dataInicio comUnidadeDeTempo:evento.duracao];
    
    return dataFinal;
}

- (int)qtdItensDoEvento:(EventoRepeticao *)evento
{
    int qtdItens;
    
    int qtdSegundosTotal = [evento.dataInicio timeIntervalSinceDate:[self dataFinalDoEvento:evento]] * (-1);
    
    UnidadeDeTempoManager *managerTempo = [UnidadeDeTempoManager sharedInstance];
    
    int qtdSegundosFrequencia = [managerTempo qtdSegundosDaUnidadeDeTempo:evento.frequencia];
    
    qtdItens = (qtdSegundosTotal/qtdSegundosFrequencia) + 1;
    
//    qtdItens = [[self obterItensDoEvento:evento] count];
    
    return qtdItens;
}

- (BOOL)jaIniciouEvento:(EventoRepeticao *)evento
{
    if ([evento.dataInicio timeIntervalSinceNow] < 0) {
        return YES;
    } else {
        return NO;
    }
}

- (BOOL)jaTerminouEvento:(EventoRepeticao *)evento
{
    if ([[self dataFinalDoEvento:evento] timeIntervalSinceNow] < 0) {
        return YES;
    } else {
        return NO;
    }
}

- (EKEventStore *)obterCalendarioStore
{
    static EKEventStore *eventStore = nil;
    
    if (eventStore == nil) {
        eventStore = [[EKEventStore alloc] init];
    }
    
    return eventStore;
}

- (void)calendarioSolicitarAcesso:(void (^)(BOOL granted, NSError *error))callback;
{
    EKEventStore *eventStore = [self obterCalendarioStore];
    
    // request permissions
    [eventStore requestAccessToEntityType:EKEntityTypeEvent completion:callback];
}

- (EKCalendar *)obterCalendario
{
    EKEventStore *eventStore = [self obterCalendarioStore];
    EKCalendar *calendar = nil;
    NSString *calendarIdentifier = [[NSUserDefaults standardUserDefaults] valueForKey:@"calendar_identifier"];
    
    // when identifier exists, my calendar probably already exists
    // note that user can delete my calendar. In that case I have to create it again.
    if (calendarIdentifier) {
        calendar = [eventStore calendarWithIdentifier:calendarIdentifier];
    }
    
    // calendar doesn't exist, create it and save it's identifier
    if (!calendar) {
        // http://stackoverflow.com/questions/7945537/add-a-new-calendar-to-an-ekeventstore-with-eventkit
        calendar = [EKCalendar calendarForEntityType:EKEntityTypeEvent eventStore:eventStore];
        
        // set calendar name. This is what users will see in their Calendar app
        [calendar setTitle:@"LiFE"];
        
        // find appropriate source type. I'm interested only in local calendars but
        // there are also calendars in iCloud, MS Exchange, ...
        // look for EKSourceType in manual for more options
//        for (EKSource *s in eventStore.sources) {
//            if (s.sourceType == EKSourceTypeLocal) {
//                calendar.source = s;
//                break;
//            }
//        }
        //DEFINIR O SOURCE DO MESMO CALENDARIO PADRAO
        calendar.source = eventStore.defaultCalendarForNewEvents.source;
        
        // save this in NSUserDefaults data for retrieval later
        NSString *calendarIdentifier = [calendar calendarIdentifier];
        
        NSError *error = nil;
        BOOL saved = [eventStore saveCalendar:calendar commit:YES error:&error];
        if (saved) {
            // http://stackoverflow.com/questions/1731530/whats-the-easiest-way-to-persist-data-in-an-iphone-app
            // saved successfuly, store it's identifier in NSUserDefaults
            [[NSUserDefaults standardUserDefaults] setObject:calendarIdentifier forKey:@"calendar_identifier"];
        } else {
            // unable to save calendar
            return nil;
        }
    }
    
//    for (EKSource *source in eventStore.sources) {
//        NSLog(@"SOURCE: %@", source);
//        for (EKCalendar *calendar in [source calendarsForEntityType:EKEntityTypeEvent]) {
//            NSLog(@"CALENDAR: %@ - %@", calendar.title, calendar.calendarIdentifier);
//        }
//    }
    
    return calendar;
}

- (void)listarEventosDoCalendario:(EKCalendar *)calendario
{
    EKEventStore *eventStore = [self obterCalendarioStore];
    
    NSPredicate *predicate = [eventStore predicateForEventsWithStartDate:[NSDate distantPast] endDate:[NSDate distantFuture] calendars:[NSArray arrayWithObject:calendario]];
    
    for (EKEvent *evento in [eventStore eventsMatchingPredicate:predicate]) {
        NSLog(@"%@", evento);
    }
}

- (void)criarItensEventoNoCalendarioDoEvento:(EventoRepeticao *)evento
{
    EKEventStore *eventStore = [self obterCalendarioStore];
    EKEvent *event = [EKEvent eventWithEventStore:eventStore];
    
    event.title = evento.titulo;
    event.startDate = evento.dataInicio;
    event.endDate = [self dataFinalDoEvento:evento];
    
    // Check if App has Permission to Post to the Calendar
    [eventStore requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError *error) {
        if (granted) {
            //---- code here when user allows your app to access their calendar.
            [event setCalendar:[self obterCalendario]];
            
            NSString *savedEventId = event.eventIdentifier;
            
            NSError *err;
            [eventStore saveEvent:event span:EKSpanThisEvent error:&err];
        } else {
            //SEM PERMISSÃO
        }
    }];
}

- (NSArray *)obterItensFuturosSomenteComNotificacao:(BOOL)notificacao comLimite:(NSInteger)limite
{
    NSArray *eventos = [self obterEventosNaoFinalizados];
    
    NSMutableArray *itensEventos = [[NSMutableArray alloc] init];
    for (EventoRepeticao *evento in eventos) {
        
        if ([evento isMemberOfClass:[HistoricoRem class]]) {
            HistoricoRem *historicoRem = (HistoricoRem *)evento;
            evento.titulo = [NSString stringWithFormat:@"%@ tomar o remédio %@", historicoRem.pessoa.nome, historicoRem.remedio.nome];
        } else if ([evento isMemberOfClass:[HistoricoVacina class]]) {
            HistoricoVacina *historicoVacina = (HistoricoVacina *)evento;
            evento.titulo = [NSString stringWithFormat:@"%@ tomar a vacina %@", historicoVacina.pessoa.nome, historicoVacina.vacina.nome];
        }
        
        if (!notificacao || [evento.notificacao boolValue]) {
            NSArray *itensEvento = [self obterItensFuturosDoEvento:evento comLimite:limite];
            
//            NSLog(@"%lu", (unsigned long)itensEvento.count);
            
            for (NSDate *data in itensEvento) {
                [itensEventos addObject:[NSArray arrayWithObjects:data, evento, nil]];
            }
        }
    }
    
    NSArray *itensEventosOrdenados = [itensEventos sortedArrayUsingComparator:^NSComparisonResult(NSArray *item1, NSArray *item2) {
        return [[item1 objectAtIndex:0] compare:[item2 objectAtIndex:0]];
    }];
    
    NSMutableArray *itensEventosLimite = [[NSMutableArray alloc] init];
    for (int i=0; (i<limite && i<itensEventosOrdenados.count); i++) {
        [itensEventosLimite addObject:[itensEventosOrdenados objectAtIndex:i]];
    }
    
    return itensEventosLimite;
}

@end
