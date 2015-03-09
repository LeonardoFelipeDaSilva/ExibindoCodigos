//
//  MMEnums.h
//  Projeto Final
//
//  Created by Lucas Saito on 17/09/14.
//  Copyright (c) 2014 Mack Mobile - BEPiD. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MMEnums : NSObject

typedef NS_ENUM(NSInteger, MMUnidadeDeTempo){
    MMSegundo,
    MMMinuto,
    MMHora,
    MMDia,
    MMSemana,
    MMMes,
    MMAno
};

@end
