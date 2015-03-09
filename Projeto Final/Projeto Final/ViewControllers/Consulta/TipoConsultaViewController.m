//
//  TipoConsultaViewController.m
//  Projeto Final
//
//  Created by Leonardo Felipe da Silva on 12/7/14.
//  Copyright (c) 2014 Mack Mobile - BEPiD. All rights reserved.
//

#import "TipoConsultaViewController.h"

@interface TipoConsultaViewController ()

@end

@implementation TipoConsultaViewController

@synthesize consulta, textField, clearButton;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [super viewDidLoad];
    
    [self setTitle:@"Tipo da Consulta"];
    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(adicionar:)];
    
    [[self navigationItem] setRightBarButtonItem:saveButton];
    
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelar:)];
    
    [[self navigationItem] setLeftBarButtonItem:cancelButton];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 20.0;
    }
    if (section == 1) {
        return self.view.frame.size.height - (50);
    }
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 30;
    }
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"celula";
    UITableViewCell *cell = [tableView dequeueReusableHeaderFooterViewWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    [cell setAccessoryType:UITableViewCellAccessoryNone];
    if(indexPath.section == 0)
    {
        textField = [MMTextField criarObjeto:CGRectMake(10, 0, self.view.frame.size.width-60, 30)];
        textField.borderStyle = UITextBorderStyleNone;
        textField.returnKeyType = UIReturnKeyDone;
        //        [textField setDelegate:self];
        
        clearButton = [[UIButton alloc]init];
        clearButton.frame = CGRectMake(textField.frame.origin.x + textField.frame.size.width + 5, 2.5, 25, 25);
        [clearButton addTarget:self action:@selector(clear:) forControlEvents:UIControlEventTouchDown];
        [clearButton setImage:[UIImage imageNamed:@"borracha_branco.png"] forState:UIControlStateNormal];
        clearButton.layer.cornerRadius = 13;
        if (self.navigationController.navigationBar.barTintColor == nil) {
            clearButton.backgroundColor = [UIColor grayColor];
        }else{
            clearButton.backgroundColor = self.navigationController.navigationBar.barTintColor;
        }
        textField.text = consulta.titulo;
        
        [cell addSubview:clearButton];
        [cell addSubview:textField];
    }
    return cell;
}

- (void)clear: (id)sender
{
    textField.text = @"";
}


- (void)cancelar:(id)sender
{
    
    [self removerTela];
}

- (void)adicionar:(id)sender
{
    consulta.titulo = textField.text;
    ConsultaManager *manager = [ConsultaManager sharedInstance];
    [manager saveContext];
    [self removerTela];
}
- (void)removerTela
{
    [[self navigationController] popViewControllerAnimated:YES];
    
    //chamando o método do NotificationCenter para atualizar a tableView
    [[NSNotificationCenter defaultCenter] postNotificationName:@"atualizarTableView" object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
