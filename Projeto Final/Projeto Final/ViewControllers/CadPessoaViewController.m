//
//  CadPessoaViewController.m
//  Projeto Final
//
//  Created by Leonardo Felipe da Silva on 22/08/14.
//  Copyright (c) 2014 Mack Mobile - BEPiD. All rights reserved.
//

#import "CadPessoaViewController.h"
#import "BoxesCreatorViewController.h"
#import "BaseViewController.h"
#import "PessoaManager.h"
#import "NomeViewController.h"
#import "MMSobrenomeViewController.h"
#import "DataNascimentoViewController.h"
#import "SanguineoViewController.h"
#import "SexoViewController.h"
#import "ConvenioViewController.h"
#import "UIImage+ImageEffects.h"
#import "CoresPerfilViewController.h"
#import "AlergiaPessoaViewController.h"
#import "ListaAlergiasViewController.h"
#import "ListaConveniosViewController.h"

@interface CadPessoaViewController ()
{
    NSArray *itensHistoricoConvenio;
}
@end

@implementation CadPessoaViewController

UIDatePicker *nascimento;
UIView *dateFormatter;

@synthesize titulo, fundoTitulo, pessoa, TableView, dataNascimento, imgFotoBlur, imgFotoIcone;

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
    
    //Adicionando Botao salvar na view
    
    
    PessoaManager *pessoaManager = [PessoaManager sharedInstance];
    if (!pessoa) { //Adicionar Remédio
        pessoa = [pessoaManager criarPessoa];
        
        [self setTitle:@"Novo Perfil"];
        UIBarButtonItem *saveButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(adicionar:)];
        
        [[self navigationItem] setRightBarButtonItem:saveButton];
        UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelar:)];
        
        [[self navigationItem] setLeftBarButtonItem:cancelButton];
        
    } else { //Visualizar ou Editar o Remédio
        [self setTitle:pessoa.nome];
        
        //Botão de Salvar
        
    }

    //BLUR E FOTO
   
    
//    MMTapGestureRecognizer *tapGestureRecognizer = [[MMTapGestureRecognizer alloc] init];
//    tapGestureRecognizer.objeto = Foto;
//    [tapGestureRecognizer addTarget:self action:@selector(toqueImageView:)];
//    [Foto addGestureRecognizer:tapGestureRecognizer];
    
    
    UIView *viewTableView = [self criarView:0];
    
    //TABLEW VIEW

//    itensHistoricoConvenio = (NSArray *)[pessoa obterConvenios];
    
    TableView = [[UITableView alloc]init];
    [TableView setFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [TableView setDelegate:self];
    [TableView setDataSource:self];
    TableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    [viewTableView setFrame:CGRectMake(viewTableView.frame.origin.x, viewTableView.frame.origin.y, viewTableView.frame.size.width, viewTableView.frame.size.height + TableView.frame.size.height)];
    [viewTableView addSubview:TableView];
    
    [self setContentSizeScrollView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(atualizarImagemImageView:) name:@"atualizarImagemImageView" object:nil];
    

}

//- (void)dealloc {
//    [nascimento release];
//    [dateFormatter release];
//    [super dealloc];
//}
- (void)viewDidAppear:(BOOL)animated
{
    PessoaManager *pessoaManager = [PessoaManager sharedInstance];
//    itensHistorico = [pessoaManager obterConve];
    
    [TableView reloadData];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 3;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    
    if (section == 1) {
        
        return @"  ";
    }
    if (section == 2) {
        return @"";
    }
    return @"";
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    if (section == 2) {
        return 20.0;
    }
    if (section == 1) {
        return 0.0;
    }
        return 0.0;
}
- (CGFloat)tableView: (UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 170.0;
    }
    if (indexPath.section == 2){
        if (indexPath.row == 0){
            return 0.0;
            
        }else{
        return 0.0;
        }
    }
    return 40.0;
    
}


//- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    if (indexPath.section == 1)
//    if (indexPath.row == 0) {
//        return UITableViewCellEditingStyleNone;
//    }
//        return UITableViewCellEditingStyleDelete;
//    
//}
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCellEditingStyle editingStyle;
    if (indexPath.section == 0) {
        editingStyle = UITableViewCellEditingStyleNone;
    } else if (indexPath.section == 1) {
        editingStyle = UITableViewCellEditingStyleNone;
    } else if (indexPath.section == 2) {
        if (indexPath.row == 0) {
            editingStyle = UITableViewCellEditingStyleInsert;
        } else {
            editingStyle = UITableViewCellEditingStyleDelete;
        }
    }
    
    return editingStyle;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
    if (indexPath.row == 0) {
        NomeViewController *nomeViewController = [[NomeViewController alloc]initWithNibName:nil bundle:nil];
        //        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        nomeViewController.pessoa = pessoa;
        [[self navigationController] pushViewController:nomeViewController animated:YES];
        
    } else if (indexPath.row == 1){
        MMSobrenomeViewController *sobrenomeViewController = [[MMSobrenomeViewController alloc]initWithNibName:nil bundle:nil];
        //        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        sobrenomeViewController.pessoa = pessoa;
        [[self navigationController] pushViewController:sobrenomeViewController animated:YES];
        
    } else if (indexPath.row == 2){
        DataNascimentoViewController *viewController = [[DataNascimentoViewController alloc]initWithNibName:nil bundle:nil];
        viewController.pessoa = pessoa;
        [[self navigationController] pushViewController:viewController animated:YES];
    } else if (indexPath.row == 4){
        SanguineoViewController *viewController = [[SanguineoViewController alloc]initWithNibName:nil bundle:nil];
        viewController.pessoa = pessoa;
        [[self navigationController] pushViewController:viewController animated:YES];
    } else if (indexPath.row == 3){
        SexoViewController *viewController = [[SexoViewController alloc]initWithNibName:nil bundle:nil];
         viewController.pessoa = pessoa;
        [[self navigationController] pushViewController:viewController animated:YES];
    } else if (indexPath.row == 7){
        CoresPerfil *viewController = [[CoresPerfil alloc]initWithNibName:nil bundle:nil];
        viewController.pessoa = pessoa;
        [[self navigationController] pushViewController:viewController animated:YES];
    } else if (indexPath.row == 6){
        ListaConveniosViewController *viewController = [[ListaConveniosViewController alloc]initWithNibName:nil bundle:nil];
        viewController.convenio = convenio;
        [[self navigationController] pushViewController:viewController animated:YES];
    } else if (indexPath.row == 5){
        ListaAlergiasViewController *viewController = [[ListaAlergiasViewController alloc]initWithNibName:nil bundle:nil];
        viewController.alergia = alergia;
        [[self navigationController] pushViewController:viewController animated:YES];
    }
        //não faz nada
    }


}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger numRows = pessoa.convenios.count;
    // Return the number of rows in the section.
    switch (section) {
        case 0:
            return 1;
            break;
        case 1:
            return 8; //of rows in section;
            break;
        case 2:
            ;
            return 0;
            break;
    }
    return 0;
}

