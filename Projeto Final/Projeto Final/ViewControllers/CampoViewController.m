//
//  CampoViewController.m
//  Projeto Final
//
//  Created by Lucas Saito on 08/09/14.
//  Copyright (c) 2014 Mack Mobile - BEPiD. All rights reserved.
//

#import "CampoViewController.h"
#import "UnidadeDeTempoManager.h"
#import "EventoRepeticao.h"

CGFloat tamanhoCelula = 40.0;

@interface CampoViewController ()
{
    id campo;
    UITableView *tableView;
    NSArray *itensLista;
}

@end

@implementation CampoViewController

@synthesize tipo, refObjeto, nomeAtributo;

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
    // Do any additional setup after loading the view.
    
    //Botão de Cancelar
    UIBarButtonItem *barButtonCancel = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(selBtnCancel:)];
    [[self navigationItem] setLeftBarButtonItem:barButtonCancel];
    
    //Botão de Ok
    UIBarButtonItem *barButtonDone = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(selBtnDone:)];
    [[self navigationItem] setRightBarButtonItem:barButtonDone];
    
    UIView *viewMain = [self criarView:self.view.frame.size.height];
    
    [viewMain setBackgroundColor:[UIColor colorWithRed:239/255.0f green:239/255.0f blue:244/255.0f alpha:1.0]];
    
    UIView *viewCampo = [MMView criarRetangulo:CGRectMake(0, 40, self.view.frame.size.width, tamanhoCelula)];
    [viewCampo setBackgroundColor:[UIColor whiteColor]];
    
    if ([tipo isEqualToString:@"texto"]) {
        campo = [self criarTextFieldNaView:viewCampo comTexto:[refObjeto valueForKey:nomeAtributo]];
        
        UITextField *textField = (UITextField *)campo;
        [textField setFrame:CGRectMake(textField.frame.origin.x, textField.frame.origin.y, textField.frame.size.width-40, textField.frame.size.height)];
        UIButton *clearButton = [[UIButton alloc] init];
        clearButton.frame = CGRectMake(textField.frame.origin.x + textField.frame.size.width + 10, textField.frame.origin.y + 5, 30, 30);
        [clearButton addTarget:self action:@selector(clear:) forControlEvents:UIControlEventTouchDown];
        [clearButton setImage:[UIImage imageNamed:@"borracha_branco.png"] forState:UIControlStateNormal];
        clearButton.layer.cornerRadius = 13;
        if (self.navigationController.navigationBar.barTintColor == nil) {
            clearButton.backgroundColor = [UIColor blackColor];
        }else{
            clearButton.backgroundColor = self.navigationController.navigationBar.barTintColor;
        }
        
        [viewCampo addSubview:clearButton];
        [campo becomeFirstResponder];
    } else if ([tipo isEqualToString:@"int"]) {
        campo = [self criarTextFieldNaView:viewCampo comTexto:[NSString stringWithFormat:@"%@", [refObjeto valueForKey:nomeAtributo]]];
        [campo setKeyboardType:UIKeyboardTypeNumberPad];
        [campo becomeFirstResponder];
    } else if ([tipo isEqualToString:@"simNaoSwitch"]) {
        campo = [self criarSwitchNaView:viewCampo comLabel:self.title];
        ((UISwitch *)campo).on = [(NSNumber *)[refObjeto valueForKey:nomeAtributo] boolValue];
        [viewCampo setFrame:CGRectMake(viewCampo.frame.origin.x, viewCampo.frame.origin.y, viewCampo.frame.size.width, 50)];
    } else if ([tipo isEqualToString:@"simNaoSegmented"]) {
        campo = [self criarSegmentedControlNaView:viewCampo comValores:[NSArray arrayWithObjects:@"Sim", @"Não", nil]];
        NSNumber *valor = (NSNumber *)[refObjeto valueForKey:nomeAtributo];
        NSInteger selecionado;
        if (valor == [NSNumber numberWithInt:1]) {
            selecionado = 0;
        } else {
            selecionado = 1;
        }
        ((UISegmentedControl *)campo).selectedSegmentIndex = selecionado;
    } else if ([tipo isEqualToString:@"simNaoTableView"]) {
        itensLista = [NSArray arrayWithObjects:@"Sim", @"Não", nil];
        
        [viewCampo setFrame:CGRectMake(viewCampo.frame.origin.x, viewCampo.frame.origin.y, viewCampo.frame.size.width, itensLista.count * tamanhoCelula)];
        
        tableView = [self criarTableViewNaView:viewCampo comAltura:viewCampo.frame.size.height];
        [viewCampo addSubview:tableView];
        
        campo = (NSNumber *)[refObjeto valueForKey:nomeAtributo];
    } else if ([tipo isEqualToString:@"data"]) {
        campo = [self criarTextFieldDataNaView:viewCampo comData:[refObjeto valueForKey:nomeAtributo]];
        [campo becomeFirstResponder];
    } else if ([tipo isEqualToString:@"dataHora"]) {
        campo = [self criarTextFieldDataHoraNaView:viewCampo comDataHora:[refObjeto valueForKey:nomeAtributo]];
        [campo becomeFirstResponder];
    } else if ([tipo isEqualToString:@"unidadeDeTempo"]) {
        UITextField *textField = [self criarTextFieldNaView:viewCampo comTexto:nil];
        campo = [self criarPickerViewNoTextField:textField comUnidadeDeTempo:[refObjeto valueForKey:nomeAtributo]];
        [textField becomeFirstResponder];
    } else if ([tipo isEqualToString:@"listaTipoRemedio"]) {
        itensLista = [NSArray arrayWithObjects:@"Pílula", @"Líquido", @"Injeção", @"Pomada", nil];
        
        [viewCampo setFrame:CGRectMake(viewCampo.frame.origin.x, viewCampo.frame.origin.y, viewCampo.frame.size.width, itensLista.count * tamanhoCelula)];
        
        tableView = [self criarTableViewNaView:viewCampo comAltura:viewCampo.frame.size.height];
        [viewCampo addSubview:tableView];
        
        campo = (NSNumber *)[refObjeto valueForKey:nomeAtributo];
    }
    
    [viewMain addSubview:viewCampo];
}

