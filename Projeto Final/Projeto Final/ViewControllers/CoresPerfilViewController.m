//
//  CoresPerfil.m
//  CoresPerfil
//
//  Created by Adriana Yuri on 10/09/14.
//  Copyright (c) 2014 Adriana. All rights reserved.
//

#import "CoresPerfilViewController.h"

@interface CoresPerfil (){
    NSArray *listaCell;
}

@end

@implementation CoresPerfil
@synthesize pessoa, pessoaCor;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    [self setTitle:@"Cores Perfil"];
//    UIBarButtonItem *barButtonAddPerfil = [[UIBarButtonItem alloc] initWithTitle:@"Perfil" style:UIBarButtonItemStylePlain target:self action: @selector (adicionarPerfil:)];
//    [[self navigationItem] setRightBarButtonItem:barButtonAddPerfil];
    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(adicionar:)];
    
    [[self navigationItem] setRightBarButtonItem:saveButton];
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelar:)];
    
    [[self navigationItem] setLeftBarButtonItem:cancelButton];
    
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    self.tableView.backgroundColor = [UIColor whiteColor];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    // Return the number of sections.
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    // Return the number of rows in the section.
    if (section == 0){
        return 1;
    }
   else{
        return 7;
}
}

int y = 0;
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell= [[UITableViewCell alloc]init];
    
    if (indexPath.row == 0 && indexPath.section == 0){
        
    } else if (indexPath.section == 1) {
        UIColor *cor = [self corDaPosicao:indexPath.row];
        cell = [self criarCellwithCor:cor];
    }
    
    return cell;
}

- (CGFloat)tableView: (UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 5;
    }
    else
    return 40.0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    UIImage *check = [[UIImage alloc]initWithCGImage:(__bridge CGImageRef)([UIImage imageNamed:@"checkboxmark.png"])];
    for (int secao=0; secao<tableView.numberOfSections; secao++) {
        for (int linha=0; linha<[tableView numberOfRowsInSection:secao]; linha++) {
            //                NSLog(@"S %d L %d", secao, linha);
            [[tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:linha inSection:secao]] setAccessoryType:UITableViewCellAccessoryNone];
        }
    }
    [[tableView cellForRowAtIndexPath:indexPath] setSelectionStyle:UITableViewCellSelectionStyleNone];
    [[tableView cellForRowAtIndexPath:indexPath] setAccessoryType:UITableViewCellAccessoryCheckmark];
    tableView.tintColor = [UIColor whiteColor];
    
    pessoaCor = [self corDaPosicao:indexPath.row];
}
   
    
- (void)selBtnDone:(id)sender
{
    [self salvar];
    [[self navigationController] popViewControllerAnimated:YES];
}
- (void)salvar
{
    pessoa.cor = pessoaCor;
    
}



// Override to support conditional editing of the table view.
//- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    // Return NO if you do not want the specified item to be editable.
//    return YES;
//}


/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
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
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - método para criar célula
-(UITableViewCell *)criarCellwithCor:(UIColor*)cor{
    UITableViewCell *cell = [[UITableViewCell alloc]init];
    
    [cell setBackgroundColor: [UIColor colorWithRed:255/255.0f green:255/255.0f blue:255/255.0f alpha:0.0]];
    
    UIImageView *imagemtest = [[UIImageView alloc]init];
    
   [imagemtest setFrame:CGRectMake(10, 5, 300, 30)];
    
//    [imagemtest sizeThatFits:CGSizeMake(50, 50)];
    
    imagemtest.layer.borderWidth = 0.0f;
    
//    imagemtest.layer.borderColor = [UIColor grayColor].CGColor;
    
    imagemtest.layer.backgroundColor = cor.CGColor;
    
//    imagemtest.layer.masksToBounds = NO;
    
    imagemtest.layer.cornerRadius = 7;
    
//    imagemtest.clipsToBounds = YES;
    
    [[cell contentView] addSubview:imagemtest];
    

    return cell;
}

- (UIColor *)corDaPosicao:(NSInteger)posicao {
    UIColor *cor;
    
    if (posicao == 0) {
        cor = [UIColor colorWithRed:255/255.0f green:255/255.0f blue:0/255.0f alpha:1.0]; //azul
        
    } else if (posicao == 1){
        cor = [UIColor colorWithRed:27/255.0f green:106/255.0f blue:84/255.0f alpha:1.0]; //verdeFluorescente
        
    } else if (posicao == 2) {
        cor = [UIColor colorWithRed:58/255.0f green:254/255.0f blue:52/255.0f alpha:1.0]; //verdeClaro
    } else if (posicao == 3){
        cor = [UIColor colorWithRed:255/255.0f green:124/255.0f blue:0/255.0f alpha:1.0]; //laranja
        
    } else if (posicao == 4){
        cor = [UIColor colorWithRed:255/255.0f green:11/255.0f blue:106/255.0f alpha:1.0]; //vermelho
    } else if (posicao == 5){
        cor = [UIColor colorWithRed:151/255.0f green:0/255.0f blue:255/255.0f alpha:1.0]; //violeta
        
    } else if (posicao == 6){
        cor = [UIColor colorWithRed:54/255.0f green:24/255.0f blue:84/255.0f alpha:1.0]; //roxo
    }
    
    return cor;
}


- (void)cancelar:(id)sender
{
    
    [self removerTela];
}

- (void)adicionar:(id)sender
{
    pessoa.cor = pessoaCor;
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


-(UITableViewCell *)criarCellVazia{
    UITableViewCell *cell = [[UITableViewCell alloc]init];
      [cell setBackgroundColor: [UIColor colorWithRed:255/255.0f green:255/255.0f blue:255/255.0f alpha:0.0]];
    
    return cell;
}
@end