- (UITableViewCell *)tableView: (UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString *CellIdentifier = nil;
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    }
    // Configure the cell...
    [cell setBackgroundColor: [UIColor clearColor]];
    
    
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    if (indexPath.section == 0 && indexPath.row == 0) {
        UIView *viewFoto = [[UIView alloc] init];
        [viewFoto setFrame:CGRectMake(0, 0, cell.frame.size.width, 170)];
        
        imgFotoBlur = [self criarImageViewBlurNaView:viewFoto];
        imgFotoIcone = [self criarImageViewIconeNaView:viewFoto];
        
        imgFotoIcone.image = [UIImage imageWithData:pessoa.foto];
        imgFotoBlur.image = [imgFotoIcone.image applyLightEffect];
        [imgFotoBlur setUserInteractionEnabled:YES]; //para reconhecer o toque (GestureRecognizer)
        
        MMTapGestureRecognizer *tapGestureRecognizer = [[MMTapGestureRecognizer alloc] init];
        tapGestureRecognizer.objeto = imgFotoIcone;
        [tapGestureRecognizer addTarget:self action:@selector(toqueImageView:)];
        [viewFoto addGestureRecognizer:tapGestureRecognizer];
        [[cell contentView] addSubview:viewFoto];

        [cell setAccessoryType:UITableViewCellAccessoryNone];

    }
    if (indexPath.section == 1) {
       if(indexPath.row == 0){
           NSString *title = @"Nome";
           [[cell textLabel] setText:title];
           
           [[cell detailTextLabel] setText:pessoa.nome];
           
           cell.textLabel.textColor = [UIColor colorWithRed:84/255.0f green:84/255.0f blue:84/255.0f alpha:1];
           cell.textLabel.highlightedTextColor = [UIColor whiteColor];
       }
        if(indexPath.row == 1){
            NSString *title = @"Sobrenome";
            [[cell textLabel] setText:title];
            [[cell detailTextLabel] setText:pessoa.sobrenome];
            cell.textLabel.textColor = [UIColor colorWithRed:84/255.0f green:84/255.0f blue:84/255.0f alpha:1];
            cell.textLabel.highlightedTextColor = [UIColor whiteColor];
        }
        if(indexPath.row == 2){
            NSString *title = @"Nascimento";
            [[cell textLabel] setText:title];
            NSDateFormatter *dateFormatter;
            dateFormatter = [MMNSDateFormater criarDateFormatter];
            
            dataNascimento = [NSString stringWithFormat:@"%@",
                              [dateFormatter stringFromDate:pessoa.dNascimento]];
            
            
            [[cell detailTextLabel] setText:dataNascimento];
            if (pessoa.dNascimento == nil) {
                NSDateFormatter *dateFormatter2;
                dateFormatter2 = [MMNSDateFormater criarDateFormatter];
                
                [[cell detailTextLabel] setText: [NSString stringWithFormat:@"%@",
                                      [dateFormatter2 stringFromDate:[NSDate date]]]];
            }
            cell.textLabel.textColor = [UIColor colorWithRed:84/255.0f green:84/255.0f blue:84/255.0f alpha:1];
            cell.textLabel.highlightedTextColor = [UIColor whiteColor];
        }
        if(indexPath.row == 3){
            NSString *title = @"Sexo";
            
            [[cell textLabel] setText:title];
            [[cell detailTextLabel] setText:pessoa.sexo];
            cell.textLabel.textColor = [UIColor colorWithRed:84/255.0f green:84/255.0f blue:84/255.0f alpha:1];
            cell.textLabel.highlightedTextColor = [UIColor whiteColor];
        }
        if(indexPath.row == 4){
            NSString *title = @"Tipo Sanguineo";
            
            [[cell textLabel] setText:title];
            [[cell detailTextLabel] setText:pessoa.tipoSanguineo];
            cell.textLabel.textColor = [UIColor colorWithRed:84/255.0f green:84/255.0f blue:84/255.0f alpha:1];
            cell.textLabel.highlightedTextColor = [UIColor whiteColor];
        }
        if(indexPath.row == 5){
            NSString *title = @"Alergias";
            
            [[cell textLabel] setText:title];
            [[cell detailTextLabel] setText:@"Lista de alergias"];
            cell.textLabel.textColor = [UIColor colorWithRed:84/255.0f green:84/255.0f blue:84/255.0f alpha:1];
            cell.textLabel.highlightedTextColor = [UIColor whiteColor];
        }
        if(indexPath.row == 6){
            NSString *title = @"Convênios";
            
            [[cell textLabel] setText:title];
            [[cell detailTextLabel] setText:@"Lista de Convênios"];
            cell.textLabel.textColor = [UIColor colorWithRed:84/255.0f green:84/255.0f blue:84/255.0f alpha:1];
            cell.textLabel.highlightedTextColor = [UIColor whiteColor];
        }
        if(indexPath.row == 7){
            NSString *title = @"Cor Perfil";
            UIImageView *imagemtest = [[UIImageView alloc]init];
            
            
            [[cell textLabel] setText:title];
//            [[cell detailTextLabel] setText:[NSString stringWithFormat:@"%@",pessoa.cor]];
            
            imagemtest.layer.backgroundColor = ((UIColor *)pessoa.cor).CGColor;
            
            [imagemtest setFrame:CGRectMake(270, 10, 20, 20)];
            
            [imagemtest sizeThatFits:CGSizeMake(20, 20)];
            
            imagemtest.layer.borderWidth = 2.0f;
            
            
            imagemtest.layer.borderColor = [UIColor whiteColor].CGColor;
            
            imagemtest.layer.masksToBounds = NO;
            
            imagemtest.layer.cornerRadius = 10;
            
            imagemtest.clipsToBounds = YES;
            
            
            
            if (pessoa.cor == nil) {
                [[cell detailTextLabel] setText:@"Não possui cor"];
            }else{
                [[cell contentView] addSubview:imagemtest];
            }
            
            
            cell.textLabel.textColor = [UIColor colorWithRed:84/255.0f green:84/255.0f blue:84/255.0f alpha:1];
            cell.textLabel.highlightedTextColor = [UIColor whiteColor];
        }
        }else if(indexPath.section == 2){
        NSString *title = @"Convênios";
        [[cell textLabel] setText:title];
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        if (indexPath.row == 0) {
            
//            [cell setBackgroundColor:[UIColor whiteColor]];
            
            [[cell imageView] setImage:nil];
//            [[cell textLabel] setBackgroundColor:[UIColor redColor]];
            [[cell textLabel] setText:@"                +                          "];
            [[cell textLabel] setTextAlignment:NSTextAlignmentCenter];
            [[cell textLabel] setTextColor:[UIColor colorWithRed:84/255.0f green:84/255.0f blue:84/255.0f alpha:1]];
//            [[cell textLabel] setBackgroundColor:[UIColor clearColor]];
//            [[cell textLabel] setFont:[UIFont boldSystemFontOfSize:14]];
            [cell setAccessoryType:UITableViewCellAccessoryNone];
            
        }
        if (indexPath.row > 0){
            Convenio *convenio = [pessoa.convenios objectAtIndex:indexPath.row-1];
            [[cell textLabel] setText:convenio.nome];
//            [[cell detailTextLabel] setText:convenio.numero];
            [[cell detailTextLabel] setText:convenio.plano];
            cell.textLabel.textColor = [UIColor colorWithRed:84/255.0f green:84/255.0f blue:84/255.0f alpha:1];
            cell.textLabel.highlightedTextColor = [UIColor whiteColor];

            
        }
    }


    return cell;


}
- (void)changeDateInLabel:(id)sender{
    //Use NSDateFormatter to write out the date in a friendly format
     UILabel *text;
    NSDateFormatter *NSDateFormatter = [MMNSDateFormater criarDateFormatter];
    text.text = [NSString stringWithFormat:@"%@",
                 [NSDateFormatter stringFromDate:nascimento.date]];
    [self DatePickerLabel:text];
    
    
    
}

