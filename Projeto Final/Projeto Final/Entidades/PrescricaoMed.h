//
//  PrescricaoMed.h
//  Projeto Final
//
//  Created by Leonardo Felipe da Silva on 11/25/14.
//  Copyright (c) 2014 Mack Mobile - BEPiD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "Evento.h"

@class Foto, Medico, Pessoa, Remedio;

@interface PrescricaoMed : Evento

@property (nonatomic, retain) Pessoa *pessoa;
@property (nonatomic, retain) NSSet *remedio;
@property (nonatomic, retain) NSSet *fotos;
@property (nonatomic, retain) Medico *medico;
@end

@interface PrescricaoMed (CoreDataGeneratedAccessors)

- (void)addRemedioObject:(Remedio *)value;
- (void)removeRemedioObject:(Remedio *)value;
- (void)addRemedio:(NSSet *)values;
- (void)removeRemedio:(NSSet *)values;

- (void)addFotosObject:(Foto *)value;
- (void)removeFotosObject:(Foto *)value;
- (void)addFotos:(NSSet *)values;
- (void)removeFotos:(NSSet *)values;

@end
