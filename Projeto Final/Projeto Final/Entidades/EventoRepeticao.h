//
//  EventoRepeticao.h
//  Projeto Final
//
//  Created by Lucas Saito on 08/12/14.
//  Copyright (c) 2014 Mack Mobile - BEPiD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Pessoa, UnidadeDeTempo;

@interface EventoRepeticao : NSManagedObject

@property (nonatomic, retain) NSDate * dataInicio;
@property (nonatomic, retain) NSNumber * notificacao;
@property (nonatomic, retain) NSString * titulo;
@property (nonatomic, retain) UnidadeDeTempo *duracao;
@property (nonatomic, retain) UnidadeDeTempo *frequencia;
@property (nonatomic, retain) Pessoa *pessoa;

@end