- (void)cancelar:(id)sender
{
    
    PessoaManager *manager = [PessoaManager sharedInstance];
    [manager deletarPessoa:pessoa];

    [self removerTela];
}

- (void)adicionar:(id)sender
{
    
    PessoaManager *manager = [PessoaManager sharedInstance];
    
    [manager saveContext];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"atualizarViewPerfisNavigation" object:nil];
    
    [self removerTela];
}

- (void)removerTela
{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    
    //chamando o método do NotificationCenter para atualizar a tableView
     [[NSNotificationCenter defaultCenter] postNotificationName:@"atualizarTableView" object:nil];
}
                          
                          
                          
                          

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)toqueBotaoConvenio:(id)sender
{
//    MMTapGestureRecognizer *tapGestureRecognizerComObjeto = (MMTapGestureRecognizer *)sender;
//    id objeto = tapGestureRecognizerComObjeto.objeto;
//    
//    if([objeto isKindOfClass:[UIView class]]){
//        UIView *view = (UIView *)objeto;
//        UIView *viewConvenio;
//    viewConvenio = [self criarBotaoAdicionarComTexto:@"Novo Convênio"];
//    [TableView addSubview:viewConvenio];
//    [TableView setContentSize:CGSizeMake(TableView.frame.size.width, posicaoYPegaValor+50)];
//        NSLog(@"Posicao y %d", posicaoYPegaValor );
//}
}
- (void)atualizarImagemImageView:(NSNotification *)notification {
    UIImageView *imageView = (UIImageView *)notification.object;
    
    if ([imageView isEqual:imgFotoIcone]) {
        imgFotoIcone.image = imageView.image;
        imgFotoBlur.image = [imageView.image applyLightEffect];
        
        NSData *foto = UIImageJPEGRepresentation(imgFotoIcone.image, 1.0);
        pessoa.foto = foto;
        //        NSLog(@"%lu %lu", (unsigned long)remedio.foto.length, (unsigned long)foto.length);
    }
}
- (void)toqueScrolDataView:(id)sender
{
    MMTapGestureRecognizer *tapGestureRecognizerComObjeto = (MMTapGestureRecognizer *)sender;
    id objeto = tapGestureRecognizerComObjeto.objeto;
   
    if([objeto isKindOfClass:[UIView class]]){
        UIView *view = (UIView *)objeto;
        
        
        nascimento = [self criarDatePickerNascimento];
//    [dateFormatter inputView:nascimento];
        [TableView addSubview:nascimento];
        
        [nascimento addTarget:self
                       action:@selector(changeDateInLabel:)
             forControlEvents:UIControlEventValueChanged];
      
    }
}




@end
