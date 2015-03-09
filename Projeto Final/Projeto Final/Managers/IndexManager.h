//
//  IndexManager.h
//  Projeto Final
//
//  Created by Adriana Yuri on 02/09/14.
//  Copyright (c) 2014 Mack Mobile - BEPiD. All rights reserved.
//

#import "Index.h"
#import "BaseManager.h"

@interface IndexManager : BaseManager

- (void)criarDefaultListaIndex;
- (void)atualizarListaIndex:(NSInteger)from para:(NSInteger)to;
- (NSArray *)obterListaIndex;

@end
