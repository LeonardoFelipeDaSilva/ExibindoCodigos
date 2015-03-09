//
//  ConsultaManager.h
//  Projeto Final
//
//  Created by Leonardo Felipe da Silva on 12/7/14.
//  Copyright (c) 2014 Mack Mobile - BEPiD. All rights reserved.
//

#import "BaseManager.h"
#import "Consulta.h"
#import "BoxesCreatorViewController.h"

@interface ConsultaManager : BaseManager
- (Consulta *)criarConsulta;
- (NSArray *)obterConsultas;
- (void)deletarConsulta:(Consulta *)consulta;
@end
