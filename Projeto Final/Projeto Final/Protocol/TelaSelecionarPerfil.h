//
//  TelaSelecionarPerfil.h
//  Projeto Final
//
//  Created by Lucas Saito on 28/10/14.
//  Copyright (c) 2014 Mack Mobile - BEPiD. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Pessoa;

@protocol TelaSelecionarPerfil <NSObject>

@required
@property (nonatomic, retain) Pessoa *pessoa;

@end
