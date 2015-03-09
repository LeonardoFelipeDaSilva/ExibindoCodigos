//
//  SexoViewController.m
//  Projeto Final
//
//  Created by Leonardo Felipe da Silva on 04/09/14.
//  Copyright (c) 2014 Mack Mobile - BEPiD. All rights reserved.
//

#import "SexoViewController.h"

@interface SexoViewController ()

@end

@implementation SexoViewController
@synthesize tableViewNome, pessoa, sexo;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setTitle:@"Sexo"];
    
    tableViewNome = [[UITableView alloc]init];
    [tableViewNome setFrame:CGRectMake(self.view.window.bounds.origin.x, 0, self.view.frame.size.width, self.view.frame.size.height)];
    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(adicionar:)];
    
    [[self navigationItem] setRightBarButtonItem:saveButton];
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelar:)];
    
    [[self navigationItem] setLeftBarButtonItem:cancelButton];
    
    [tableViewNome setDelegate:self];
    [tableViewNome setDataSource:self];
    
    UIView *viewTableView = [self criarView:0];
    [viewTableView setFrame:CGRectMake(viewTableView.frame.origin.x, viewTableView.frame.origin.y, viewTableView.frame.size.width, viewTableView.frame.size.height + tableViewNome.frame.size.height)];
    [viewTableView addSubview:tableViewNome];
    
    [self setContentSizeScrollView];
    // Do any additional setup after loading the view.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 2;
    }
    return  0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 20;
    }
    if (section == 1) {
        return self.view.frame.size.height - (20+30);
    }
    return 0.0;
}
- (CGFloat)tableView: (UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 40.0;
    }
    return 0.0;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    for (int secao=0; secao<tableView.numberOfSections; secao++) {
        for (int linha=0; linha<[tableView numberOfRowsInSection:secao]; linha++) {
            //                NSLog(@"S %d L %d", secao, linha);
            [[tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:linha inSection:secao]] setAccessoryType:UITableViewCellAccessoryNone];
        }
    }
    if (indexPath.row == 0) {
        sexo = @"Feminino";
    }
    if (indexPath.row == 1) {
        sexo = @"Masculino";
    }
    [[tableView cellForRowAtIndexPath:indexPath] setSelectionStyle:UITableViewCellSelectionStyleBlue];
    [[tableView cellForRowAtIndexPath:indexPath] setAccessoryType:UITableViewCellAccessoryCheckmark];
}
- (UITableViewCell *)tableView: (UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *CellIdentifier = @"celulaNome";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    // Configure the cell...
    
    [cell setAccessoryType:UITableViewCellAccessoryNone];
    
    if (indexPath.section == 0) {
        if(indexPath.row == 0){
            NSString *title = @" Feminino";
            [[cell textLabel] setText:title];
            cell.textLabel.textColor = [UIColor colorWithRed:84/255.0f green:84/255.0f blue:84/255.0f alpha:1];
            cell.textLabel.highlightedTextColor = [UIColor whiteColor];
        }
        if(indexPath.row == 1){
            NSString *title = @" Masculino";
            [[cell textLabel] setText:title];
            cell.textLabel.textColor = [UIColor colorWithRed:84/255.0f green:84/255.0f blue:84/255.0f alpha:1];
            cell.textLabel.highlightedTextColor = [UIColor whiteColor];
        }
        
    }
    return cell;
}


- (void)cancelar:(id)sender
{
    
    [self removerTela];
}

- (void)adicionar:(id)sender
{
    pessoa.sexo = sexo;
    PessoaManager *manager = [PessoaManager sharedInstance];
    
    [manager saveContext];
    
    [self removerTela];
}


- (void)removerTela
{
    [self.navigationController popViewControllerAnimated:YES];
    
    //chamando o método do NotificationCenter para atualizar a tableView
    [[NSNotificationCenter defaultCenter] postNotificationName:@"atualizarTableView" object:nil];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
