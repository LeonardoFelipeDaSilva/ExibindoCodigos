//
//  VacinaManager.h
//  Projeto Final
//
//  Created by Leonardo Felipe da Silva on 08/09/14.
//  Copyright (c) 2014 Mack Mobile - BEPiD. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "BaseManager.h"
#import "Vacina.h"
#import "HistoricoVacina.h"

@interface VacinaManager : BaseManager

- (Vacina *)criarVacina;
- (HistoricoVacina *)criarHistoricoVacinaDaVacina:(Vacina *)vacina;


- (NSArray *)obterVacinas;
- (NSArray *)obterHistoricoDaVacina:(Vacina *)vacina;
- (NSArray *)obterPessoasComHistoricoDaVacina:(Vacina *)vacina;


- (HistoricoVacina *)proximoEventoDaVacina:(Vacina *)vacina;

- (NSDictionary *)obterHistoricoPorStatusDaVacina:(Vacina *)vacina;
- (NSArray *)ordenarHistoricoVacinaPelaDataInicio:(NSArray *)itens;
- (NSArray *)ordenarHistoricoVacinaPelaProximaData:(NSArray *)itens;
- (NSArray *)ordenarHistoricoVacinaPelaDataTermino:(NSArray *)itens;
- (NSDate *)proximaDataDoHistoricoVacina:(HistoricoVacina *)historico;
- (NSDate *)dataFinalHistoricoVacina:(HistoricoVacina *)historico;
- (int)qtdEventosDoHistoricoVacina:(HistoricoVacina *)historico;
- (BOOL)jaIniciouHistoricoVacina:(HistoricoVacina *)historico;
- (BOOL)jaTerminouHistoricoVacina:(HistoricoVacina *)historico;
- (void)deletarVacina:(Vacina *)vacina;
- (void)deletarHistoricoVacina:(HistoricoVacina *)historico;




@end
