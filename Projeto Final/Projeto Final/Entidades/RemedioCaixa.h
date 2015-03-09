//
//  RemedioCaixa.h
//  Projeto Final
//
//  Created by Lucas Saito on 03/10/14.
//  Copyright (c) 2014 Mack Mobile - BEPiD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Remedio;

@interface RemedioCaixa : NSManagedObject

@property (nonatomic, retain) NSNumber * qtdTotal;
@property (nonatomic, retain) NSDate * dataValidade;
@property (nonatomic, retain) NSNumber * qtdAtual;
@property (nonatomic, retain) Remedio *remedio;

@end
