//
//  HistoricoRemViewController.m
//  Projeto Final
//
//  Created by Lucas Saito on 14/09/14.
//  Copyright (c) 2014 Mack Mobile - BEPiD. All rights reserved.
//

#import "HistoricoRemViewController.h"
#import "RemedioManager.h"
#import "PessoaManager.h"
#import "EventoRepeticaoManager.h"
#import "UnidadeDeTempoManager.h"
#import "NotificationManager.h"
#import "CampoViewController.h"
#import "ListaPerfilViewController.h"

@interface HistoricoRemViewController ()
{
    UITableView *tableViewConteudo;
    NSArray *tableViewSections;
    NSArray *tableViewItens;
    NSArray *tableViewControle;
}

@end

@implementation HistoricoRemViewController

@synthesize historicoRem;
@synthesize remedio;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    
    }
    return self;
}




- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    RemedioManager *manager = [RemedioManager sharedInstance];
    
    if (!historicoRem) { //Adicionar Remédio
        historicoRem = [manager criarHistoricoRemDoRemedio:remedio];
        
        [self setTitle:@"Novo evento"];
        
        //Botão de Cancelar
        UIBarButtonItem *barButtonCancel = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(selBtnCancelar:)];
        [[self navigationItem] setLeftBarButtonItem:barButtonCancel];
        
        //Botão de Adicionar
        UIBarButtonItem *barButtonAdd = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(selBtnAdicionar:)];
        [[self navigationItem] setRightBarButtonItem:barButtonAdd];
    } else {
        tableViewControle = [[NSArray alloc] initWithObjects:@"LblQtdEventos", @"LblProximoEvento", @"BtnNotificacoesEventos", @"BtnNotificacoes", @"BtnTomarRemedio", nil];
    }
    
    if (!tableViewControle) {
        tableViewSections = [[NSArray alloc] initWithObjects:@"Dados", nil];
    } else {
        tableViewSections = [[NSArray alloc] initWithObjects:@"Dados", @"Controle", nil];
    }
    
    tableViewItens = [[NSArray alloc] initWithObjects:@"Data", @"Duração", @"Frequência", @"Quantidade", @"Perfil", nil];
    
    UIView *viewTableView = [self criarView:0];
    
    tableViewConteudo = [self criarTableViewNaView:self.view comAltura:self.view.frame.size.height];
    tableViewConteudo.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    [viewTableView setFrame:CGRectMake(viewTableView.frame.origin.x, viewTableView.frame.origin.y, viewTableView.frame.size.width, viewTableView.frame.size.height + tableViewConteudo.frame.size.height)];
    [viewTableView addSubview:tableViewConteudo];
    
    //adicionando as notificações
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tableViewReloadData:) name:@"atualizarTableView" object:nil];
}

