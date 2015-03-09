//
//  FotoManager.m
//  Projeto Final
//
//  Created by Leonardo Felipe da Silva on 11/25/14.
//  Copyright (c) 2014 Mack Mobile - BEPiD. All rights reserved.
//

#import "FotoManager.h"

@implementation FotoManager

- (Foto *)criarFoto
{
    // Obtem referencia ao AppDelegate
    NSManagedObjectContext *context = [self getContext];
    
    Foto *foto = [NSEntityDescription insertNewObjectForEntityForName:@"Foto" inManagedObjectContext:context];
    
    return foto;
}

- (Foto *)inserirFoto:(NSData *)dataFoto
{
    Foto *foto = [self criarFoto];
    
    foto.foto = dataFoto;
    
    return foto;
}

@end
