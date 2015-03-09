//
//  CadRemViewController.m
//  Projeto Final
//
//  Created by Leonardo Felipe da Silva on 22/08/14.
//  Copyright (c) 2014 Mack Mobile - BEPiD. All rights reserved.
//

#import "RemedioViewController.h"
#import "UIImage+ImageEffects.h"
#import "CampoViewController.h"
#import "RemedioManager.h"
#import "PessoaManager.h"
#import "UnidadeDeTempoManager.h"
#import "HistoricoRemViewController.h"

@interface RemedioViewController (){
    NSArray *tableViewSections;
    NSArray *tableViewItens;
    NSArray *tableViewControle;
    UITableView *tableViewRemedio;
}

@end

@implementation RemedioViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        UIImage *image = [UIImage imageNamed:@"remedio_line.png"];
        self.tabBarItem.image = [self imageWithImage:image scaledToSize:CGSizeMake(30, 30)];
        UIImage *imageSelect = [UIImage imageNamed:@"remedio_color.png"];
        
        self.tabBarItem.selectedImage = [self imageWithImage:imageSelect scaledToSize:CGSizeMake(30, 30)];
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
    // Do any additional setup after loading the view.
    
    [self setTitle:@"Remédio"];
    [self.tabBarController.tabBar setBackgroundColor:self.navigationController.navigationBar.barTintColor];
    RemedioManager *manager = [RemedioManager sharedInstance];
    
    remedio = ((Remedio *)((MMTabBarController *)self.tabBarController).objeto);
    
    if (!remedio) { //Adicionar Remédio
        remedio = [manager criarRemedio];
        
        [self setTitle:@"Novo remédio"];
        
        //Botão de Cancelar
        UIBarButtonItem *barButtonCancel = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(selBtnCancelar:)];
        [[self navigationItem] setLeftBarButtonItem:barButtonCancel];
        
        //Botão de Adicionar
        UIBarButtonItem *barButtonAdd = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(selBtnAdicionar:)];
        [[self navigationItem] setRightBarButtonItem:barButtonAdd];
    } else { //Visualizar ou Editar o Remédio
        [[self tabBarController] setTitle:remedio.nome];
        
        tableViewControle = [[NSArray alloc] initWithObjects:@"LabelQtdRemedio", @"LabelProximoEvento", nil];
    }
    
    if (!tableViewControle) {
        tableViewSections = [[NSArray alloc] initWithObjects:@"Foto", @"Itens", nil];
    } else {
        tableViewSections = [[NSArray alloc] initWithObjects:@"Foto", @"Itens", @"Controle", nil];
    }
    
    tableViewItens = [[NSArray alloc] initWithObjects:@"Nome", @"Fabricante", @"Genérico", @"Tipo", nil];
    
#pragma mark - Itens do cadastro (Table View)
    UIView *viewTableView = [self criarView:0];
    
    tableViewRemedio = [self criarTableViewNaView:viewTableView comAltura:self.view.frame.size.height];
    tableViewRemedio.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero]; //remove extra lines from TableView (http://stackoverflow.com/questions/1369831/eliminate-extra-separators-below-uitableview-in-iphone-sdk)
    
//    [tableViewRemedio setSeparatorStyle:UITableViewCellSeparatorStyleNone];
//    [tableViewRemedio setBackgroundColor:[UIColor redColor]];
    
    [viewTableView setFrame:CGRectMake(viewTableView.frame.origin.x, viewTableView.frame.origin.y, viewTableView.frame.size.width, viewTableView.frame.size.height + tableViewRemedio.frame.size.height)];
    [viewTableView addSubview:tableViewRemedio];
    
#pragma mark - Continuação das configurações
    
    [self setContentSizeScrollView];
    
    //adicionando as notificações
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(atualizarImagemImageView:) name:@"atualizarImagemImageView" object:nil];
}

