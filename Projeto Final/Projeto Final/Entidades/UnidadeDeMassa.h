//
//  UnidadeDeMassa.h
//  Projeto Final
//
//  Created by Lucas Saito on 03/10/14.
//  Copyright (c) 2014 Mack Mobile - BEPiD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface UnidadeDeMassa : NSManagedObject

@property (nonatomic, retain) NSNumber * quantidade;
@property (nonatomic, retain) NSNumber * unidade;

@end
