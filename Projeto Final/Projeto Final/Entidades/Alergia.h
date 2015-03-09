//
//  Alergia.h
//  Projeto Final
//
//  Created by Leonardo Felipe da Silva on 11/10/14.
//  Copyright (c) 2014 Mack Mobile - BEPiD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Pessoa;

@interface Alergia : NSManagedObject

@property (nonatomic, retain) NSString * substancia;
@property (nonatomic, retain) NSString * tipo;
@property (nonatomic, retain) Pessoa *pessoa;

@end
