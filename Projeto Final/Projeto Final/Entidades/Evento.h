//
//  Evento.h
//  Projeto Final
//
//  Created by Leonardo Felipe da Silva on 11/11/14.
//  Copyright (c) 2014 Mack Mobile - BEPiD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Evento : NSManagedObject

@property (nonatomic, retain) NSDate * data;
@property (nonatomic, retain) NSNumber * notificacao;
@property (nonatomic, retain) NSString * titulo;

@end
