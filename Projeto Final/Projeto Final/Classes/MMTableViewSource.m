//
//  MMTableViewSource.m
//  Projeto Final
//
//  Created by Lucas Saito on 11/11/14.
//  Copyright (c) 2014 Mack Mobile - BEPiD. All rights reserved.
//

#import "MMTableViewSource.h"

@interface MMTableViewSource ()
{
    NSArray *tableViewItens;
}

@end

@implementation MMTableViewSource

- (id)initWithArray:(NSArray *)array
{
    self = [super init];
    
    if (self) {
        tableViewItens = array;
    }
    
    return self;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    NSInteger numRows;
    
    numRows = tableViewItens.count;
    
    return numRows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    [cell setAccessoryType:UITableViewCellAccessoryNone];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    [[cell textLabel] setText:[tableViewItens objectAtIndex:indexPath.row]];
    
    return cell;
}

@end
