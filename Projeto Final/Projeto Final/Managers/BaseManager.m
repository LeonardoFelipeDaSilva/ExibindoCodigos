//
//  BaseManager.m
//  Projeto Final
//
//  Created by Lucas Saito on 09/10/14.
//  Copyright (c) 2014 Mack Mobile - BEPiD. All rights reserved.
//

#import "BaseManager.h"
#import "MMAppDelegate.h"

static NSMutableDictionary *_sharedInstances = nil;

@implementation BaseManager

+ (id)allocWithZone:(NSZone *)zone
{
    // Not allow allocating memory in a different zone
    return [self sharedInstance];
}

+ (id)copyWithZone:(NSZone *)zone
{
    // Not allow copying to a different zone
    return [self sharedInstance];
}

+ (instancetype)sharedInstance
{
    id sharedInstance = nil;
    
    @synchronized(self) {
        NSString *instanceClass = NSStringFromClass(self);
        
        // Looking for existing instance
        sharedInstance = [_sharedInstances objectForKey:instanceClass];
        
        // If there's no instance – create one and add it to the dictionary
        if (sharedInstance == nil) {
            sharedInstance = [[super allocWithZone:nil] init];
            [_sharedInstances setObject:sharedInstance forKey:instanceClass];
        }
    }
    
    return sharedInstance;
}

- (id)init
{
    self = [super init];
    
    if (self) {
        
    }
    
    return self;
}

- (NSManagedObjectContext *)getContext
{
    // Obtem referencia ao AppDelegate
    MMAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    
    // Obtem o contexto de persistencia que permite executar comando e consultas
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    
    return context;
}

- (void)saveContext
{
    // Obtem referencia ao AppDelegate
    MMAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    
    [appDelegate saveContext];
}

- (void)deletarObjeto:(NSManagedObject *)objeto
{
    // Obtem o contexto de persistencia que permite executar comando e consultas
    NSManagedObjectContext *context = [self getContext];
    
    [context deleteObject:objeto];
}

@end
