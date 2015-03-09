//
//  NotificationManager.h
//  Projeto Final
//
//  Created by Lucas Saito on 04/11/14.
//  Copyright (c) 2014 Mack Mobile - BEPiD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseManager.h"
#import "EventoRepeticao.h"

@interface NotificationManager : BaseManager

- (void)solicitarPermissaoDeNotificacao;
- (BOOL)temPermissaoParaEnivarNotificacao;

- (void)criarItensEventoNotificacao;
- (void)criarItensEventoNotificationDoEvento:(EventoRepeticao *)evento;

@end
