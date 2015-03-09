//
//  NumeroConvenioViewController.m
//  Projeto Final
//
//  Created by Leonardo Felipe da Silva on 24/09/14.
//  Copyright (c) 2014 Mack Mobile - BEPiD. All rights reserved.
//

#import "NumeroConvenioViewController.h"

@interface NumeroConvenioViewController ()

@end

@implementation NumeroConvenioViewController
@synthesize numeroTextField, tableViewNumero, convenio, clearButton;

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
    
    [self setTitle:@"Numero"];
    tableViewNumero = [[UITableView alloc]init];
    [tableViewNumero setFrame:CGRectMake(self.view.window.bounds.origin.x, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [tableViewNumero setDelegate:self];
    [tableViewNumero setDataSource:self];
    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(adicionar:)];
    
    [[self navigationItem] setRightBarButtonItem:saveButton];
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelar:)];
    
    [[self navigationItem] setLeftBarButtonItem:cancelButton];
    
    UIView *viewTableView = [self criarView:0];
    [viewTableView setFrame:CGRectMake(viewTableView.frame.origin.x, viewTableView.frame.origin.y, viewTableView.frame.size.width, viewTableView.frame.size.height + tableViewNumero.frame.size.height)];
    [viewTableView addSubview:tableViewNumero];
    
    [self setContentSizeScrollView];
    
    
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 2;
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    
    if (section == 1) {
        
    
        return @" ";
    }

    return @" ";
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
        return 20.0;
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
        numeroTextField = [MMTextField criarObjeto:CGRectMake(10, 0, self.view.frame.size.width-60, 30)];
        numeroTextField.borderStyle = UITextBorderStyleNone;
        numeroTextField.returnKeyType = UIReturnKeyDone;
        numeroTextField.keyboardType = UIKeyboardTypeNumberPad;
        [numeroTextField setDelegate:self];
        clearButton = [[UIButton alloc]init];
        clearButton.frame = CGRectMake(numeroTextField.frame.origin.x + numeroTextField.frame.size.width + 5, 2.5, 25, 25);
        [clearButton addTarget:self action:@selector(clear:) forControlEvents:UIControlEventTouchDown];
        [clearButton setImage:[UIImage imageNamed:@"borracha_branco.png"] forState:UIControlStateNormal];
        clearButton.layer.cornerRadius = 13;
        if (self.navigationController.navigationBar.barTintColor == nil) {
            clearButton.backgroundColor = [UIColor grayColor];
        }else{
            clearButton.backgroundColor = self.navigationController.navigationBar.barTintColor;
        }
        
        NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc]init];
        
        numeroTextField.text = [numberFormatter stringFromNumber:convenio.numero];
        [cell addSubview:numeroTextField];
        [cell addSubview:clearButton];
        
    }
    return cell;
}

- (void)clear: (id)sender
{
    numeroTextField.text = @"";
}



- (void)cancelar:(id)sender
{
    
    [self removerTela];
}

- (void)adicionar:(id)sender
{
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
    convenio.numero = [numberFormatter numberFromString:numeroTextField.text];
    ConvenioManager *manager = [ConvenioManager sharedInstance];
    
    [manager saveContext];
    
    [self removerTela];
}


- (void)removerTela
{
    [self.navigationController popViewControllerAnimated:YES];
    
    //chamando o método do NotificationCenter para atualizar a tableView
    [[NSNotificationCenter defaultCenter] postNotificationName:@"atualizarTableView" object:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
