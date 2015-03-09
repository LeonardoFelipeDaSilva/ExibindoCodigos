//
//  MMTableViewControllerDropDown.m
//  Projeto Final
//
//  Created by Lucas Saito on 28/11/14.
//  Copyright (c) 2014 Mack Mobile - BEPiD. All rights reserved.
//

#import "MMTableViewControllerDropDown.h"

@interface MMTableViewControllerDropDown ()

@end

@implementation MMTableViewControllerDropDown

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    flagTableView = [NSMutableArray arrayWithObjects:[NSNumber numberWithBool:YES], [NSNumber numberWithBool:NO], [NSNumber numberWithBool:NO], nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    NSInteger numSections;
    
    numSections = itensTableView.count;
    
    return numSections;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    NSInteger numRows;
    
    if ([[flagTableView objectAtIndex:section] boolValue]) {
        numRows = [[itensTableView objectAtIndex:section] count];
    } else {
        numRows = 0;
    }
    
    return numRows;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    CGFloat heightHeader;
    
    if ([[itensTableView objectAtIndex:section] count] == 0) {
        heightHeader = 0;
    } else {
        heightHeader = 30.0;
    }
    
    return heightHeader;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat heightRow;
    
    heightRow = 60.0;
    
    return heightRow;
}

//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
//    UITableViewHeaderFooterView *viewSection;
//    
//    viewSection = [[UITableViewHeaderFooterView alloc] init];
//    
//    UIColor *corNavigation = self.navigationController.navigationBar.barTintColor;
//    [[viewSection contentView] setBackgroundColor:corNavigation];
//    
//    MMTapGestureRecognizer *toque = [[MMTapGestureRecognizer alloc] init];
//    toque.objeto = [NSArray arrayWithObjects:tableView, [NSNumber numberWithInteger:section], nil];
//    [toque addTarget:self action:@selector(selToqueSection:)];
//    
//    [viewSection addGestureRecognizer:toque];
//    
//    return viewSection;
//}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
    UIColor *corNavigation = self.navigationController.navigationBar.barTintColor;
    [view setTintColor:corNavigation];
    
    UITableViewHeaderFooterView *header = (UITableViewHeaderFooterView *)view;
    [header.textLabel setTextColor:[UIColor whiteColor]];
    
    MMTapGestureRecognizer *toque = [[MMTapGestureRecognizer alloc] init];
    toque.objeto = [NSArray arrayWithObjects:tableView, [NSNumber numberWithInteger:section], nil];
    [toque addTarget:self action:@selector(selToqueSection:)];
    
    [view addGestureRecognizer:toque];
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - Selector do toque da section

- (void)selToqueSection:(MMTapGestureRecognizer *)toque
{
    MMTapGestureRecognizer *tapGestureRecognizerComObjeto = (MMTapGestureRecognizer *)toque;
    NSArray *parametros = tapGestureRecognizerComObjeto.objeto;
    
    UITableView *tableView = [parametros objectAtIndex:0];
    int section = [[parametros objectAtIndex:1] intValue];
    
    NSNumber *flagSection = [flagTableView objectAtIndex:section];
    BOOL flag = [flagSection boolValue];
    
    [flagTableView setObject:[NSNumber numberWithBool:!flag] atIndexedSubscript:section];
    
    [tableView reloadSections:[NSIndexSet indexSetWithIndex:section] withRowAnimation:UITableViewRowAnimationAutomatic];
}

#pragma mark - Método para criar o filete de cor

- (UIView *)criarFilete:(UIColor *)color andSice:(CGSize)size
{
    UIView *filete = [[UIView alloc]init];
    filete.frame = CGRectMake(3, 2, size.width,size.height + (size.height/2));
    filete.backgroundColor = color;
    return filete;
}
//[UIColor colorWithRed:255/255.0f green:215/255.0f blue:0/255.0f alpha:1.0] amarelo
//[UIColor colorWithRed:205/255.0f green:51/255.0f blue:51/255.0f alpha:1.0] vermelho
//[UIColor colorWithRed:35/255.0f green:142/255.0f blue:35/255.0f alpha:1.0] verdeEscuro

@end
