//
//  HistoricoRem.h
//  Projeto Final
//
//  Created by Lucas Saito on 08/12/14.
//  Copyright (c) 2014 Mack Mobile - BEPiD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "EventoRepeticao.h"

@class Remedio;

@interface HistoricoRem : EventoRepeticao

@property (nonatomic, retain) NSNumber * qtda;
@property (nonatomic, retain) Remedio *remedio;

@end
