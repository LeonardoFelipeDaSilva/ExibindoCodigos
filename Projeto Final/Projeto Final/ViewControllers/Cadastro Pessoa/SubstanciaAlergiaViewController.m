//
//  SubstanciaAlergiaViewController.m
//  Projeto Final
//
//  Created by Leonardo Felipe da Silva on 11/17/14.
//  Copyright (c) 2014 Mack Mobile - BEPiD. All rights reserved.
//

#import "SubstanciaAlergiaViewController.h"
#import "AlergiaPerfilManager.h"

@interface SubstanciaAlergiaViewController ()

@end

@implementation SubstanciaAlergiaViewController

@synthesize subsTextField, tableViewSubs, alergia, clearButton;

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
    
    [self setTitle:@"Substancia"];
    tableViewSubs = [[UITableView alloc]init];
    [tableViewSubs setFrame:CGRectMake(self.view.window.bounds.origin.x, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [tableViewSubs setDelegate:self];
    [tableViewSubs setDataSource:self];
    
    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(adicionar:)];
    
    [[self navigationItem] setRightBarButtonItem:saveButton];
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelar:)];
    
    [[self navigationItem] setLeftBarButtonItem:cancelButton];
    
    UIView *viewTableView = [self criarView:0];
    [viewTableView setFrame:CGRectMake(viewTableView.frame.origin.x, viewTableView.frame.origin.y, viewTableView.frame.size.width, viewTableView.frame.size.height + tableViewSubs.frame.size.height)];
    [viewTableView addSubview:tableViewSubs];
    
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
        subsTextField = [MMTextField criarObjeto:CGRectMake(10, 0, self.view.frame.size.width-60, 30)];
        subsTextField.borderStyle = UITextBorderStyleNone;
        subsTextField.returnKeyType = UIReturnKeyDone;
        [subsTextField setDelegate:self];
        clearButton = [[UIButton alloc]init];
        clearButton.frame = CGRectMake(subsTextField.frame.origin.x + subsTextField.frame.size.width + 5, 2.5, 25, 25);
        [clearButton addTarget:self action:@selector(clear:) forControlEvents:UIControlEventTouchDown];
        [clearButton setImage:[UIImage imageNamed:@"borracha_branco.png"] forState:UIControlStateNormal];
        clearButton.layer.cornerRadius = 13;
        if (self.navigationController.navigationBar.barTintColor == nil) {
            clearButton.backgroundColor = [UIColor grayColor];
        }else{
        clearButton.backgroundColor = self.navigationController.navigationBar.barTintColor;
        }
        subsTextField.text = alergia.substancia;
        
        [cell addSubview:clearButton];
        [cell addSubview:subsTextField];
        
    }
    return cell;
}

- (void)clear: (id)sender
{
    subsTextField.text = @"";
}

- (void)cancelar:(id)sender
{
    
    [self removerTela];
}

- (void)adicionar:(id)sender
{
    alergia.substancia = subsTextField.text;
    AlergiaPerfilManager *manager = [AlergiaPerfilManager sharedInstance];
    
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
