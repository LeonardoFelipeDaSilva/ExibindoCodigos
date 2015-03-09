//
//  MMAlerta.m
//  Projeto Final
//
//  Created by Adriana Yuri on 22/09/14.
//  Copyright (c) 2014 Mack Mobile - BEPiD. All rights reserved.
//

#import "MMAlerta.h"
#import "EventoRepeticao.h"
#import "MMPrincipal.h"
#import "NSDate+Utilities.h"

@implementation MMAlerta

@synthesize arrayAlertaDoEvento, alertaData, alertaTitulo, alertaDuracao, alertaFrequencia, quantidadeAlerta;



-(NSMutableArray*)geraListaAlertaDoEvento:(EventoRepeticao *)evento{
    
    
    if ([evento.duracao.unidade intValue] == MMMinuto) {
        int duracaoProvisoria = [evento.duracao.quantidade intValue];
        duracaoProvisoria = duracaoProvisoria *60;
        NSNumber *duracaoProvisoriaNsNumber = [NSNumber numberWithInt:duracaoProvisoria];
        evento.duracao.quantidade = duracaoProvisoriaNsNumber;
    
    }else if ([evento.duracao.unidade intValue] == MMHora){
        int duracaoProvisoria = [evento.duracao.quantidade intValue];
        duracaoProvisoria = duracaoProvisoria *60*60;
        NSNumber *duracaoProvisoriaNsNumber = [NSNumber numberWithInt:duracaoProvisoria];
        evento.duracao.quantidade = duracaoProvisoriaNsNumber;

    }else if ([evento.duracao.unidade intValue] == MMDia){
        int duracaoProvisoria = [evento.duracao.quantidade intValue];
        duracaoProvisoria = duracaoProvisoria *60*60*24;
        NSNumber *duracaoProvisoriaNsNumber = [NSNumber numberWithInt:duracaoProvisoria];
        evento.duracao.quantidade = duracaoProvisoriaNsNumber;
        
    }else if ([evento.duracao.unidade intValue] == MMSemana){
        int duracaoProvisoria = [evento.duracao.quantidade intValue];
        duracaoProvisoria = duracaoProvisoria *60*60*24*7;
        NSNumber *duracaoProvisoriaNsNumber = [NSNumber numberWithInt:duracaoProvisoria];
        evento.duracao.quantidade = duracaoProvisoriaNsNumber;
        
    }else if ([evento.duracao.unidade intValue] == MMMes){
        int duracaoProvisoria = [evento.duracao.quantidade intValue];
        duracaoProvisoria = duracaoProvisoria *60*60*24*30;
        NSNumber *duracaoProvisoriaNsNumber = [NSNumber numberWithInt:duracaoProvisoria];
        evento.duracao.quantidade = duracaoProvisoriaNsNumber;
        
    }else if ([evento.duracao.unidade intValue] == MMAno ){
        int duracaoProvisoria = [evento.duracao.quantidade intValue];
        duracaoProvisoria = duracaoProvisoria *60*60*24*30*365;
        NSNumber *duracaoProvisoriaNsNumber = [NSNumber numberWithInt:duracaoProvisoria];
        evento.duracao.quantidade = duracaoProvisoriaNsNumber;
        
    }


    if ([evento.frequencia.unidade intValue] == MMMinuto) {
        int frequenciaProvisoria = [evento.frequencia.quantidade intValue];
        frequenciaProvisoria = frequenciaProvisoria *60;
        NSNumber *frequenciaProvisoriaNsNumber = [NSNumber numberWithInt:frequenciaProvisoria];
        evento.frequencia.quantidade = frequenciaProvisoriaNsNumber;
        
    }else if ([evento.frequencia.unidade intValue] == MMHora){
        int frequenciaProvisoria = [evento.frequencia.quantidade intValue];
        frequenciaProvisoria = frequenciaProvisoria *60*60;
        NSNumber *frequenciaProvisoriaNsNumber = [NSNumber numberWithInt:frequenciaProvisoria];
        evento.frequencia.quantidade = frequenciaProvisoriaNsNumber;
        
    }else if ([evento.frequencia.unidade intValue] == MMDia){
        int frequenciaProvisoria = [evento.frequencia.quantidade intValue];
        frequenciaProvisoria = frequenciaProvisoria *60*60*24;
        NSNumber *frequenciaProvisoriaNsNumber = [NSNumber numberWithInt:frequenciaProvisoria];
        evento.frequencia.quantidade = frequenciaProvisoriaNsNumber;
        
    }else if ([evento.frequencia.unidade intValue] == MMSemana){
        int frequenciaProvisoria = [evento.frequencia.quantidade intValue];
        frequenciaProvisoria = frequenciaProvisoria *60*60*24*7;
        NSNumber *frequenciaProvisoriaNsNumber = [NSNumber numberWithInt:frequenciaProvisoria];
        evento.frequencia.quantidade = frequenciaProvisoriaNsNumber;
        
    }else if ([evento.frequencia.unidade intValue] == MMMes){
        int frequenciaProvisoria = [evento.frequencia.quantidade intValue];
        frequenciaProvisoria = frequenciaProvisoria *60*60*24*30;
        NSNumber *frequenciaProvisoriaNsNumber = [NSNumber numberWithInt:frequenciaProvisoria];
        evento.frequencia.quantidade = frequenciaProvisoriaNsNumber;
    
    }else if ([evento.frequencia.unidade intValue] == MMAno ){
        int frequenciaProvisoria = [evento.frequencia.quantidade intValue];
        frequenciaProvisoria = frequenciaProvisoria *60*60*24*30*365;
        NSNumber *frequenciaProvisoriaNsNumber = [NSNumber numberWithInt:frequenciaProvisoria];
        evento.frequencia.quantidade = frequenciaProvisoriaNsNumber;
        
    }

    //
    quantidadeAlerta = [evento.duracao.quantidade intValue]/ [evento.frequencia.quantidade intValue];
    
    
    for (int i = 0; i <quantidadeAlerta; i++) {
        self.alertaData = [evento.dataInicio dateByAddingMinutes:[evento.frequencia.quantidade integerValue]];
        
    }
    
    
     
    return arrayAlertaDoEvento;
}


@end
