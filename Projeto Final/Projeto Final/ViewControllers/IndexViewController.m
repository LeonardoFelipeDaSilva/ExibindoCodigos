//
//  IndexViewController.m
//  Projeto Final
//
//  Created by Leonardo Felipe da Silva on 22/08/14.
//  Copyright (c) 2014 Mack Mobile - BEPiD. All rights reserved.
//

#import "IndexViewController.h"
#import "CadPessoaViewController.h"
#import "RemedioViewController.h"
#import "ListaRemedioViewController.h"
#import "ListaPerfilViewController.h"
#import "IndexManager.h"
#import "MMLongPressGestureRecognizer.h"
#import "MMTapGestureRecognizer.h"
#import "ListaVacinaViewController.h"
#import "VacinaViewController.h"
#import "HistoricoRem.h"
#import "HistoricoVacina.h"
#import "HistoricoDeOcorrenciaViewController.h"
#import "ListaPrescricaoViewController.h"
#import "ListaPerfilViewController.h"
#import "Pessoa.h"
#import "PessoaManager.h"
#import "HelpViewController.h"
#import "UIImage+ImageEffects.h"
#import "Exame.h"
#import "ListaExamesTableViewController.h"
#import "ListaConsultaViewController.h"

@interface IndexViewController (){
    UILabel *topLabel;
	UILabel *bottomLabel;
    UILabel *bodyLabel1;
    UILabel *bodyLabel2;
    UILabel *bodyLabel3;
    NSMutableArray *cellIndex;
    IndexManager *lista;
    NSArray *itensLista;
    NSMutableArray *listaHistRem;
    NSMutableArray *listaHistVac;
    NSMutableArray *listaHistAler;
    NSMutableArray *listaEventos;
    NSMutableArray *tableViewItens;
    UIScrollView *viewPerfisNavigation;
    
   
}
@end

@implementation IndexViewController
@synthesize tabBar, principal, data, viewLabel, imagemViewLabel;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
//        self.tabBarItem.image = [UIImage imageNamed:@"home153.png"];
       
            UIImage *image = [UIImage imageNamed:@"home_line_2.png"];
            self.tabBarItem.image = [self imageWithImage:image scaledToSize:CGSizeMake(30, 30)];
        
            UIImage *imageSelect = [UIImage imageNamed:@"home_color_2.png"];
            self.tabBarItem.selectedImage = [self imageWithImage:imageSelect scaledToSize:CGSizeMake(30, 30)];
//            [[UITabBar appearance] setSelectedImageTintColor:[UIColor clearColor]];

        
        // Custom initialization
    }
    return self;
}
- (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize {
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.tabBarController.tabBar setBackgroundColor:[UIColor colorWithRed:4 green:36 blue:69 alpha:1.0]];
   
    // Do any additional setup after loading the view.
    
  
    
//    UIBarButtonItem *barButtonAddPerfil = [[UIBarButtonItem alloc] initWithTitle:@"Perfil" style:UIBarButtonSystemItemFastForward target:self action: @selector (adicionarPerfil:)];
//    [[self navigationItem] setLeftBarButtonItem:barButtonAddPerfil];
    
//    
//    UIImage *listaImage = [UIImage imageNamed:@"configuracao.png"];
//    UIBarButtonItem *barButtonList = [[UIBarButtonItem alloc] initWithImage:listaImage style:UIBarButtonItemStylePlain target:self action:@selector(configurar:)];
//    [[ [self tabBarController] navigationItem] setRightBarButtonItem: barButtonList];
    
//    [[[self tabBarController] navigationItem] setRightBarButtonItem: barButtonLife];
    

    [self criarViewPerfisNavigation];
    viewLabel = [[UILabel alloc]init];
    viewLabel.frame = CGRectMake(self.view.frame.origin.x + 20, 40, 80, 70);
//    viewLabel.backgroundColor = [UIColor blackColor];
    UIImage *imagemLabel = [UIImage imageNamed:@"hoje"];
    imagemViewLabel = [[UIImageView alloc]initWithImage:imagemLabel];
    imagemViewLabel.frame = CGRectMake(0, 0, 70, 70);
    NSDateFormatter *dateFormatter;
    dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setDateFormat:@"dd "];
    data = [[UILabel alloc]init];
    data.frame = CGRectMake(0, 30, 70, 60);
    data.textAlignment = NSTextAlignmentCenter;
    data.textColor = [UIColor whiteColor];
