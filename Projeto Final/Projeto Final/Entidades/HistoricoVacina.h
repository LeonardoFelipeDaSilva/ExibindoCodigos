//
//  HistoricoVacina.h
//  Projeto Final
//
//  Created by Lucas Saito on 08/12/14.
//  Copyright (c) 2014 Mack Mobile - BEPiD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "EventoRepeticao.h"

@class Vacina;

@interface HistoricoVacina : EventoRepeticao

@property (nonatomic, retain) NSString * local;
@property (nonatomic, retain) Vacina *vacina;

@end
