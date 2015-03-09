//
//  PrescicaoMedManager.h
//  Projeto Final
//
//  Created by Leonardo Felipe da Silva on 03/10/14.
//  Copyright (c) 2014 Mack Mobile - BEPiD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseManager.h"
#import "PrescricaoMed.h"
#import "Foto.h"

@interface PrescicaoMedManager : BaseManager

- (PrescricaoMed *)criarPrescricao;
- (NSArray *) obterPrescricao;
- (void)deletarPrescicao:(PrescricaoMed *)prescicao;

@end
