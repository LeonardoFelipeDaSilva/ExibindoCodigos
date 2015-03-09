//
//  MMAlerta.h
//  Projeto Final
//
//  Created by Adriana Yuri on 22/09/14.
//  Copyright (c) 2014 Mack Mobile - BEPiD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EventoRepeticao.h"
#import "UnidadeDeTempoManager.h"

@interface MMAlerta : NSObject


@property (nonatomic, retain) NSDate * alertaData;
@property (nonatomic, retain) NSString * alertaTitulo;
@property (nonatomic, retain) UnidadeDeTempo * alertaDuracao;
@property (nonatomic, retain) UnidadeDeTempo * alertaFrequencia;
@property (nonatomic, retain) NSMutableArray *arrayAlertaDoEvento;
@property int quantidadeAlerta;

-(NSMutableArray*)geraListaAlertaDoEvento: (EventoRepeticao*) evento;

@end