//    data.backgroundColor = [UIColor colorWithPatternImage:imagemViewLabel];
    
    data.text = [NSString stringWithFormat:@"%@",
                 [dateFormatter stringFromDate:[NSDate date]]];
    data.textAlignment = NSTextAlignmentCenter;
    
    [viewLabel addSubview:imagemViewLabel];
    [viewLabel addSubview:data];


    self.view.backgroundColor = [UIColor colorWithRed:84/255.0f green:84/255.0f blue:84/255.0f alpha:1];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    lista = [[IndexManager alloc] init];
    itensLista = [lista obterListaIndex];
    
    UILongPressGestureRecognizer *recognizerlong = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longTap:)];
    recognizerlong.delegate = self;
    
    [self.tableView addGestureRecognizer:recognizerlong];
    
    //NOTIFICATION PARA ATUALIZAR A VIEW DE PERFIS DA NAVIGATION
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(atualizarViewPerfisNavigation:) name:@"atualizarViewPerfisNavigation" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(atualizarViewLembretesIndex:) name:@"atualizarViewLembretesIndex" object:nil];
    
//    NSLog(@"%@", [[NSBundle mainBundle] bundlePath]);
//    self.tableView.editing = YES;
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.tableView reloadData];
}

- (void)atualizarViewPerfisNavigation:(id)sender {
    [viewPerfisNavigation removeFromSuperview];
    
    [self criarViewPerfisNavigation];
}
- (void)atualizarViewLembretesIndex:(id)sender {
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationAutomatic];
}

- (void)criarViewPerfisNavigation {
    viewPerfisNavigation = [[UIScrollView alloc] init];
    [viewPerfisNavigation setFrame:CGRectMake(0, 0, 190, 40)];
    
    PessoaManager *pessoaManager = [PessoaManager sharedInstance];
    NSArray *listaPessoa = [pessoaManager obterUsuarios];
    double x = 0;
    double y = 2;
    int totalLarguraBolinhas = listaPessoa.count*36 + (listaPessoa.count-1)*10;
    
    if (totalLarguraBolinhas > viewPerfisNavigation.frame.size.width) {
        [viewPerfisNavigation setContentSize:CGSizeMake(totalLarguraBolinhas, viewPerfisNavigation.frame.size.height)];
    } else {
        [viewPerfisNavigation setContentSize:CGSizeMake(viewPerfisNavigation.frame.size.width, viewPerfisNavigation.frame.size.height)];
    }
    
    x = (viewPerfisNavigation.contentSize.width - totalLarguraBolinhas)/2;
    
    [viewPerfisNavigation setContentOffset:CGPointMake((viewPerfisNavigation.contentSize.width-viewPerfisNavigation.frame.size.width)/2, 0)];
    
    for (int i=0; i<listaPessoa.count; i++) {
        UIImageView *viewBolinha = [[UIImageView alloc] init];
        Pessoa *pessoa = [listaPessoa objectAtIndex:i];
        
        NSMutableDictionary *perfilItens = [[NSMutableDictionary alloc] init];
        [perfilItens setObject:viewBolinha forKey:@"view"];
        [perfilItens setObject:pessoa forKey:@"pessoa"];
        
        [viewBolinha setFrame:CGRectMake(x, y, 36, 36)];
        viewBolinha.layer.borderWidth = 3.0f;
        viewBolinha.layer.cornerRadius = 18;
        viewBolinha.layer.masksToBounds = YES;
        
        x = x+36+10;
        
        //reconhecer os toques nesta view
        [viewBolinha setUserInteractionEnabled:YES];
        
        MMTapGestureRecognizer *toque = [[MMTapGestureRecognizer alloc] init];
        toque.objeto = perfilItens;
        [toque addTarget:self action:@selector(selecionarPerfil:)];
        [viewBolinha addGestureRecognizer:toque];
        
        MMLongPressGestureRecognizer *toqueLongo = [[MMLongPressGestureRecognizer alloc] init];
        toqueLongo.objeto = pessoa;
        [toqueLongo addTarget:self action:@selector(exibirPerfil:)];
        [viewBolinha addGestureRecognizer:toqueLongo];
        
        [self atualizarViewPerfilNavigation:perfilItens];
        
        [viewPerfisNavigation addSubview:viewBolinha];
    }
}

