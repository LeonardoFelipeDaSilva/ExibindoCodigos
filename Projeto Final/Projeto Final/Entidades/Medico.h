//
//  Medico.h
//  Projeto Final
//
//  Created by Leonardo Felipe da Silva on 11/25/14.
//  Copyright (c) 2014 Mack Mobile - BEPiD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Exame, PrescricaoMed;

@interface Medico : NSManagedObject

@property (nonatomic, retain) NSString * nome;
@property (nonatomic, retain) NSSet *consultas;
@property (nonatomic, retain) NSSet *especialidades;
@property (nonatomic, retain) NSSet *prescricoes;
@property (nonatomic, retain) NSSet *exames;
@end

@interface Medico (CoreDataGeneratedAccessors)

- (void)addConsultasObject:(NSManagedObject *)value;
- (void)removeConsultasObject:(NSManagedObject *)value;
- (void)addConsultas:(NSSet *)values;
- (void)removeConsultas:(NSSet *)values;

- (void)addEspecialidadesObject:(NSManagedObject *)value;
- (void)removeEspecialidadesObject:(NSManagedObject *)value;
- (void)addEspecialidades:(NSSet *)values;
- (void)removeEspecialidades:(NSSet *)values;

- (void)addPrescricoesObject:(PrescricaoMed *)value;
- (void)removePrescricoesObject:(PrescricaoMed *)value;
- (void)addPrescricoes:(NSSet *)values;
- (void)removePrescricoes:(NSSet *)values;

- (void)addExamesObject:(Exame *)value;
- (void)removeExamesObject:(Exame *)value;
- (void)addExames:(NSSet *)values;
- (void)removeExames:(NSSet *)values;

@end
