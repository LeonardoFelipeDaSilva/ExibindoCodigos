//
//  AlertaManager.h
//  Projeto Final
//
//  Created by Leonardo Felipe da Silva on 22/08/14.
//  Copyright (c) 2014 Mack Mobile - BEPiD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <EventKit/EventKit.h>
#import "BaseManager.h"
#import "EventoRepeticao.h"

@interface EventoRepeticaoManager : BaseManager

- (NSArray *)obterEventos;
- (NSArray *)obterEventosNaoFinalizados;

- (NSArray *)obterItensDoEvento:(EventoRepeticao *)evento;
- (NSArray *)obterItensFuturosDoEvento:(EventoRepeticao *)evento;
- (NSArray *)obterItensFuturosDoEvento:(EventoRepeticao *)evento comLimite:(NSInteger)limite;

- (NSDate *)proximaDataDoEvento:(EventoRepeticao *)evento;
- (NSDate *)dataFinalDoEvento:(EventoRepeticao *)evento;

- (int)qtdItensDoEvento:(EventoRepeticao *)evento;

- (BOOL)jaIniciouEvento:(EventoRepeticao *)evento;
- (BOOL)jaTerminouEvento:(EventoRepeticao *)evento;

- (void)criarItensEventoNoCalendarioDoEvento:(EventoRepeticao *)evento;

- (NSArray *)obterItensFuturosSomenteComNotificacao:(BOOL)notificacao comLimite:(NSInteger)limite;

@end
