//
//  SintomasDaOcorViewController.m
//  Projeto Final
//
//  Created by Leonardo Felipe da Silva on 10/10/14.
//  Copyright (c) 2014 Mack Mobile - BEPiD. All rights reserved.
//

#import "SintomasDaOcorViewController.h"

@interface SintomasDaOcorViewController ()

@end

@implementation SintomasDaOcorViewController

@synthesize textView, ocorrencia;

- (id)initWithOcorrencia
{
    [self carregarItens];
    return [super init];
}

- (void)carregarItens
{
    [self setTitle:@"Descrição de Sintomas"];
    UIBarButtonItem *salvar = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(adicionar:)];
    [[self navigationItem] setRightBarButtonItem:salvar];
    
    
//    [[self navigationItem] setLeftBarButtonItem:cancelButton];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self carregarItens];
    
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
        return self.view.frame.size.height - (320);
    }
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 300;
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
        textView = [[UITextView alloc]initWithFrame:CGRectMake(10, 0, self.view.frame.size.width-20, 300)];
//        textView.borderStyle = UITextBorderStyleNone;
        textView.returnKeyType = UIReturnKeyDone;
        //        [textField setDelegate:self];
        [cell addSubview:textView];
    }
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)cancelar:(id)sender
{
    
    [self removerTela];
}

- (void)adicionar:(id)sender
{
    ocorrencia.sintomas = textView.text;
    OcorrenciaManager *manager = [OcorrenciaManager sharedInstance];
    [manager saveContext];
    [self removerTela];
}
- (void)removerTela
{
    [[self navigationController] popViewControllerAnimated:YES];
    
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