- (void)selecionarPerfil:(id)sender {
    MMTapGestureRecognizer *tapGesture = (MMTapGestureRecognizer *)sender;
    
    NSDictionary *perfilItens = (NSDictionary *)tapGesture.objeto;
    
    Pessoa *pessoa = [perfilItens objectForKey:@"pessoa"];
    
    pessoa.ativo = [NSNumber numberWithBool:![pessoa.ativo boolValue]];
    
    PessoaManager *manager = [PessoaManager sharedInstance];
    [manager saveContext];
    
    [self atualizarViewPerfilNavigation:perfilItens];
    
//    UIAlertView *msg = [[UIAlertView alloc] initWithTitle:@"TOCOU" message:[NSString stringWithFormat:@"%@ %@", pessoa.nome, pessoa.sobrenome] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
//    [msg show];
}
- (void)exibirPerfil:(id)sender {
    MMLongPressGestureRecognizer *tapGesture = (MMLongPressGestureRecognizer *)sender;
    
    if (tapGesture.state == UIGestureRecognizerStateBegan) {
        Pessoa *pessoa = tapGesture.objeto;
        
        CadPessoaViewController *pessoaViewController = [[CadPessoaViewController alloc] init];
        pessoaViewController.pessoa = pessoa;
        
        [[self navigationController] pushViewController:pessoaViewController animated:YES];
    }
}
- (void)atualizarViewPerfilNavigation:(NSDictionary *)perfilItens
{
    Pessoa *pessoa = [perfilItens objectForKey:@"pessoa"];
    UIImageView *view = [perfilItens objectForKey:@"view"];
    
    NSLog(@"Perfil: %@ %@ - %@", pessoa.nome, pessoa.sobrenome, pessoa.ativo);
    
    UIImage *imagem = [[UIImage alloc] initWithData:pessoa.foto];
    
    if ([pessoa.ativo boolValue]) {
        view.layer.borderColor = ((UIColor *)pessoa.cor).CGColor;
        view.image = imagem;
        NSLog(@"ATIVADO");
    } else {
        view.layer.borderColor = [UIColor grayColor].CGColor;
        view.image = [imagem applyDarkEffect];
        NSLog(@"DESATIVADO");
    }
}

-(void)viewDidAppear:(BOOL)animated
{
    UIBarButtonItem *barButtonLife = [[UIBarButtonItem alloc] initWithTitle:@" LiFE  " style:UIBarButtonItemStylePlain target:nil action:@selector(exibirHelp:)];
    [[[self tabBarController] navigationItem] setLeftBarButtonItem: barButtonLife];
    
//    UIImage *listaPessoa1 = [UIImage imageNamed:@"listaPessoa.png"];
//    
//    UIBarButtonItem *barButtonList = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(listarPerfil:)];
    
    [[[self tabBarController] navigationItem] setRightBarButtonItem: nil];
    
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:15/255.0f green:174/255.0f blue:255/255.0f alpha:1]];
    
    [[[self tabBarController] navigationItem] setTitleView:viewPerfisNavigation];
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
//    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if (section == 0) {
        return nil;
    }else{
    return itensLista.count;
    }
}

- (UITableViewCell *)tableView: (UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //criando Celula na tableView
    UITableViewCell *cell;
  
    if (indexPath.section == 0 ) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        
    } else {
        //Colocar o texto na celula com descricao do item
        Index *itemLista = [itensLista objectAtIndex:indexPath.row];
        NSString *itemListaString = itemLista.item;
        
        if ([itemListaString isEqualToString:@"LEMBRETES"]) {
            cell =[self criarCellwithTitulo:@"LEMBRETES" evento1:@" " evento2:@" " evento3:@" "];
            
        } else if ([itemListaString isEqualToString:@"CONSULTAS"]) {
            cell =[self criarCellwithTitulo:@"CONSULTAS" evento1:@" " evento2:@" " evento3:@" "];
            
        } else if ([itemListaString isEqualToString:@"EXAMES"]) {
            cell =[self criarCellwithTitulo:@"EXAMES" evento1:@" " evento2:@" " evento3:@" "];
            
        } else if ([itemListaString isEqualToString:@"OCORRÊNCIAS"]) {
            cell =[self criarCellwithTitulo:@"OCORRÊNCIAS" evento1:@" " evento2:@" " evento3:@" "];
        } else if ([itemListaString isEqualToString:@"PRESCRIÇÕES"]) {
            cell =[self criarCellwithTitulo:@"PRESCRIÇÕES" evento1:@" " evento2:@" " evento3:@" "];
        } else if ([itemListaString isEqualToString:@"REMÉDIOS"]) {
            cell =[self criarCellwithTitulo:@"REMÉDIOS" evento1:@" " evento2:@" " evento3:@" "];
        } else if ([itemListaString isEqualToString:@"VACINAS"]) {
            cell =[self criarCellwithTitulo:@"VACINAS" evento1:@" " evento2:@" " evento3:@" "];
        } else {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        }
        
        MMTapGestureRecognizer *recognizer = [[MMTapGestureRecognizer alloc] init];
        recognizer.numberOfTapsRequired = 1;
        recognizer.delegate = self;
        recognizer.objeto = indexPath;
        [recognizer addTarget:self action:@selector(onTap:)];
        [cell addGestureRecognizer: recognizer];
        [cell setBackgroundColor:itemLista.corCell];
        [cell setUserInteractionEnabled:YES];
    }
    
    return cell;
}

- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UITableViewCell *cell;
    
    
    if (section == 0) {
//        
//         cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
//        PessoaManager *pessoaManager = [PessoaManager sharedInstance];
//        cell.layer.borderWidth = 0.0f;
//         NSArray *listaPessoa = [pessoaManager obterUsuarios];
//        double x = 0;
//        double y = 2;
//        int totalLarguraBolinhas = listaPessoa.count*36 + (listaPessoa.count-1)*10;
//        x = (cell.frame.size.width - totalLarguraBolinhas)/2;
//        
//       
//        
//        for (int i=0; i<listaPessoa.count; i++) {
        
            
//            UIImageView *bolinha = [[UIImageView alloc] init];
//            Pessoa *pessoa = [listaPessoa objectAtIndex:i];
//            UIImage *imagem = [[UIImage alloc]initWithData: pessoa.foto ];
//            
//            bolinha.tintColor = [pessoaManager corDaPessoa: pessoa];
//            bolinha.backgroundColor = [UIColor clearColor];
//            totalLarguraBolinhas = cont*36 + (cont-1)*10;

//            double diferencaLarguraTotal = (cell.frame.size.width - totalLarguraBolinhas)/2;
            
//            if (cont == 1) {
//                x =diferencaLarguraTotal;
//            }else{
//            
//            x = diferencaLarguraTotal + totalLarguraBolinhas;
//            x = diferencaLarguraTotal + (36*cont) + (10* (cont-1));
       
//            
//            [bolinha setFrame:CGRectMake(x, y, 36, 36)];
//            bolinha.layer.borderColor = [pessoaManager corDaPessoa: pessoa].CGColor;
//            bolinha.layer.borderWidth = 3.0f;
//            bolinha.image = imagem;
//            bolinha.layer.cornerRadius = 18;
//            bolinha.layer.masksToBounds = YES;
//            
//            x = x+36+10;
//
//            
//            
//            
//            
//    
//            [[cell contentView] addSubview: bolinha];
////            [cell addSubview: [pessoaBolinha criarViewCorBolinhaDaPessoa: pessoa naPosicao:CGPointMake(5, 5)]];
//        }
//        
//        for (Pessoa *pessoa in listaPessoa) {
//            NSLog(@"%@", pessoa);
//        }
//        
       
        
    }else{
        //Colocar o texto na celula com descricao do item
        cell = [self criarCellHeaderTitulo:@"   LEMBRETES"];
    }
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if(section==0){
        return 0;
    }else{
        return self.view.frame.size.height/3.5;
    }
}

- (CGFloat)tableView: (UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat heightRow;
    
    heightRow = (self.view.frame.size.height - [self tableView:tableView heightForHeaderInSection:1]) / itensLista.count;
    
    if (heightRow < 45.0) {
        heightRow = 45.0;
    }
    
    return heightRow;
}

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//
//}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return true;
}

- (UITableViewCellEditingStyle) tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleNone;
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
    //Referência: http://stackoverflow.com/questions/9485764/cannot-reorder-an-nsorderedset-relationship-in-core-data
    
    [lista atualizarListaIndex:fromIndexPath.section para:toIndexPath.section];
    [[self tableView] reloadData];
}


#pragma mark - métodos criar célula