- (void)viewWillAppear:(BOOL)animated
{
    [tableViewConteudo reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

#pragma mark - Table view data source (TableView: tableViewConteudo)

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return tableViewSections.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    NSInteger numRows;
    
    NSString *sectionStr = [tableViewSections objectAtIndex:section];
    if ([sectionStr isEqualToString:@"Dados"]) {
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
    if ([sectionStr isEqualToString:@"Dados"]) {
        title = @"Dados";
    } else if ([sectionStr isEqualToString:@"Controle"]) {
        title = @"Controle";
    }
    
    return title;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    
    RemedioManager *managerRemedio = [RemedioManager sharedInstance];
    PessoaManager *managerPessoa = [PessoaManager sharedInstance];
    UnidadeDeTempoManager *managerTempo = [UnidadeDeTempoManager sharedInstance];
    
    NSDateFormatter *dateTimeFormatter = [[NSDateFormatter alloc] init];
    [dateTimeFormatter setDateStyle: NSDateFormatterMediumStyle];
    [dateTimeFormatter setTimeStyle:NSDateFormatterShortStyle];
    
    NSString *sectionStr = [tableViewSections objectAtIndex:indexPath.section];
    if ([sectionStr isEqualToString:@"Dados"]) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
        [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
        
        NSString *itemStr = [tableViewItens objectAtIndex:indexPath.row];
        if ([itemStr isEqualToString:@"Data"]) {
            [[cell textLabel] setText:@"Início"];
            NSString *strData = [dateTimeFormatter stringFromDate:historicoRem.dataInicio];
            [[cell detailTextLabel] setText:strData];
        } else if ([itemStr isEqualToString:@"Duração"]) {
            [[cell textLabel] setText:@"Duração"];
            [[cell detailTextLabel] setText:[managerTempo criarLabel:historicoRem.duracao]];
        } else if ([itemStr isEqualToString:@"Frequência"]) {
            [[cell textLabel] setText:@"Frequência"];
            [[cell detailTextLabel] setText:[managerTempo criarLabel:historicoRem.frequencia]];
        } else if ([itemStr isEqualToString:@"Quantidade"]) {
            [[cell textLabel] setText:@"Quantidade"];
            [[cell detailTextLabel] setText:[NSString stringWithFormat:@"%@", historicoRem.qtda]];
        } else if ([itemStr isEqualToString:@"Perfil"]) {
            [[cell textLabel] setText:@"Perfil"];
            [[cell detailTextLabel] setText:[NSString stringWithFormat:@"%@", historicoRem.pessoa.nome]];
            
//            [cell setBackgroundColor:[managerPessoa corDaPessoa:historicoRem.pessoa]];
            
//            UIView *corView = [managerPessoa criarViewCorBolinhaDaPessoa:historicoRem.pessoa naPosicao:CGPointMake(60, 14)];
//            [[cell contentView] addSubview:corView];
            UIView *corView = [managerPessoa criarViewCorBolinhaDaPessoa:historicoRem.pessoa naPosicao:CGPointMake(0, 0)];
            [cell setAccessoryView:corView];
        }
    } else if ([sectionStr isEqualToString:@"Controle"]) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        
        NSString *itemStr = [tableViewControle objectAtIndex:indexPath.row];
        if ([itemStr isEqualToString:@"LblQtdEventos"]) {
            [[cell textLabel] setText:@"Quantidade de eventos"];
            [[cell detailTextLabel] setText:[NSString stringWithFormat:@"%d", [managerRemedio qtdEventosDoHistoricoRem:historicoRem]]];
        } else if ([itemStr isEqualToString:@"LblProximoEvento"]) {
            [[cell textLabel] setText:@"Próximo evento"];
            if ([managerRemedio jaTerminouHistoricoRem:historicoRem]) {
                [[cell detailTextLabel] setText:@"Já terminou"];
            } else if ([managerRemedio jaIniciouHistoricoRem:historicoRem]) {
                [[cell detailTextLabel] setText:[dateTimeFormatter stringFromDate:[managerRemedio proximaDataDoHistoricoRem:historicoRem]]];
            } else {
                [[cell detailTextLabel] setText:@"Ainda não começou"];
            }
        } else if ([itemStr isEqualToString:@"BtnNotificacoesEventos"]) {
            UISwitch *btnNotificacoes = [[UISwitch alloc] init];
            [btnNotificacoes addTarget:self action:@selector(changeSwitchNotification:) forControlEvents:UIControlEventValueChanged];
            btnNotificacoes.on = [historicoRem.notificacao boolValue];
            
            [[cell textLabel] setText:@"Notificações"];
            [cell setAccessoryView:btnNotificacoes];
        } else if ([itemStr isEqualToString:@"BtnNotificacoes"]) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            
            [[cell textLabel] setText:@"Notificações agendadas"];
            [[cell textLabel] setTextAlignment:NSTextAlignmentCenter];
        } else if ([itemStr isEqualToString:@"BtnTomarRemedio"]) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            
            [[cell textLabel] setText:@"Tomar remédio"];
            [[cell textLabel] setTextAlignment:NSTextAlignmentCenter];
        }
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height;
    
    height = 50.0;
    
    return height;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCellEditingStyle editingStyle;
    
    editingStyle = UITableViewCellEditingStyleNone;
    
    return editingStyle;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    RemedioManager *managerRemedio = [RemedioManager sharedInstance];
    
    NSString *sectionStr = [tableViewSections objectAtIndex:indexPath.section];
    if ([sectionStr isEqualToString:@"Dados"]) {
        NSString *itemStr = [tableViewItens objectAtIndex:indexPath.row];
        
        if ([itemStr isEqualToString:@"Perfil"]) {
            ListaPerfilViewController *perfilViewController = [[ListaPerfilViewController alloc] init];
            
            perfilViewController.modoTela = @"telaSelecionarPerfil";
            perfilViewController.refObjetoSelecionarPerfil = historicoRem;
            
            [[self navigationController] pushViewController:perfilViewController animated:YES];
        } else {
            CampoViewController *campoViewController = [[CampoViewController alloc] init];
            campoViewController.refObjeto = historicoRem;
            
            if ([itemStr isEqualToString:@"Data"]) {
                campoViewController.tipo = @"dataHora";
                campoViewController.nomeAtributo = @"dataInicio";
            } else if ([itemStr isEqualToString:@"Duração"]) {
                campoViewController.tipo = @"unidadeDeTempo";
                campoViewController.nomeAtributo = @"duracao";
            } else if ([itemStr isEqualToString:@"Frequência"]) {
                campoViewController.tipo = @"unidadeDeTempo";
                campoViewController.nomeAtributo = @"frequencia";
            } else if ([itemStr isEqualToString:@"Quantidade"]) {
                campoViewController.tipo = @"int";
                campoViewController.nomeAtributo = @"qtda";
            }
            
            campoViewController.title = itemStr;
            
            [[self navigationController] pushViewController:campoViewController animated:YES];
        }
    } else if ([sectionStr isEqualToString:@"Controle"]) {
        NSString *itemStr = [tableViewControle objectAtIndex:indexPath.row];
        
        if ([itemStr isEqualToString:@"LblQtdEventos"]) {
            
            UIView *viewPopup = [self criarViewPopup];
            
            UITableView *tableViewItensEventos = [[UITableView alloc] init];
            [tableViewItensEventos setFrame:CGRectMake(0, 0, viewPopup.frame.size.width, viewPopup.frame.size.height)];
            [tableViewItensEventos setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
            self.tableViewItensEventosSource = [[TableViewItensEventoSource alloc] initWithEvento:historicoRem];
            [tableViewItensEventos setDelegate:self.tableViewItensEventosSource];
            [tableViewItensEventos setDataSource:self.tableViewItensEventosSource];
            [viewPopup addSubview:tableViewItensEventos];
            
        } else if ([itemStr isEqualToString:@"BtnNotificacoes"]) {
            
            NSMutableArray *notifications = [[NSMutableArray alloc] init];
            
            NSDateFormatter *dateTimeFormatter = [[NSDateFormatter alloc] init];
            [dateTimeFormatter setDateStyle:NSDateFormatterMediumStyle];
            [dateTimeFormatter setTimeStyle:NSDateFormatterShortStyle];
            for (UILocalNotification *notification in [[UIApplication sharedApplication] scheduledLocalNotifications]) {
                [notifications addObject:[NSString stringWithFormat:@"%@ %@", [dateTimeFormatter stringFromDate:notification.fireDate], notification.alertBody]];
            }
            
            UIView *viewPopup = [self criarViewPopup];
            
            UITableView *tableViewNotifications = [[UITableView alloc] init];
            [tableViewNotifications setFrame:CGRectMake(0, 0, viewPopup.frame.size.width, viewPopup.frame.size.height)];
            [tableViewNotifications setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
            self.tableViewNotificationsSource = [[MMTableViewSource alloc] initWithArray:notifications];
            [tableViewNotifications setDelegate:self.tableViewNotificationsSource];
            [tableViewNotifications setDataSource:self.tableViewNotificationsSource];
            [viewPopup addSubview:tableViewNotifications];
            
        } else if ([itemStr isEqualToString:@"BtnTomarRemedio"]) {
            if ([managerRemedio tomarRemedioDoHistoricoRem:historicoRem]) {
                [managerRemedio saveContext];
                
                UIAlertView *msg = [[UIAlertView alloc] initWithTitle:@"OK" message:@"Remédio contabilizado!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [msg show];
                
//                [[NSNotificationCenter defaultCenter] postNotificationName:@"atualizarTableView" object:nil];
            } else {
                UIAlertView *msg = [[UIAlertView alloc] initWithTitle:@"Aviso" message:@"Não existe remédio suficiente!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [msg show];
            }
        }
    }
}

#pragma mark - Método para a popup

- (UIView *)criarViewPopup
{
    UIView *viewPopup = [[UIView alloc] init];
    [viewPopup setFrame:CGRectMake(10, 10, self.view.frame.size.width-20, self.view.frame.size.height-20)];
    [viewPopup setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
    [viewPopup setBackgroundColor:[UIColor whiteColor]];
    viewPopup.layer.cornerRadius = 5;
    viewPopup.layer.shadowOpacity = 0.8;
    viewPopup.layer.shadowOffset = CGSizeMake(0.0f, 0.0f);
    
    UIBarButtonItem *closeButton = [[UIBarButtonItem alloc]
                                    initWithBarButtonSystemItem:(UIBarButtonSystemItemStop)
                                    target:self
                                    action:@selector(removePopupAnimate:)];
    [[self navigationItem] setRightBarButtonItem:closeButton];
    [viewPopup setTag:1];
    
    [self.view addSubview:viewPopup];
    self.view.transform = CGAffineTransformMakeScale(1.3, 1.3);
    self.view.alpha = 0;
    [UIView animateWithDuration:.25 animations:^{
        self.view.alpha = 1;
        self.view.transform = CGAffineTransformMakeScale(1, 1);
    }];
    
    return viewPopup;
}

- (void)removePopupAnimate:(id)sender
{
    UIView *view = [self.view viewWithTag:1];
    
    [[self navigationItem] setRightBarButtonItem:nil];
    
    [UIView animateWithDuration:.25 animations:^{
        view.transform = CGAffineTransformMakeScale(1.3, 1.3);
        view.alpha = 0.0;
    } completion:^(BOOL finished) {
        if (finished) {
            [view removeFromSuperview];
        }
    }];
}

#pragma mark - Método para controlar as notificações

- (void)changeSwitchNotification:(id)sender
{
    UISwitch *btnNotificacoes = (UISwitch *)sender;
    
    NotificationManager *managerNotification = [NotificationManager sharedInstance];
    
    historicoRem.notificacao = [NSNumber numberWithBool:btnNotificacoes.on];
    
    if ([managerNotification temPermissaoParaEnivarNotificacao]) {
        [managerNotification criarItensEventoNotificacao];
    } else if (btnNotificacoes.on) {
        UIAlertView *msg = [[UIAlertView alloc] initWithTitle:@"Aviso" message:@"Você precisa permitir notificações deste aplicativo!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [msg show];
        
        [managerNotification solicitarPermissaoDeNotificacao];
        
        [btnNotificacoes setOn:NO animated:YES];
    }
    
    historicoRem.notificacao = [NSNumber numberWithBool:btnNotificacoes.on];
    
    [managerNotification saveContext];
}

#pragma mark - Selectors dos botões da navigationBar

- (void)selBtnCancelar:(id)sender
{
    RemedioManager *manager = [RemedioManager sharedInstance];
    [manager deletarHistoricoRem:historicoRem];
//    [[manager getContext] rollback];
//    [[manager getContext] refreshObject:historicoRem mergeChanges:NO];
    
    [self removerTela];
}

- (void)selBtnAdicionar:(id)sender
{
    RemedioManager *manager = [RemedioManager sharedInstance];
    
    [manager saveContext];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"atualizarViewLembretesIndex" object:nil];
    
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
    [[NSNotificationCenter defaultCenter] postNotificationName:@"tableViewRemedioReloadData" object:nil];
}

#pragma mark - Métodos do NotificationCenter para atualizar tableView

- (void)tableViewReloadData:(NSNotification *)notification {
    [tableViewConteudo reloadData];
}

@end
