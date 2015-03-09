//
//  Remedio.h
//  Projeto Final
//
//  Created by Leonardo Felipe da Silva on 11/25/14.
//  Copyright (c) 2014 Mack Mobile - BEPiD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class HistoricoRem, OcorrenciaDoenca, PrescricaoMed, RemedioCaixa;

@interface Remedio : NSManagedObject

@property (nonatomic, retain) NSNumber * dosagem;
@property (nonatomic, retain) NSString * fabricante;
@property (nonatomic, retain) NSData * foto;
@property (nonatomic, retain) NSNumber * generico;
@property (nonatomic, retain) NSString * nome;
@property (nonatomic, retain) NSString * tipo;
@property (nonatomic, retain) NSSet *caixa;
@property (nonatomic, retain) NSSet *historico;
@property (nonatomic, retain) NSSet *ocorrencia;
@property (nonatomic, retain) NSSet *prescricaoMed;
@end

@interface Remedio (CoreDataGeneratedAccessors)

- (void)addCaixaObject:(RemedioCaixa *)value;
- (void)removeCaixaObject:(RemedioCaixa *)value;
- (void)addCaixa:(NSSet *)values;
- (void)removeCaixa:(NSSet *)values;

- (void)addHistoricoObject:(HistoricoRem *)value;
- (void)removeHistoricoObject:(HistoricoRem *)value;
- (void)addHistorico:(NSSet *)values;
- (void)removeHistorico:(NSSet *)values;

- (void)addOcorrenciaObject:(OcorrenciaDoenca *)value;
- (void)removeOcorrenciaObject:(OcorrenciaDoenca *)value;
- (void)addOcorrencia:(NSSet *)values;
- (void)removeOcorrencia:(NSSet *)values;

- (void)addPrescricaoMedObject:(PrescricaoMed *)value;
- (void)removePrescricaoMedObject:(PrescricaoMed *)value;
- (void)addPrescricaoMed:(NSSet *)values;
- (void)removePrescricaoMed:(NSSet *)values;

@end