- (void)viewDidAppear:(BOOL)animated
{
    [tableViewRemedio reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source (TableView: tableViewRemedio)

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return tableViewSections.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    NSInteger numRows;
    
    NSString *sectionStr = [tableViewSections objectAtIndex:section];
    if ([sectionStr isEqualToString:@"Foto"]) {
        numRows = 1;
    } else if ([sectionStr isEqualToString:@"Itens"]) {
        numRows = tableViewItens.count;
    } else if ([sectionStr isEqualToString:@"Controle"]) {
        numRows = tableViewControle.count;
    }
    
    return numRows;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *title;
    
    NSString *sectionStr = [tableViewSections objectAtIndex:section];
    if ([sectionStr isEqualToString:@"Foto"]) {
        title = @"";
    } else if ([sectionStr isEqualToString:@"Itens"]) {
        title = @"Remédio";
    } else if ([sectionStr isEqualToString:@"Controle"]) {
        title = @"Controle";
    }
    
    return title;
}

//- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
//{
//    return [[UIView alloc] init]; //para remover as linhas extrar da Table View (UITableViewCellSeparatorStyleNone)
//    //http://shiki.me/blog/removing-extra-separator-lines-for-empty-rows-in-uitableview/
//}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    NSString *reuseIdentifier = @"CelulaRemedio";
    UITableViewCell *cell;
//    cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
//    if (!cell) {
//        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
//    }
    // Configure the cell...
    
    NSString *sectionStr = [tableViewSections objectAtIndex:indexPath.section];
    if ([sectionStr isEqualToString:@"Foto"]) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        
        UIView *viewFoto = [[UIView alloc] init];
        [viewFoto setFrame:CGRectMake(0, 0, cell.frame.size.width, 170)];
        
        imgFotoBlur = [self criarImageViewBlurNaView:viewFoto];
        imgFotoIcone = [self criarImageViewIconeNaView:viewFoto];
        
        imgFotoIcone.image = [UIImage imageWithData:remedio.foto];
        imgFotoBlur.image = [imgFotoIcone.image applyLightEffect];
        
//        MMCarregarImagem *carregarImagem = [[MMCarregarImagem alloc] init];
//        [carregarImagem processarDado:remedio.foto naImageView:imgFotoIcone];
//        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void){
//            dispatch_async(dispatch_get_main_queue(), ^{
//                imgFotoIcone.image = [UIImage imageWithData:remedio.foto];
//                imgFotoBlur.image = [imgFotoIcone.image applyLightEffect];
//            });
//        });
        
        [imgFotoBlur setUserInteractionEnabled:YES]; //para reconhecer o toque (GestureRecognizer)
        
        MMTapGestureRecognizer *tapGestureRecognizer = [[MMTapGestureRecognizer alloc] init];
        tapGestureRecognizer.objeto = imgFotoIcone;
        [tapGestureRecognizer addTarget:self action:@selector(toqueImageView:)];
        [viewFoto addGestureRecognizer:tapGestureRecognizer];
        
        [[cell contentView] addSubview:viewFoto];
    } else if ([sectionStr isEqualToString:@"Itens"]) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
        [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
        
        NSString *itemStr = [tableViewItens objectAtIndex:indexPath.row];
        if ([itemStr isEqualToString:@"Nome"]) {
            [[cell textLabel] setText:@"Nome"];
            [[cell detailTextLabel] setText:remedio.nome];
        } else if ([itemStr isEqualToString:@"Fabricante"]) {
            [[cell textLabel] setText:@"Fabricante"];
            [[cell detailTextLabel] setText:remedio.fabricante];
        } else if ([itemStr isEqualToString:@"Genérico"]) {
            [[cell textLabel] setText:@"Genérico"];
            NSString *strGenerico;
            if ([remedio.generico boolValue]) {
                strGenerico = @"Sim";
            } else {
                strGenerico = @"Não";
            }
            [[cell detailTextLabel] setText:strGenerico];
            
//            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
//            UISwitch *swtGenerico = [[UISwitch alloc] init];
//            [swtGenerico addTarget:self action:@selector(changeSwitchUpdate:) forControlEvents:UIControlEventValueChanged];
//            [swtGenerico setOn:[remedio.generico boolValue]];
//            [cell setAccessoryView:swtGenerico];
        } else if ([itemStr isEqualToString:@"Tipo"]) {
            [[cell textLabel] setText:@"Tipo"];
            [[cell detailTextLabel] setText:remedio.tipo];
        }
    } else if ([sectionStr isEqualToString:@"Controle"]) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        
        NSString *itemStr = [tableViewControle objectAtIndex:indexPath.row];
        if ([itemStr isEqualToString:@"LabelQtdRemedio"]) {
            RemedioManager *manager = [RemedioManager sharedInstance];
            
            NSDictionary *qtd = [manager obterQuantidadeRemedioCaixaDoRemedio:remedio];
            
            [[cell textLabel] setText:@"Quantidade"];
            [[cell detailTextLabel] setText:[NSString stringWithFormat:@"%@ / %@", [qtd objectForKey:@"qtdAtual"], [qtd objectForKey:@"qtdTotal"]]];
        } else if ([itemStr isEqualToString:@"LabelProximoEvento"]) {
            [[cell textLabel] setText:@"Próximo evento"];
            
            RemedioManager *managerRemedio = [RemedioManager sharedInstance];
            PessoaManager *managerPessoa = [PessoaManager sharedInstance];
            
            NSDateFormatter *dateTimeFormatter = [[NSDateFormatter alloc] init];
            [dateTimeFormatter setDateStyle: NSDateFormatterMediumStyle];
            [dateTimeFormatter setTimeStyle:NSDateFormatterShortStyle];
            
            HistoricoRem *historicoRem = [managerRemedio proximoEventoDoRemedio:remedio];
            
            if (!historicoRem) {
                [[cell detailTextLabel] setText:@"Nenhum evento"];
            } else {
                [[cell detailTextLabel] setText:[dateTimeFormatter stringFromDate:[managerRemedio proximaDataDoHistoricoRem:historicoRem]]];
                
//                UIView *viewBolinhaCor = [managerPessoa criarViewCorBolinhaDaPessoa:historicoRem.pessoa naPosicao:CGPointMake(140, 14)];
//                [[cell contentView] addSubview:viewBolinhaCor];
                UIView *viewBolinhaCor = [managerPessoa criarViewCorBolinhaDaPessoa:historicoRem.pessoa naPosicao:CGPointMake(0, 0)];
                [cell setAccessoryView:viewBolinhaCor];
            }
        }
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height;
    
    NSString *sectionStr = [tableViewSections objectAtIndex:indexPath.section];
    if ([sectionStr isEqualToString:@"Foto"]) {
        height = 170.0;
    } else if ([sectionStr isEqualToString:@"Itens"]) {
        height = 50.0;
    } else if ([sectionStr isEqualToString:@"Controle"]) {
        height = 50.0;
    }
    
    return height;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCellEditingStyle editingStyle;
    
    NSString *sectionStr = [tableViewSections objectAtIndex:indexPath.section];
    if ([sectionStr isEqualToString:@"Foto"]) {
        editingStyle = UITableViewCellEditingStyleNone;
    } else if ([sectionStr isEqualToString:@"Itens"]) {
        editingStyle = UITableViewCellEditingStyleNone;
    } else if ([sectionStr isEqualToString:@"Controle"]) {
        editingStyle = UITableViewCellEditingStyleNone;
    }
    
    return editingStyle;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *sectionStr = [tableViewSections objectAtIndex:indexPath.section];
    if ([sectionStr isEqualToString:@"Foto"]) {
        //DO NOTHING
    } else if ([sectionStr isEqualToString:@"Itens"]) {
        NSString *itemStr = [tableViewItens objectAtIndex:indexPath.row];
        
        CampoViewController *campoViewController = [[CampoViewController alloc] init];
        campoViewController.refObjeto = remedio;
        
        if ([itemStr isEqualToString:@"Nome"]) {
            campoViewController.tipo = @"texto";
            campoViewController.nomeAtributo = @"nome";
        } else if ([itemStr isEqualToString:@"Fabricante"]) {
            campoViewController.tipo = @"texto";
            campoViewController.nomeAtributo = @"fabricante";
        } else if ([itemStr isEqualToString:@"Genérico"]) {
            campoViewController.tipo = @"simNaoTableView";
            campoViewController.nomeAtributo = @"generico";
        } else if ([itemStr isEqualToString:@"Tipo"]) {
            campoViewController.tipo = @"listaTipoRemedio";
            campoViewController.nomeAtributo = @"tipo";
        }
        
        campoViewController.title = itemStr;
        
        [[self navigationController] pushViewController:campoViewController animated:YES];
    } else if ([sectionStr isEqualToString:@"Controle"]) {
        RemedioManager *manager = [RemedioManager sharedInstance];
        
        NSString *itemStr = [tableViewControle objectAtIndex:indexPath.row];
        if ([itemStr isEqualToString:@"LabelQtdRemedio"]) {
            [[self tabBarController] setSelectedIndex:2];
        } else if ([itemStr isEqualToString:@"LabelProximoEvento"]) {
            [[self tabBarController] setSelectedIndex:1];
            
            HistoricoRem *historicoRem = [manager proximoEventoDoRemedio:remedio];
            
            if (!historicoRem) {
                UIAlertView *msg = [[UIAlertView alloc] initWithTitle:@"Aviso" message:@"Não existe próximo histórico!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [msg show];
            } else {
                HistoricoRemViewController *historicoRemViewController = [[HistoricoRemViewController alloc] init];
                
                historicoRemViewController.historicoRem = historicoRem;
                
                [[self navigationController] pushViewController:historicoRemViewController animated:YES];
            }
        }
    }
}

