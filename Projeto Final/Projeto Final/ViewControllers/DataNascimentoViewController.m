//
//  DataNascimentoViewController.m
//  Projeto Final
//
//  Created by Leonardo Felipe da Silva on 04/09/14.
//  Copyright (c) 2014 Mack Mobile - BEPiD. All rights reserved.
//

#import "DataNascimentoViewController.h"

@interface DataNascimentoViewController ()

@end

@implementation DataNascimentoViewController
@synthesize tableViewNome, dataNasimento, pessoa, data;
UIDatePicker *datePicker;

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
    
    [self setTitle:@"Nascimento"];
    
    tableViewNome = [[UITableView alloc]init];
    [tableViewNome setFrame:CGRectMake(self.view.window.bounds.origin.x, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [tableViewNome setDelegate:self];
    [tableViewNome setDataSource:self];
    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(adicionar:)];
    
    [[self navigationItem] setRightBarButtonItem:saveButton];
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelar:)];
    
    [[self navigationItem] setLeftBarButtonItem:cancelButton];
    
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
        return 1;
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
        return 30.0;
    }
    return 0.0;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
    if (indexPath.row == 0) {
        
        datePicker = [self criarDatePickerNascimento];
        [tableViewNome addSubview:datePicker];
        [datePicker addTarget:self
                            action:@selector(changeDateInLabel:)
                  forControlEvents:UIControlEventValueChanged];
    }
    }
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
        dataNasimento = [MMLabel criarObjeto:CGRectMake(115, 0, self.view.frame.size.width, 30)];
        dataNasimento.textColor = [UIColor grayColor];
        
        
        NSDateFormatter *dateFormatter;
        dateFormatter = [MMNSDateFormater criarDateFormatter];
        
        
        dataNasimento.text = [NSString stringWithFormat:@"%@",
                                [dateFormatter stringFromDate:[NSDate date]]];
        
        [cell addSubview:dataNasimento];
        
        
    }
    return cell;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)changeDateInLabel:(id)sender{
    //Use NSDateFormatter to write out the date in a friendly format
    
    NSDateFormatter *NSDateFormatter = [MMNSDateFormater criarDateFormatter];
    dataNasimento.text = [NSString stringWithFormat:@"%@",
                 [NSDateFormatter stringFromDate:datePicker.date]];
  
    data = [NSDateFormatter dateFromString:dataNasimento.text];
    
}


- (void)cancelar:(id)sender
{
    
    [self removerTela];
}

- (void)adicionar:(id)sender
{
    pessoa.dNascimento = data;
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

@end
