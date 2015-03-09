//
//  BaseManager.h
//  Projeto Final
//
//  Created by Lucas Saito on 09/10/14.
//  Copyright (c) 2014 Mack Mobile - BEPiD. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseManager : NSObject

//Singleton com herança:
//http://stackoverflow.com/questions/3394033/whats-the-correct-method-to-subclass-a-singleton-class-in-objective-c
//https://github.com/stel/DOSingleton
+ (instancetype)sharedInstance;
- (NSManagedObjectContext *)getContext;
- (void)saveContext;
- (void)deletarObjeto:(NSManagedObject *)objeto;

@end