- (UITableViewCell *)criarCellwithTitulo:(NSString*)titulo evento1:(NSString*)event1 evento2:(NSString*)event2 evento3:(NSString*)event3{
    
    UITableViewCell *cell = [[UITableViewCell alloc]init];
//    [cell setBackgroundColor: [UIColor colorWithRed:255/255.0f green:255/255.0f blue:255/255.0f alpha:0.0]];
//    cell.backgroundView = [[UIImageView alloc] initWithImage:[ [UIImage imageNamed:@"topAndBottomRow2.png"] stretchableImageWithLeftCapWidth:0.0 topCapHeight:5.0] ];
//    cell.selectedBackgroundView =  [[UIImageView alloc] initWithImage:[ [UIImage imageNamed:@"topAndBottomRoW2.png"] stretchableImageWithLeftCapWidth:0.0 topCapHeight:5.0] ];
    [cell setAccessoryType:UITableViewCellAccessoryNone];
    [[cell textLabel] setTextColor: [UIColor colorWithRed:153/255.0f green:204/255.0f blue:50/255.0f alpha:1]];
    
    y=23;
    UIImageView *view = [[UIImageView alloc]init];
    view.frame = CGRectMake(topLabel.frame.origin.x +topLabel.frame.size.width, 5, 30, 30);
    UIImage *image = [UIImage imageNamed:@"exame.png"];
    [view setImage: image];
    
    topLabel = [[UILabel alloc] initWithFrame:CGRectMake(15,5,150,30)];
    [cell.contentView addSubview:topLabel];
    if ([titulo isEqualToString:@"EXAMES"]) {
        [cell setAccessoryView:[self criarViewIcone:@"exame_me.png" eSize:CGRectMake(topLabel.frame.origin.x +topLabel.frame.size.width, 5, 25, 25)]];
    }else if ([titulo isEqualToString:@"OCORRÊNCIAS"]){
        [cell setAccessoryView:[self criarViewIcone:@"ocorrencia_me.png" eSize:CGRectMake(topLabel.frame.origin.x +topLabel.frame.size.width, 5, 25, 25)]];
    }else if ([titulo isEqualToString:@"PRESCRIÇÕES"]){
        [cell setAccessoryView:[self criarViewIcone:@"prescricao_me.png" eSize:CGRectMake(topLabel.frame.origin.x +topLabel.frame.size.width, 5, 25, 25)]];
    }else if ([titulo isEqualToString:@"REMÉDIOS"]){
        [cell setAccessoryView:[self criarViewIcone:@"remedio_m.png" eSize:CGRectMake(topLabel.frame.origin.x +topLabel.frame.size.width, 5, 25, 25)]];
    }else if ([titulo isEqualToString:@"VACINAS"]){
        [cell setAccessoryView:[self criarViewIcone:@"vacina_me.png" eSize:CGRectMake(topLabel.frame.origin.x +topLabel.frame.size.width, 5, 25, 25)]];
    }else if ([titulo isEqualToString:@"CONSULTAS"]){
        [cell setAccessoryView:[self criarViewIcone:@"consulta_me.png" eSize:CGRectMake(topLabel.frame.origin.x +topLabel.frame.size.width, 5, 25, 25)]];
    }
    
    // Configure the properties for the text that are the same on every row

    
    
    topLabel.backgroundColor = [UIColor clearColor];
//    topLabel.textColor = [UIColor colorWithRed:0/255.0f green:128/255.0f blue:128/255.0f alpha:1];
//    topLabel.textColor = [UIColor colorWithRed:153/255.0f green:204/255.0f blue:50/255.0f alpha:1];
    topLabel.textColor = [UIColor whiteColor];
//    topLabel.highlightedTextColor = [UIColor colorWithRed:0/255.0f green:128/255.0f blue:128/255.0f alpha:0.3];
    topLabel.highlightedTextColor = [UIColor whiteColor];
    topLabel.font = [UIFont systemFontOfSize:[UIFont labelFontSize]];
    topLabel.text = titulo;
    [cell.contentView addSubview:topLabel];
    
    //Create the label for the text body1
    
    bodyLabel1 = [UILabel alloc];
    bodyLabel1 = [self criarTextoLembretewithLembrete: event1];
    [cell.contentView addSubview:bodyLabel1];
    
    bodyLabel2 =[UILabel alloc];
    bodyLabel2 = [self criarTextoLembretewithLembrete:event2];
    [cell.contentView addSubview:bodyLabel2];
                  
    bodyLabel3 = [UILabel alloc];
    bodyLabel3 = [self criarTextoLembretewithLembrete:event3];
    [cell.contentView addSubview:bodyLabel3];
 
    return cell;
}

