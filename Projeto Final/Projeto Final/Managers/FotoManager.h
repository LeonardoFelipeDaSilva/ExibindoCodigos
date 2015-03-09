//
//  FotoManager.h
//  Projeto Final
//
//  Created by Leonardo Felipe da Silva on 11/25/14.
//  Copyright (c) 2014 Mack Mobile - BEPiD. All rights reserved.
//

#import "BaseManager.h"
#import "Foto.h"

@interface FotoManager : BaseManager

- (Foto *)criarFoto;
- (Foto *)inserirFoto:(NSData *)dataFoto;

@end
