//
//  Index.h
//  Projeto Final
//
//  Created by Leonardo Felipe da Silva on 11/11/14.
//  Copyright (c) 2014 Mack Mobile - BEPiD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Index : NSManagedObject

@property (nonatomic, retain) id corCell;
@property (nonatomic, retain) NSString * item;
@property (nonatomic, retain) NSNumber * posicao;

@end
