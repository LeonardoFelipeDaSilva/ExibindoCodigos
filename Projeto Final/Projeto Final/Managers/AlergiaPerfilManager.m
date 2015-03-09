//
//  AlergiaPerfilManager.m
//  Projeto Final
//
//  Created by Leonardo Felipe da Silva on 12/3/14.
//  Copyright (c) 2014 Mack Mobile - BEPiD. All rights reserved.
//

#import "AlergiaPerfilManager.h"

@implementation AlergiaPerfilManager
- (Alergia *)criarAlergia
{
    // Obtem referencia ao AppDelegate
    NSManagedObjectContext *context = [self getContext];
    
    Alergia *alergia = [NSEntityDescription insertNewObjectForEntityForName:@"Alergia" inManagedObjectContext:context];
    
    return alergia;
}

//- (Alergia *)inserirAlergia:(NSData *)dataFoto
//{
//    Foto *foto = [self criarFoto];
//    
//    foto.foto = dataFoto;
//    
//    return foto;
//}
@end
