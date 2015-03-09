//
//  OcorrenciaDoenca.h
//  Projeto Final
//
//  Created by Leonardo Felipe da Silva on 11/25/14.
//  Copyright (c) 2014 Mack Mobile - BEPiD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "Evento.h"

@class Pessoa, Remedio;

@interface OcorrenciaDoenca : Evento

@property (nonatomic, retain) NSString * sintomas;
@property (nonatomic, retain) NSNumber * intensidade;
@property (nonatomic, retain) Pessoa *pessoa;
@property (nonatomic, retain) NSSet *remedio;
@end

@interface OcorrenciaDoenca (CoreDataGeneratedAccessors)

- (void)addRemedioObject:(Remedio *)value;
- (void)removeRemedioObject:(Remedio *)value;
- (void)addRemedio:(NSSet *)values;
- (void)removeRemedio:(NSSet *)values;

@end
