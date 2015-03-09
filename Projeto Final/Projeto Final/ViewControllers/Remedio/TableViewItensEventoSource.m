//
//  TableViewItensEventosHistoricoRem.m
//  Projeto Final
//
//  Created by Lucas Saito on 30/10/14.
//  Copyright (c) 2014 Mack Mobile - BEPiD. All rights reserved.
//

#import "TableViewItensEventoSource.h"
#import "EventoRepeticaoManager.h"

@interface TableViewItensEventoSource ()
{
    NSArray *tableViewItens;
}

@end

@implementation TableViewItensEventoSource

- (id)initWithEvento:(EventoRepeticao *)evento {
    self = [super init];
    
    if (self) {
        EventoRepeticaoManager *managerEvento = [EventoRepeticaoManager sharedInstance];
        
        tableViewItens = [managerEvento obterItensDoEvento:evento];
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
    
    NSDateFormatter *dateTimeFormatter = [[NSDateFormatter alloc] init];
    [dateTimeFormatter setDateStyle: NSDateFormatterMediumStyle];
    [dateTimeFormatter setTimeStyle:NSDateFormatterShortStyle];
    
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    [cell setAccessoryType:UITableViewCellAccessoryNone];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    [[cell textLabel] setText:[dateTimeFormatter stringFromDate:[tableViewItens objectAtIndex:indexPath.row]]];
    
    return cell;
}

@end