-(UIImageView *)criarViewIcone:(NSString *)nomeIcone eSize:(CGRect)size
{
    UIImageView *view = [[UIImageView alloc]init];
    view.frame = CGRectMake(size.origin.x, size.origin.y, size.size.width, size.size.height);
    UIImage *image = [UIImage imageNamed:nomeIcone];
    [view setImage:image];
    return view;
}


//método que cria lembretes da index
- (UITableViewCell *)criarCellHeaderTitulo:(NSString*)titulo
{
    UITableViewCell *cell = [[UITableViewCell alloc]init];
    //    UIImage *imagemFundoCell;
    //    imagemFundoCell = [UIImage imageNamed:@"topAndBottomRow.png"];

    [cell setBackgroundColor:[UIColor colorWithRed:210/255.0f green:215/255.0f blue:217/255.0f alpha:1]];
//    cell.backgroundView = [[UIImageView alloc] initWithImage:[ [UIImage imageNamed:@"topAndBottomRowHeader.png"] stretchableImageWithLeftCapWidth:0.0 topCapHeight:5.0] ];
//    cell.selectedBackgroundView =  [[UIImageView alloc] initWithImage:[ [UIImage imageNamed:@"topAndBottomRowHeader.png"] stretchableImageWithLeftCapWidth:0.0 topCapHeight:5.0] ];
    [cell setAccessoryType:UITableViewCellAccessoryNone];
    [[cell textLabel] setTextColor: [UIColor colorWithRed:153/255.0f green:204/255.0f blue:50/255.0f alpha:1]];
    y=23;
    
    
    topLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.origin.x,0,self.view.frame.size.width ,27)];
    [cell.contentView addSubview:topLabel];
    
    // Configure the properties for the text that are the same on every row
    
    topLabel.backgroundColor = [UIColor grayColor];
    //    topLabel.textColor = [UIColor colorWithRed:0/255.0f green:128/255.0f blue:128/255.0f alpha:1];
//    topLabel.highlightedTextColor = [UIColor colorWithRed:0/255.0f green:128/255.0f blue:128/255.0f alpha:0.3];
    
    topLabel.textColor = [UIColor whiteColor];
     topLabel.highlightedTextColor = [UIColor colorWithRed:153/255.0f green:204/255.0f blue:50/255.0f alpha:1];
    
    
    topLabel.font = [UIFont systemFontOfSize:[UIFont labelFontSize]];
    topLabel.text = titulo;
    [cell.contentView addSubview:topLabel];
     [[cell contentView] addSubview:viewLabel];
    //Create the label for the text body1
    
    EventoRepeticaoManager *managerEvento = [EventoRepeticaoManager sharedInstance];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
   
    NSArray *itens = [managerEvento obterItensFuturosSomenteComNotificacao:NO comLimite:3];
    for (NSArray *item in itens) {
        NSDate *data1 = [item objectAtIndex:0];
        EventoRepeticao *evento = [item objectAtIndex:1];
      
        UILabel *label = [[UILabel alloc] init];
        label = [self criarTextoLembretewithLembrete:[NSString stringWithFormat:@"%@ ", [formatter stringFromDate:data1]]];
        UIView *view = [self criarLembreteIconeComLabel:label eComEvento:evento];
        [cell.contentView addSubview:view];
    }
    
    return cell;
}

int y;