#pragma mark - Selectors dos botões da navigationBar

- (void)selBtnCancelar:(id)sender
{
    RemedioManager *manager = [RemedioManager sharedInstance];
    [manager deletarRemedio:remedio];
//    [[manager getContext] rollback];
//    [[manager getContext] refreshObject:remedio mergeChanges:NO];
    
    [self removerTela];
}

- (void)selBtnAdicionar:(id)sender
{
    RemedioManager *manager = [RemedioManager sharedInstance];
    UnidadeDeTempoManager *managerTempo = [UnidadeDeTempoManager sharedInstance];
    
    //adicionando históricos e caixas para testes
    HistoricoRem *historicoRem;
    historicoRem = [manager criarHistoricoRemDoRemedio:remedio];
    historicoRem.dataInicio = [NSDate dateWithTimeIntervalSinceNow:-(60*60*24*2)];
    historicoRem.duracao = [managerTempo criarUnidadeDeTempo];
    historicoRem.duracao.quantidade = [NSNumber numberWithInt:1];
    historicoRem.duracao.unidade = [NSNumber numberWithInteger:MMDia];
    historicoRem.frequencia = [managerTempo criarUnidadeDeTempo];
    historicoRem.frequencia.quantidade = [NSNumber numberWithInt:10];
    historicoRem.frequencia.unidade = [NSNumber numberWithInteger:MMMinuto];
    historicoRem.qtda = [NSNumber numberWithInt:1];
    historicoRem = [manager criarHistoricoRemDoRemedio:remedio];
    historicoRem.dataInicio = [NSDate dateWithTimeIntervalSinceNow:-(60*60*24*1)];
    historicoRem.duracao = [managerTempo criarUnidadeDeTempo];
    historicoRem.duracao.quantidade = [NSNumber numberWithInt:10];
    historicoRem.duracao.unidade = [NSNumber numberWithInteger:MMDia];
    historicoRem.frequencia = [managerTempo criarUnidadeDeTempo];
    historicoRem.frequencia.quantidade = [NSNumber numberWithInt:10];
    historicoRem.frequencia.unidade = [NSNumber numberWithInteger:MMMinuto];
    historicoRem.qtda = [NSNumber numberWithInt:1];
    historicoRem = [manager criarHistoricoRemDoRemedio:remedio];
    historicoRem.dataInicio = [NSDate dateWithTimeIntervalSinceNow:-(60*60*24*2)];
    historicoRem.duracao = [managerTempo criarUnidadeDeTempo];
    historicoRem.duracao.quantidade = [NSNumber numberWithInt:1];
    historicoRem.duracao.unidade = [NSNumber numberWithInteger:MMMes];
    historicoRem.frequencia = [managerTempo criarUnidadeDeTempo];
    historicoRem.frequencia.quantidade = [NSNumber numberWithInt:1];
    historicoRem.frequencia.unidade = [NSNumber numberWithInteger:MMDia];
    historicoRem.qtda = [NSNumber numberWithInt:1];
    historicoRem = [manager criarHistoricoRemDoRemedio:remedio];
    historicoRem.dataInicio = [NSDate dateWithTimeIntervalSinceNow:-(60*60*24*3)];
    historicoRem.duracao = [managerTempo criarUnidadeDeTempo];
    historicoRem.duracao.quantidade = [NSNumber numberWithInt:2];
    historicoRem.duracao.unidade = [NSNumber numberWithInteger:MMSemana];
    historicoRem.frequencia = [managerTempo criarUnidadeDeTempo];
    historicoRem.frequencia.quantidade = [NSNumber numberWithInt:1];
    historicoRem.frequencia.unidade = [NSNumber numberWithInteger:MMHora];
    historicoRem.qtda = [NSNumber numberWithInt:1];
    historicoRem = [manager criarHistoricoRemDoRemedio:remedio];
    historicoRem.dataInicio = [NSDate dateWithTimeIntervalSinceNow:(60*60*24*1)];
    historicoRem.duracao = [managerTempo criarUnidadeDeTempo];
    historicoRem.duracao.quantidade = [NSNumber numberWithInt:5];
    historicoRem.duracao.unidade = [NSNumber numberWithInteger:MMDia];
    historicoRem.frequencia = [managerTempo criarUnidadeDeTempo];
    historicoRem.frequencia.quantidade = [NSNumber numberWithInt:30];
    historicoRem.frequencia.unidade = [NSNumber numberWithInteger:MMMinuto];
    historicoRem.qtda = [NSNumber numberWithInt:1];
    historicoRem = [manager criarHistoricoRemDoRemedio:remedio];
    historicoRem.dataInicio = [NSDate dateWithTimeIntervalSinceNow:(60*60*24*2)];
    historicoRem.duracao = [managerTempo criarUnidadeDeTempo];
    historicoRem.duracao.quantidade = [NSNumber numberWithInt:1];
    historicoRem.duracao.unidade = [NSNumber numberWithInteger:MMAno];
    historicoRem.frequencia = [managerTempo criarUnidadeDeTempo];
    historicoRem.frequencia.quantidade = [NSNumber numberWithInt:1];
    historicoRem.frequencia.unidade = [NSNumber numberWithInteger:MMDia];
    historicoRem.qtda = [NSNumber numberWithInt:1];
    historicoRem.dataInicio = [NSDate dateWithTimeIntervalSinceNow:(60*60*24*5)];
    historicoRem.duracao = [managerTempo criarUnidadeDeTempo];
    historicoRem.duracao.quantidade = [NSNumber numberWithInt:1];
    historicoRem.duracao.unidade = [NSNumber numberWithInteger:MMDia];
    historicoRem.frequencia = [managerTempo criarUnidadeDeTempo];
    historicoRem.frequencia.quantidade = [NSNumber numberWithInt:15];
    historicoRem.frequencia.unidade = [NSNumber numberWithInteger:MMMinuto];
    historicoRem.qtda = [NSNumber numberWithInt:1];
    RemedioCaixa *remedioCaixa;
    remedioCaixa = [manager criarRemedioCaixaNoRemedio:remedio];
    remedioCaixa.dataValidade = [NSDate dateWithTimeIntervalSinceNow:-(60*60*24*3)];
    remedioCaixa.qtdTotal = [NSNumber numberWithInt:10];
    remedioCaixa.qtdAtual = [NSNumber numberWithInt:10];
    remedioCaixa = [manager criarRemedioCaixaNoRemedio:remedio];
    remedioCaixa.dataValidade = [NSDate dateWithTimeIntervalSinceNow:(60*60*24*3)];
    remedioCaixa.qtdTotal = [NSNumber numberWithInt:10];
    remedioCaixa.qtdAtual = [NSNumber numberWithInt:10];
    remedioCaixa = [manager criarRemedioCaixaNoRemedio:remedio];
    remedioCaixa.dataValidade = [NSDate dateWithTimeIntervalSinceNow:-(60*60*24*3)];
    remedioCaixa.qtdTotal = [NSNumber numberWithInt:10];
    remedioCaixa.qtdAtual = [NSNumber numberWithInt:0];
    remedioCaixa = [manager criarRemedioCaixaNoRemedio:remedio];
    remedioCaixa.dataValidade = [NSDate dateWithTimeIntervalSinceNow:(60*60*24*10)];
    remedioCaixa.qtdTotal = [NSNumber numberWithInt:10];
    remedioCaixa.qtdAtual = [NSNumber numberWithInt:10];
    remedioCaixa = [manager criarRemedioCaixaNoRemedio:remedio];
    remedioCaixa.dataValidade = [NSDate dateWithTimeIntervalSinceNow:(60*60*24*10)];
    remedioCaixa.qtdTotal = [NSNumber numberWithInt:10];
    remedioCaixa.qtdAtual = [NSNumber numberWithInt:0];
    
    [manager saveContext];
    
    [self removerTela];
}

