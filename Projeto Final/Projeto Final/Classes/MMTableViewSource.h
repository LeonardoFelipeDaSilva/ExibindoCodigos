//
//  MMTableViewSource.h
//  Projeto Final
//
//  Created by Lucas Saito on 11/11/14.
//  Copyright (c) 2014 Mack Mobile - BEPiD. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MMTableViewSource : NSObject <UITableViewDataSource, UITableViewDelegate>

- (id)initWithArray:(NSArray *)array;

@end
