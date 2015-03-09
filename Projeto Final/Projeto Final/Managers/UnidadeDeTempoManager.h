//
//  UnidadeDeTempoManager.h
//  Projeto Final
//
//  Created by Lucas Saito on 24/09/14.
//  Copyright (c) 2014 Mack Mobile - BEPiD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseManager.h"
#import "UnidadeDeTempo.h"
#import "MMEnums.h"

@interface UnidadeDeTempoManager : BaseManager

- (UnidadeDeTempo *)criarUnidadeDeTempo;
- (void)deletarUnidadeDeTempo:(UnidadeDeTempo *)unidadeDeTempo;
- (NSUInteger)quantidadeDeUnidades;
- (NSArray *)obterUnidadesDeTempo:(BOOL)plural;
- (NSArray *)obterUnidadesDeTempoDoTempo:(UnidadeDeTempo *)unidadeDeTempo;

- (NSString *)criarLabel:(UnidadeDeTempo *)unidadeDeTempo;
- (MMUnidadeDeTempo)obterUnidadeDaUnidadeDeTempo:(UnidadeDeTempo *)unidadeDeTempo;
- (NSDate *)data:(NSDate *)data comUnidadeDeTempo:(UnidadeDeTempo *)unidadeDeTempo;
- (int)qtdSegundosDaUnidadeDeTempo:(UnidadeDeTempo *)unidadeDeTempo;
- (NSCalendarUnit)obterCalendarUnitFrequenciaDaUnidadeDeTempo:(UnidadeDeTempo *)unidadeDeTempo;

@end
