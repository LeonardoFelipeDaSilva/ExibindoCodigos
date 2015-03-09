//
//  Pessoa.h
//  Projeto Final
//
//  Created by Leonardo Felipe da Silva on 11/25/14.
//  Copyright (c) 2014 Mack Mobile - BEPiD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Alergia, Convenio, Exame, HistoricoRem, HistoricoVacina, OcorrenciaDoenca, PrescricaoMed;

@interface Pessoa : NSManagedObject

@property (nonatomic, retain) NSNumber * ativo;
@property (nonatomic, retain) id cor;
@property (nonatomic, retain) NSDate * dNascimento;
@property (nonatomic, retain) NSData * foto;
@property (nonatomic, retain) NSString * nome;
@property (nonatomic, retain) NSString * sexo;
@property (nonatomic, retain) NSString * sobrenome;
@property (nonatomic, retain) NSString * tipoSanguineo;
@property (nonatomic, retain) NSSet *alergia;
@property (nonatomic, retain) NSOrderedSet *convenios;
@property (nonatomic, retain) NSSet *exames;
@property (nonatomic, retain) NSOrderedSet *historicoRem;
@property (nonatomic, retain) NSSet *historicoVacina;
@property (nonatomic, retain) NSSet *ocorrencia;
@property (nonatomic, retain) NSSet *prescricaoMed;
@property (nonatomic, retain) NSSet *consultas;
@end

@interface Pessoa (CoreDataGeneratedAccessors)

- (void)addAlergiaObject:(Alergia *)value;
- (void)removeAlergiaObject:(Alergia *)value;
- (void)addAlergia:(NSSet *)values;
- (void)removeAlergia:(NSSet *)values;

- (void)insertObject:(Convenio *)value inConveniosAtIndex:(NSUInteger)idx;
- (void)removeObjectFromConveniosAtIndex:(NSUInteger)idx;
- (void)insertConvenios:(NSArray *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeConveniosAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInConveniosAtIndex:(NSUInteger)idx withObject:(Convenio *)value;
- (void)replaceConveniosAtIndexes:(NSIndexSet *)indexes withConvenios:(NSArray *)values;
- (void)addConveniosObject:(Convenio *)value;
- (void)removeConveniosObject:(Convenio *)value;
- (void)addConvenios:(NSOrderedSet *)values;
- (void)removeConvenios:(NSOrderedSet *)values;
- (void)addExamesObject:(Exame *)value;
- (void)removeExamesObject:(Exame *)value;
- (void)addExames:(NSSet *)values;
- (void)removeExames:(NSSet *)values;

- (void)insertObject:(HistoricoRem *)value inHistoricoRemAtIndex:(NSUInteger)idx;
- (void)removeObjectFromHistoricoRemAtIndex:(NSUInteger)idx;
- (void)insertHistoricoRem:(NSArray *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeHistoricoRemAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInHistoricoRemAtIndex:(NSUInteger)idx withObject:(HistoricoRem *)value;
- (void)replaceHistoricoRemAtIndexes:(NSIndexSet *)indexes withHistoricoRem:(NSArray *)values;
- (void)addHistoricoRemObject:(HistoricoRem *)value;
- (void)removeHistoricoRemObject:(HistoricoRem *)value;
- (void)addHistoricoRem:(NSOrderedSet *)values;
- (void)removeHistoricoRem:(NSOrderedSet *)values;
- (void)addHistoricoVacinaObject:(HistoricoVacina *)value;
- (void)removeHistoricoVacinaObject:(HistoricoVacina *)value;
- (void)addHistoricoVacina:(NSSet *)values;
- (void)removeHistoricoVacina:(NSSet *)values;

- (void)addOcorrenciaObject:(OcorrenciaDoenca *)value;
- (void)removeOcorrenciaObject:(OcorrenciaDoenca *)value;
- (void)addOcorrencia:(NSSet *)values;
- (void)removeOcorrencia:(NSSet *)values;

- (void)addPrescricaoMedObject:(PrescricaoMed *)value;
- (void)removePrescricaoMedObject:(PrescricaoMed *)value;
- (void)addPrescricaoMed:(NSSet *)values;
- (void)removePrescricaoMed:(NSSet *)values;

- (void)addConsultasObject:(NSManagedObject *)value;
- (void)removeConsultasObject:(NSManagedObject *)value;
- (void)addConsultas:(NSSet *)values;
- (void)removeConsultas:(NSSet *)values;

@end