- (UIView *)criarLembreteIconeComLabel:(UILabel *)label eComEvento:(EventoRepeticao *)evento
{
    UIView *view = [[UIView alloc]init];
    view.frame = CGRectMake(self.view.frame.origin.x + viewLabel.frame.origin.x + viewLabel.frame.size.width -10, y+5, 30, 30);
    
    UIImage *imagem;
    if ([evento isMemberOfClass:[HistoricoRem class]]) {
       imagem = [UIImage imageNamed:@"remedio_m"];
    } else if ([evento isMemberOfClass:[HistoricoVacina class]]) {
        imagem = [UIImage imageNamed:@"vacina_me"];
    }
    
    UIImageView *viewImagem = [[UIImageView alloc] init];
    [viewImagem setFrame:CGRectMake(20, 2.5, 25, 25)];
    [viewImagem setBackgroundColor:[UIColor grayColor]];
    viewImagem.layer.cornerRadius = viewImagem.frame.size.width/2;
    viewImagem.layer.borderWidth = 1.0f;
    viewImagem.layer.borderColor = ((UIColor *)evento.pessoa.cor).CGColor;
    UIImageView *viewImagemReduzida = [[UIImageView alloc] init];
    [viewImagemReduzida setFrame:CGRectMake(viewImagem.frame.size.width/4, viewImagem.frame.size.height/4, viewImagem.frame.size.width/2, viewImagem.frame.size.height/2)];
    [viewImagemReduzida setImage:imagem];
    [viewImagem addSubview:viewImagemReduzida];
    [view addSubview:viewImagem];
    
    
    [view addSubview:label];
    
    y=y+30;
    
    return view;
}
- (UILabel *)criarTextoLembretewithLembrete:(NSString *)lembrete
{
    //imagem do lembrete

    
    
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake( viewLabel.frame.origin.x + viewLabel.frame.size.width - 20, 0 , self.view.frame.size.width - (25 + viewLabel.frame.origin
                                                               .x + viewLabel.frame.size.width), 30)];
    [label setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
    
    label.text = lembrete;
    label.backgroundColor = [UIColor clearColor];
    label.textColor = [UIColor colorWithRed:79/255.0f green:79/255.0f blue:79/255.0f alpha:1];
    label.highlightedTextColor = [UIColor colorWithRed:79/255.0f green:79/255.0f blue:79/255.0f alpha:0.3];
    label.textAlignment = NSTextAlignmentLeft;
    label.font = [UIFont systemFontOfSize:[UIFont systemFontSize]];
    
    
    
    return label;
}

//- (void)adicionarPerfil:(id)sender
//{
//    ListaPerfilViewController *listaperfilViewController = [[ListaPerfilViewController alloc] init];
//    [[self navigationController] pushViewController:listaperfilViewController animated:NO];
//}

- (void)listarPerfil:(id)sender
{
    ListaPerfilViewController *listaperfilViewController = [[ListaPerfilViewController alloc] init];
    [UIView animateWithDuration:0.9 animations:^{
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
        [self.navigationController pushViewController:listaperfilViewController animated:YES];
        [UIView setAnimationTransition:UIViewAnimationTransitionNone forView:self.navigationController.view cache:NO];
    }];

}

- (void)exibirHelp:(id)sender
{
    HelpViewController *helpTela = [[HelpViewController alloc]init];
    [UIView animateWithDuration:0.9 animations:^{
        [UIView setAnimationCurve:UIViewAnimationCurveLinear];
        [self.navigationController pushViewController:helpTela animated:YES];
        [UIView setAnimationTransition:UIViewAnimationTransitionNone forView:self.navigationController.view cache:NO];
        
    }];
}

-(void)onTap:(MMTapGestureRecognizer *)sender
{
    NSIndexPath *indexPath = (NSIndexPath *)sender.objeto;
    
    Index *itemLista = [itensLista objectAtIndex:indexPath.row];
    NSString *itemListaString = itemLista.item;
    
    NSLog(@"%@", itemLista.item);
    
    if ([itemListaString isEqualToString:@"REMÉDIOS"]) {
        ListaRemedioViewController *listaRemedio = [[ListaRemedioViewController alloc] init];
        [self apresentarTela:listaRemedio daIndex:itemLista];
    } else if ([itemListaString isEqualToString:@"CONSULTAS"]) {
        ListaConsultaViewController *listaConsulta = [[ListaConsultaViewController alloc] init];
        [self apresentarTela:listaConsulta daIndex:itemLista];
    } else if ([itemListaString isEqualToString:@"VACINAS"]) {
        ListaVacinaViewController *listaVacina = [[ListaVacinaViewController alloc] init];
        [self apresentarTela:listaVacina daIndex:itemLista];
    } else if ([itemListaString isEqualToString:@"OCORRÊNCIAS"]) {
        HistoricoDeOcorrenciaViewController *listaOcorr = [[HistoricoDeOcorrenciaViewController alloc] init];
        [self apresentarTela:listaOcorr daIndex:itemLista];
    } else if ([itemListaString isEqualToString:@"PRESCRIÇÕES"]) {
        ListaPrescricaoViewController *listaPrescri = [[ListaPrescricaoViewController alloc] init];
        [self apresentarTela:listaPrescri daIndex:itemLista];
    } else if ([itemListaString isEqualToString:@"EXAMES"]) {
        ListaExamesTableViewController *listaExame = [[ListaExamesTableViewController alloc] init];
        [self apresentarTela:listaExame daIndex:itemLista];
    }
}