- (void)viewWillAppear:(BOOL)animated
{
    if ([tipo isEqualToString:@"simNaoTableView"]) {
        NSInteger selecionado;
        if ([campo boolValue]) {
            selecionado = 0; //SIM
        } else {
            selecionado = 1; //NAO
        }
        [tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:selecionado inSection:0] animated:NO scrollPosition:UITableViewScrollPositionNone];
    } else if ([tipo isEqualToString:@"listaTipoRemedio"]) {
//        NSInteger selecionado;
//        for (int i=0; i<itensLista.count; i++) {
//            if ([[itensLista objectAtIndex:i] isEqualToString:campo]) {
//                selecionado = i;
//                break;
//            }
//        }
        [tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:[itensLista indexOfObject:campo] inSection:0] animated:NO scrollPosition:UITableViewScrollPositionNone];
    }
}

- (void)viewDidDisappear:(BOOL)animated
{
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self selBtnDone:nil];
    return YES;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    NSInteger numRows;
    
    if ([tipo isEqualToString:@"simNaoTableView"]) {
        numRows = itensLista.count;
    } else if ([tipo isEqualToString:@"listaTipoRemedio"]) {
        numRows = itensLista.count;
    }
    
    return numRows;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height;
    
    height = tamanhoCelula;
    
    return height;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCellEditingStyle editingStyle;
    
    editingStyle = UITableViewCellEditingStyleNone;
    
    return editingStyle;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    [cell setAccessoryType:UITableViewCellAccessoryNone];
    
    if ([tipo isEqualToString:@"simNaoTableView"]) {
        switch (indexPath.row) {
            case 0:
                [[cell textLabel] setText:@"Sim"];
                break;
            case 1:
                [[cell textLabel] setText:@"Não"];
                break;
            default:
                break;
        }
    } else if ([tipo isEqualToString:@"listaTipoRemedio"]) {
        [[cell textLabel] setText:[itensLista objectAtIndex:indexPath.row]];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([tipo isEqualToString:@"simNaoTableView"]) {
        switch (indexPath.row) {
            case 0:
                campo = [NSNumber numberWithBool:YES];
                break;
            case 1:
                campo = [NSNumber numberWithBool:NO];
                break;
            default:
                break;
        }
    } else if ([tipo isEqualToString:@"listaTipoRemedio"]) {
        campo = [itensLista objectAtIndex:indexPath.row];
    }
    
    [self selBtnDone:nil];
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

#pragma mark - Métodos
- (void)clear: (id)sender
{
    ((UITextField *)campo).text = @"";
}

- (void)cancelar
{
    if ([tipo isEqualToString:@"unidadeDeTempo"]) {
        MMPickerView *mmPickerView = (MMPickerView *)campo;
        UnidadeDeTempo *unidadeDeTempo = mmPickerView.unidadeDeTempo;
        
        UnidadeDeTempoManager *manager = [UnidadeDeTempoManager sharedInstance];
        
        if (unidadeDeTempo) {
            if ([refObjeto valueForKey:nomeAtributo]) {
                [manager deletarUnidadeDeTempo:unidadeDeTempo];
            } else {
                [[manager getContext] refreshObject:unidadeDeTempo mergeChanges:NO];
            }
        }
    }
}

- (void)salvar
{
    if ([tipo isEqualToString:@"texto"]) {
        UITextField *textField = (UITextField *)campo;
        
        [refObjeto setValue:textField.text forKey:nomeAtributo];
    } else if ([tipo isEqualToString:@"int"]) {
        UITextField *textField = (UITextField *)campo;
        
        NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
        [numberFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
        NSNumber *numero = [numberFormatter numberFromString:textField.text];
        
        [refObjeto setValue:numero forKey:nomeAtributo];
    } else if ([tipo isEqualToString:@"simNaoSwitch"]) {
        UISwitch *onoff = (UISwitch *)campo;
        
        [refObjeto setValue:[NSNumber numberWithBool:onoff.on] forKey:nomeAtributo];
    } else if ([tipo isEqualToString:@"simNaoSegmented"]) {
        UISegmentedControl *segmentedControl = (UISegmentedControl *)campo;
        
        NSInteger valor = segmentedControl.selectedSegmentIndex;
        BOOL generico;
        if (valor == 0) {
            generico = YES;
        } else {
            generico = NO;
        }
        
        [refObjeto setValue:[NSNumber numberWithBool:generico] forKey:nomeAtributo];
    } else if ([tipo isEqualToString:@"simNaoTableView"]) {
        [refObjeto setValue:campo forKey:nomeAtributo];
    } else if ([tipo isEqualToString:@"data"]) {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateStyle: NSDateFormatterMediumStyle];
        
        UITextField *textField = (UITextField *)campo;
        
        NSDate *data = [dateFormatter dateFromString:textField.text];
        
        [refObjeto setValue:data forKey:nomeAtributo];
    } else if ([tipo isEqualToString:@"dataHora"]) {
        NSDateFormatter *dateTimeFormatter = [[NSDateFormatter alloc] init];
        [dateTimeFormatter setDateStyle: NSDateFormatterMediumStyle];
        [dateTimeFormatter setTimeStyle: NSDateFormatterShortStyle];
        
        UITextField *textField = (UITextField *)campo;
        
        NSDate *data = [dateTimeFormatter dateFromString:textField.text];
        
        [refObjeto setValue:data forKey:nomeAtributo];
    } else if ([tipo isEqualToString:@"unidadeDeTempo"]) {
        MMPickerView *mmPickerView = (MMPickerView *)campo;
        UnidadeDeTempo *unidadeDeTempo = mmPickerView.unidadeDeTempo;
        
        [refObjeto setValue:unidadeDeTempo forKey:nomeAtributo];
    } else if ([tipo isEqualToString:@"listaTipoRemedio"]) {
        [refObjeto setValue:campo forKey:nomeAtributo];
    }
    
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"atualizarTableView" object:nil];
    
//    if ([refObjeto isKindOfClass:[EventoRepeticao class]]) {
//        [[NSNotificationCenter defaultCenter] postNotificationName:@"atualizarViewLembretesIndex" object:nil];
//    }
}

#pragma mark - Selectors dos botões da navigationBar

- (void)selBtnCancel:(id)sender
{
    [self cancelar];
    
    [[self navigationController] popViewControllerAnimated:YES];
}

- (void)selBtnDone:(id)sender
{
    [self salvar];
    
    UnidadeDeTempoManager *manager = [UnidadeDeTempoManager sharedInstance];
    [manager saveContext];
    
    [[self navigationController] popViewControllerAnimated:YES];
}

#pragma mark - Selector do botão da toolbar (PickerView)

- (void)selBtnDonePickerView:(id)sender
{
    [self selBtnDone:sender];
}

@end
