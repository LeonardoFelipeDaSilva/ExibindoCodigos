//
//  Consulta.h
//  Projeto Final
//
//  Created by Leonardo Felipe da Silva on 12/8/14.
//  Copyright (c) 2014 Mack Mobile - BEPiD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "Evento.h"

@class Medico, Pessoa;

@interface Consulta : Evento

@property (nonatomic, retain) NSString * texto;
@property (nonatomic, retain) NSString * anotacoes;
@property (nonatomic, retain) Medico *medico;
@property (nonatomic, retain) Pessoa *pessoa;

@end