- (void)apresentarTela:(UIViewController *)viewController daIndex:(Index *)index
{
    [[[self navigationController] navigationBar] setBarTintColor:index.corCell];
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    [UIView animateWithDuration:0.75 animations:^{
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [self.navigationController pushViewController:viewController animated:NO];
        [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:self.navigationController.view cache:NO];
    }];
}

#pragma mark - métodos Gesture

-(void)longTap:(UIGestureRecognizer *)sender
{
    
    UILongPressGestureRecognizer *longPress = (UILongPressGestureRecognizer *)sender;
    UIGestureRecognizerState state = longPress.state;
    
    CGPoint location = [longPress locationInView:self.tableView];
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:location];

    static UIView       *snapshot = nil;        ///< A snapshot of the row user is moving.
    static NSIndexPath  *sourceIndexPath = nil; ///< Initial index path, where gesture begins.
    
    Index *itemLista = [itensLista objectAtIndex:indexPath.row];
    NSString *itemListaString = itemLista.item;
    
//    NSLog(@"%@", itemListaString);
    switch (state) {
        case UIGestureRecognizerStateBegan: {
//            NSLog(@"%@",(Index *)[itensLista objectAtIndex:indexPath.row]);
            if (indexPath && ![((Index *)[itensLista objectAtIndex:indexPath.row]).item isEqualToString:@"LEMBRETES"]) {
                sourceIndexPath = indexPath;
                
                UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
                
                // Take a snapshot of the selected row using helper method.
                snapshot = [self customSnapshotFromView:cell];
                
                // Add the snapshot as subview, centered at cell's center...
                __block CGPoint center = cell.center;
                snapshot.center = center;
                snapshot.alpha = 0.0;
                [self.tableView addSubview:snapshot];
                [UIView animateWithDuration:0.25 animations:^{
                    
                    // Offset for gesture location.
                    center.y = location.y;
                    snapshot.center = center;
                    snapshot.transform = CGAffineTransformMakeScale(1.05, 1.05);
                    snapshot.alpha = 0.98;
                    
                    // Fade out.
                    cell.alpha = 0.0;
                    
                } completion:^(BOOL finished) {
                    
                    cell.hidden = YES;
                    
                }];
            }
            break;
        }
        case UIGestureRecognizerStateChanged: {
            CGPoint center = snapshot.center;
            center.y = location.y;
            snapshot.center = center;
            
            // Is destination valid and is it different from source?
            if (indexPath && ![indexPath isEqual:sourceIndexPath]) {
                
                // ... update data source.
                [lista atualizarListaIndex:sourceIndexPath.row para:indexPath.row];
                itensLista = [lista obterListaIndex];
                [[self tableView] reloadData];
                
                // ... move the rows.
                [self.tableView moveRowAtIndexPath:sourceIndexPath toIndexPath:indexPath];
                
                // ... and update source so it is in sync with UI changes.
//                NSIndexPath *index = sourceIndexPath;
                sourceIndexPath = indexPath;
//                indexPath = index;
            }
            break;
        }
        default: {
            // Clean up.
            UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:sourceIndexPath];
            cell.hidden = NO;
            cell.alpha = 0.0;
            [UIView animateWithDuration:0.25 animations:^{
                
                snapshot.center = cell.center;
                snapshot.transform = CGAffineTransformIdentity;
                snapshot.alpha = 0.0;
                
                // Undo fade out.
                cell.alpha = 1.0;
                
            } completion:^(BOOL finished) {
                
                sourceIndexPath = nil;
                [snapshot removeFromSuperview];
                snapshot = nil;
                
            }];
            break;
        }
    }
}

- (UIView *)customSnapshotFromView:(UIView *)inputView {
    
    UIView *snapshot = [inputView snapshotViewAfterScreenUpdates:YES];
    snapshot.layer.masksToBounds = NO;
    snapshot.layer.cornerRadius = 0.0;
    snapshot.layer.shadowOffset = CGSizeMake(-10.0, 0.0);
    snapshot.layer.shadowRadius = 5.0;
    snapshot.layer.shadowOpacity = 0.4;
    
    return snapshot;
}

@end