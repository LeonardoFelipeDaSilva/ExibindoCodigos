//
//  MedicoManager.h
//  Projeto Final
//
//  Created by Leonardo Felipe da Silva on 12/3/14.
//  Copyright (c) 2014 Mack Mobile - BEPiD. All rights reserved.
//

#import "BaseManager.h"
#import "Medico.h"

@interface MedicoManager : BaseManager
- (Medico *)criarMedico;
- (NSArray *)obterMedicos;
- (void)deletarMedico: (Medico *)medico;
@end
