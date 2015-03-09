//
//  Convenio.h
//  Projeto Final
//
//  Created by Lucas Saito on 03/10/14.
//  Copyright (c) 2014 Mack Mobile - BEPiD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Pessoa;

@interface Convenio : NSManagedObject

@property (nonatomic, retain) NSString * nome;
@property (nonatomic, retain) NSNumber * numero;
@property (nonatomic, retain) NSString * plano;
@property (nonatomic, retain) NSDate * validade;
@property (nonatomic, retain) Pessoa *pessoa;

@end
