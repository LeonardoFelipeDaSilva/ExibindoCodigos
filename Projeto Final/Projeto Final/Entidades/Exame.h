//
//  Exame.h
//  Projeto Final
//
//  Created by Leonardo Felipe da Silva on 11/25/14.
//  Copyright (c) 2014 Mack Mobile - BEPiD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "Evento.h"

@class Foto, Medico, Pessoa;

@interface Exame : Evento

@property (nonatomic, retain) NSString * local;
@property (nonatomic, retain) Medico *medico;
@property (nonatomic, retain) Pessoa *pessoa;
@property (nonatomic, retain) NSSet *fotos;
@end

@interface Exame (CoreDataGeneratedAccessors)

- (void)addFotosObject:(Foto *)value;
- (void)removeFotosObject:(Foto *)value;
- (void)addFotos:(NSSet *)values;
- (void)removeFotos:(NSSet *)values;

@end
