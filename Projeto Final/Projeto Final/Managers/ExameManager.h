//
//  ExameManager.h
//  Projeto Final
//
//  Created by Leonardo Felipe da Silva on 17/10/14.
//  Copyright (c) 2014 Mack Mobile - BEPiD. All rights reserved.
//

#import "BaseManager.h"
#import "BoxesCreatorViewController.h"
#import "Exame.h"

@interface ExameManager : BaseManager

- (Exame *)criarExame;
- (NSArray *)obterExames;
- (void)deletarExame:(Exame *)exame;
@end