- (void)removerTela
{
//    [UIView animateWithDuration:0.75 animations:^{
//        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
//        [UIView setAnimationTransition:UIViewAnimationTransitionNone forView:self.navigationController.view cache:NO];
//    }];
//    [self.navigationController popViewControllerAnimated:NO];
    
//    [UIView transitionWithView:self.navigationController.view duration:0.75 options:UIViewAnimationOptionTransitionFlipFromBottom animations:^{
//        [self.navigationController popViewControllerAnimated:NO];
//    } completion:NULL];
    
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    
    //chamando o método do NotificationCenter para atualizar a tableView
    [[NSNotificationCenter defaultCenter] postNotificationName:@"tableViewRemediosReloadData" object:nil];
}

#pragma mark - Selectors da tela

//- (void)toqueBtnAdicionar:(id)sender
//{
//    MMTapGestureRecognizer *tapGestureRecognizerComObjeto = (MMTapGestureRecognizer *)sender;
//    id objeto = tapGestureRecognizerComObjeto.objeto;
//    
//    if ([objeto isKindOfClass:[UIView class]]) {
//        UIView *viewHistorico = (UIView *)objeto;
//        
//        [self criarViewItemHistorico:nil naView:viewHistorico];
//    }
//}

#pragma mark - Selectors das notifications

- (void)atualizarImagemImageView:(NSNotification *)notification {
    UIImageView *imageView = (UIImageView *)notification.object;
    
    if ([imageView isEqual:imgFotoIcone]) {
        imgFotoIcone.image = imageView.image;
        imgFotoBlur.image = [imageView.image applyLightEffect];
        
        NSData *foto = UIImageJPEGRepresentation(imgFotoIcone.image, 1.0);
        remedio.foto = foto;
//        NSLog(@"%lu %lu", (unsigned long)remedio.foto.length, (unsigned long)foto.length);
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
