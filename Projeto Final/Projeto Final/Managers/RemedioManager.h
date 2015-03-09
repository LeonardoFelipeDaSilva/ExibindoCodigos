//
//  RemedioManager.h
//  Projeto Final
//
//  Created by Leonardo Felipe da Silva on 22/08/14.
//  Copyright (c) 2014 Mack Mobile - BEPiD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseManager.h"
#import "Remedio.h"
#import "HistoricoRem.h"
#import "RemedioCaixa.h"

@interface RemedioManager : BaseManager

- (Remedio *)criarRemedio;
- (HistoricoRem *)criarHistoricoRemDoRemedio:(Remedio *)remedio;
- (RemedioCaixa *)criarRemedioCaixaNoRemedio:(Remedio *)remedio;

- (NSArray *)obterRemedios;
- (NSArray *)obterHistoricoDoRemedio:(Remedio *)remedio;
- (NSArray *)obterCaixaDoRemedio:(Remedio *)remedio;

- (HistoricoRem *)proximoEventoDoRemedio:(Remedio *)remedio;

- (NSDictionary *)obterRemediosPorStatusDoPerfil;
- (NSDictionary *)obterHistoricoPorStatusDoRemedio:(Remedio *)remedio;
- (NSArray *)obterPessoasComHistoricoDoRemedio:(Remedio *)remedio;
- (NSDate *)proximaDataDoHistoricoRem:(HistoricoRem *)historicoRem;
- (NSDate *)dataFinalHistoricoRem:(HistoricoRem *)historicoRem;
- (int)qtdEventosDoHistoricoRem:(HistoricoRem *)historicoRem;
- (BOOL)jaIniciouHistoricoRem:(HistoricoRem *)historicoRem;
- (BOOL)jaTerminouHistoricoRem:(HistoricoRem *)historicoRem;
- (BOOL)tomarRemedioDoHistoricoRem:(HistoricoRem *)historicoRem;

- (NSDictionary *)obterCaixaPorStatusDoRemedio:(Remedio *)remedio;
- (NSDictionary *)obterQuantidadeRemedioCaixaDoRemedio:(Remedio *)remedio;
- (BOOL)jaVenceuCaixaDoRemedio:(RemedioCaixa *)remedioCaixa;

- (void)deletarRemedio:(Remedio *)remedio;
- (void)deletarHistoricoRem:(HistoricoRem *)historicoRem;
- (void)deletarRemedioCaixa:(RemedioCaixa *)remedioCaixa;

@end
