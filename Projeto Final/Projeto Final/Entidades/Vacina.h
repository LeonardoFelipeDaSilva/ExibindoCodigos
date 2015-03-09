//
//  Vacina.h
//  Projeto Final
//
//  Created by Leonardo Felipe da Silva on 11/25/14.
//  Copyright (c) 2014 Mack Mobile - BEPiD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class HistoricoVacina;

@interface Vacina : NSManagedObject

@property (nonatomic, retain) NSString * nome;
@property (nonatomic, retain) NSString * tipo;
@property (nonatomic, retain) NSSet *historico;
@end

@interface Vacina (CoreDataGeneratedAccessors)

- (void)addHistoricoObject:(HistoricoVacina *)value;
- (void)removeHistoricoObject:(HistoricoVacina *)value;
- (void)addHistorico:(NSSet *)values;
- (void)removeHistorico:(NSSet *)values;

@end
