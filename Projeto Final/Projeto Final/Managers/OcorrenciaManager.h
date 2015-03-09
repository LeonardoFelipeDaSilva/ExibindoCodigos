//
//  OcorrenciaManager.h
//  Projeto Final
//
//  Created by Leonardo Felipe da Silva on 01/10/14.
//  Copyright (c) 2014 Mack Mobile - BEPiD. All rights reserved.
//

#import "BaseManager.h"
#import "BoxesCreatorViewController.h"
#import "OcorrenciaDoenca.h"

@interface OcorrenciaManager : BaseManager

- (OcorrenciaDoenca *)criarOcorrencia;
- (NSArray *)obterOcorrencias;
- (void)deletarOcorrencia:(OcorrenciaDoenca *)ocorrencia;

@end
