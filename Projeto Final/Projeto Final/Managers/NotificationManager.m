//
//  NotificationManager.m
//  Projeto Final
//
//  Created by Lucas Saito on 04/11/14.
//  Copyright (c) 2014 Mack Mobile - BEPiD. All rights reserved.
//

#import "NotificationManager.h"
#import "EventoRepeticaoManager.h"

@implementation NotificationManager

- (void)solicitarPermissaoDeNotificacao
{
    // Solicitar a permissão para enviar notificações (somente iOS 8 para cima)
//    #if __IPHONE_OS_VERSION_MAX_ALLOWED >= 80000
    if ([[UIApplication sharedApplication] respondsToSelector:@selector(registerUserNotificationSettings:)]) {
        UIUserNotificationType types = UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert;
        UIUserNotificationSettings *mySettings = [UIUserNotificationSettings settingsForTypes:types categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:mySettings];
    }
//    #endif
}

- (BOOL)temPermissaoParaEnivarNotificacao
{
    if ([[UIApplication sharedApplication] respondsToSelector:@selector(currentUserNotificationSettings)]) {
        UIUserNotificationSettings *configuracao = [[UIApplication sharedApplication] currentUserNotificationSettings];

        NSLog(@"%@", configuracao);

        if (configuracao && configuracao.types) {
            NSLog(@"TEM PERMISSÃO PARA NOTIFICAÇÃO");
            return YES;
        } else {
            NSLog(@"NÃO TEM PERMISSÃO PARA NOTIFICAÇÃO");
            return NO;
        }
    } else {
        NSLog(@"Versão do iOS inferior a 8.0 - método de verificação não existe em versões anteriores que o 8");
        return YES;
    }
}

- (void)criarItensEventoNotificacao
{
    if (![self temPermissaoParaEnivarNotificacao]) {
        return;
    }
    
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    
    EventoRepeticaoManager *managerEvento = [EventoRepeticaoManager sharedInstance];
    
    NSArray *itens = [managerEvento obterItensFuturosSomenteComNotificacao:YES comLimite:64];
    
    for (NSArray *item in itens) {
        EventoRepeticao *evento = [item objectAtIndex:1];
        
        UILocalNotification *notification = [[UILocalNotification alloc] init];
        notification.fireDate = [item objectAtIndex:0];
        notification.alertBody = [NSString stringWithFormat:@"%@", evento.titulo];
        notification.soundName = UILocalNotificationDefaultSoundName;
        [[UIApplication sharedApplication] scheduleLocalNotification:notification];
    }
}

- (void)criarItensEventoNotificationDoEvento:(EventoRepeticao *)evento
{
    if (![self temPermissaoParaEnivarNotificacao]) {
        return;
    }
    
    EventoRepeticaoManager *managerEvento = [EventoRepeticaoManager sharedInstance];
    
    NSArray *itens = [managerEvento obterItensFuturosDoEvento:evento];
    
    for (NSDate *data in itens) {
        UILocalNotification *notification = [[UILocalNotification alloc] init];
        notification.fireDate = data;
        notification.alertBody = [NSString stringWithFormat:@"%@", evento.titulo];
        notification.soundName = UILocalNotificationDefaultSoundName;
        [[UIApplication sharedApplication] scheduleLocalNotification:notification];
    }
}

@end
