//
//  Especialidade.h
//  Projeto Final
//
//  Created by Leonardo Felipe da Silva on 11/25/14.
//  Copyright (c) 2014 Mack Mobile - BEPiD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Medico;

@interface Especialidade : NSManagedObject

@property (nonatomic, retain) NSString * nome;
@property (nonatomic, retain) NSSet *medicos;
@end

@interface Especialidade (CoreDataGeneratedAccessors)

- (void)addMedicosObject:(Medico *)value;
- (void)removeMedicosObject:(Medico *)value;
- (void)addMedicos:(NSSet *)values;
- (void)removeMedicos:(NSSet *)values;

@end
