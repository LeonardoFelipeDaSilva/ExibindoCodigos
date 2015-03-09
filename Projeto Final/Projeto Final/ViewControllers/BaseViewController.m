//
//  BaseViewController.m
//  Projeto Final
//
//  Created by Lucas Saito on 29/08/14.
//  Copyright (c) 2014 Mack Mobile - BEPiD. All rights reserved.
//

#import "BaseViewController.h"
#import "UnidadeDeTempoManager.h"

@interface BaseViewController (){
    NSMutableArray *itensActionSheet;
}

@end

@implementation BaseViewController

static int MARGEM_X = 10; //margem lateral
static int MARGEM_Y = 10; //margem vertical

#define AS_IMAGEVIEW 1
#define AS_CONFIRMA 2

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
    
    mainView = [[UIScrollView alloc] init];
    [mainView setFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [mainView setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
    
    [self.view addSubview:mainView];
    
    posicaoY = 0;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Delegates

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
}

#pragma mark - Métodos para criação dos elementos UI

- (UIView *)criarView:(CGFloat)altura
{
    UIView *view = [MMView criarRetangulo:CGRectMake(0, posicaoY, self.view.frame.size.width, altura)];
    [view setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
    
    [mainView addSubview:view];
    
    posicaoY += view.frame.size.height;
    
    return view;
}

- (UIView *)criarViewSubTituloNaView:(UIView *)view comLabel:(NSString *)texto
{
    UIView *viewTitulo = [MMView criarRetanguloTitulo:CGRectMake(MARGEM_X, MARGEM_Y, view.frame.size.width - (2*MARGEM_X), 20)];
    
    UILabel *lbl = [MMLabel criarTitulo:CGRectMake(MARGEM_X, 0, viewTitulo.frame.size.width, viewTitulo.frame.size.height)];
    [lbl setText:texto];
    [viewTitulo addSubview:lbl];
    
    [view addSubview:viewTitulo];
    
    return viewTitulo;
}

- (UILabel *)criarLabelNaView:(UIView *)view comLabel:(NSString *)label comTexto:(NSString *)texto
{
    UILabel *lblLabel = [MMLabel criarObjeto:CGRectMake(MARGEM_X, MARGEM_Y, 80, view.frame.size.height-(2*MARGEM_Y))];
    [lblLabel setFont:[UIFont boldSystemFontOfSize:14.0]];
    [lblLabel setText:[NSString stringWithFormat:@"%@:", label]];
    
    UILabel *lblTexto = [MMLabel criarObjeto:CGRectMake((MARGEM_X+lblLabel.frame.size.width), MARGEM_Y, view.frame.size.width-((2*MARGEM_X)+lblLabel.frame.size.width), lblLabel.frame.size.height)];
    [lblTexto setText:texto];
    
//    [lblLabel setBackgroundColor:[UIColor redColor]];
//    [lblTexto setBackgroundColor:[UIColor blueColor]];
//    [view setBackgroundColor:[UIColor greenColor]];
    
    [view addSubview:lblLabel];
    [view addSubview:lblTexto];
    
    return lblTexto;
}

- (UITableView *)criarTableViewNaView:(UIView *)view comAltura:(CGFloat)altura
{
    UITableView *tableView = [[UITableView alloc] init];
    
    [tableView setFrame:CGRectMake(0, 0, view.frame.size.width, altura)];
    [tableView setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
    
    [tableView setDelegate:self];
    [tableView setDataSource:self];
    
    return tableView;
}

- (UIImageView *)criarImageViewBlurNaView:(UIView *)view
{
    UIImageView *imageView = [MMImageView criarObjetoRetangulo:CGRectMake(0, -(view.frame.size.width-view.frame.size.height), view.frame.size.width, view.frame.size.width)];
    
    [imageView setBackgroundColor:[UIColor grayColor]];
    
//    UIScrollView *scrollView = [[UIScrollView alloc] init];
//    [scrollView setFrame:CGRectMake(0, 0, view.frame.size.width, view.frame.size.height)];
//    [scrollView setContentSize:CGSizeMake(view.frame.size.width, view.frame.size.width)];
//    
//    [scrollView addSubview:imageView];
//    [view addSubview:scrollView];
    
    [view addSubview:imageView];
    
    return imageView;
}

- (UIImageView *)criarImageViewIconeNaView:(UIView *)view
{
    UIImageView *imageView = [MMImageView criarObjetoRedondo:CGRectMake((view.frame.size.width/2)-50, (view.frame.size.height/2)-50, 100, 100)];
    
    [view addSubview:imageView];
    
    return imageView;
}

- (UITextField *)criarTextFieldNaView:(UIView *)view comLabel:(NSString *)label
{
    UITextField *textField = [MMTextField criarObjeto:CGRectMake(MARGEM_X, MARGEM_Y, self.view.frame.size.width-30, 30)];
    
    [textField setPlaceholder:label];
    [textField setDelegate:self];
    
    [view addSubview:textField];
    
    return textField;
}

- (UITextField *)criarTextFieldNaView:(UIView *)view comTexto:(NSString *)texto
{
    UITextField *textField = [MMTextField criarObjeto:CGRectMake(MARGEM_X, 0, view.frame.size.width-(2*MARGEM_X), view.frame.size.height)];
    
    [textField setText:texto];
    [textField setDelegate:self];
    
    [view addSubview:textField];
    
    return textField;
}

- (UITextField *)criarTextFieldDataNaView:(UIView *)view comData:(NSDate *)data
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle: NSDateFormatterMediumStyle]; //Choose the appropriate style for your case
    
    NSString *strData = [dateFormatter stringFromDate:data];
    
    UITextField *textField = [self criarTextFieldNaView:view comTexto:strData];
    
    MMDatePicker *datePicker = [[MMDatePicker alloc] init];
    datePicker.label = textField;
    
    [datePicker setDatePickerMode:UIDatePickerModeDate];
    [datePicker addTarget:self action:@selector(updateTextFieldData:) forControlEvents:UIControlEventAllEvents];
    if (data) {
        [datePicker setDate:data];
    }
    
    [textField setInputView:datePicker];
    
    return textField;
}

- (void)updateTextFieldData:(id)sender {
    MMDatePicker *datePicker = (MMDatePicker *)sender;
    UITextField *textField = datePicker.label;
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle: NSDateFormatterMediumStyle]; //Choose the appropriate style for your case
    
    textField.text = [dateFormatter stringFromDate:datePicker.date];
}

- (UITextField *)criarTextFieldDataHoraNaView:(UIView *)view comDataHora:(NSDate *)dataHora
{
    NSDateFormatter *dateTimeFormatter = [[NSDateFormatter alloc] init];
    [dateTimeFormatter setDateStyle: NSDateFormatterMediumStyle]; //Choose the appropriate style for your case
    [dateTimeFormatter setTimeStyle: NSDateFormatterShortStyle];
    
    NSString *strDataHora = [dateTimeFormatter stringFromDate:dataHora];
    
    UITextField *textField = [self criarTextFieldNaView:view comTexto:strDataHora];
    
    MMDatePicker *datePicker = [[MMDatePicker alloc] init];
    datePicker.label = textField;
    
    [datePicker setDatePickerMode:UIDatePickerModeDateAndTime];
    [datePicker addTarget:self action:@selector(updateTextFieldDataHora:) forControlEvents:UIControlEventAllEvents];
    if (dataHora) {
        [datePicker setDate:dataHora];
    }
    
    [textField setInputView:datePicker];
    
    return textField;
}

- (void)updateTextFieldDataHora:(id)sender {
    MMDatePicker *datePicker = (MMDatePicker *)sender;
    UITextField *textField = datePicker.label;
    
    NSDateFormatter *dateTimeFormatter = [[NSDateFormatter alloc] init];
    [dateTimeFormatter setDateStyle: NSDateFormatterMediumStyle]; //Choose the appropriate style for your case
    [dateTimeFormatter setTimeStyle: NSDateFormatterShortStyle];
    
    textField.text = [dateTimeFormatter stringFromDate:datePicker.date];
}

- (UISwitch *)criarSwitchNaView:(UIView *)view comLabel:(NSString *)texto
{
    UISwitch *btn = [[UISwitch alloc] init];
    [btn setFrame:CGRectMake(MARGEM_X, MARGEM_Y, btn.frame.size.width, btn.frame.size.height)];
    [view addSubview:btn];
    
    UILabel *lbl = [MMLabel criarObjeto:CGRectMake(btn.frame.origin.x + btn.frame.size.width + 15, btn.frame.origin.y, view.frame.size.width - (btn.frame.size.width + 30), 30)];
    [lbl setText:texto];
    [view addSubview:lbl];
    
    return btn;
}

- (UISegmentedControl *)criarSegmentedControlNaView:(UIView *)view comValores:(NSArray *)valores
{
    UISegmentedControl *segmentedControl = [[UISegmentedControl alloc] init];
    
    [segmentedControl setFrame:CGRectMake(0, 0, 100, 30)];
    [segmentedControl setCenter:CGPointMake(view.frame.size.width/2, view.frame.size.height/2)];
    
    for (int i=0; i<valores.count; i++) {
        [segmentedControl insertSegmentWithTitle:[valores objectAtIndex:i] atIndex:i animated:NO];
    }
    
    [view addSubview:segmentedControl];
    
    return segmentedControl;
}

- (UIPickerView *)criarPickerViewNoTextField:(UITextField *)textField comUnidadeDeTempo:(UnidadeDeTempo *)unidadeDeTempo
{
    MMPickerView *pickerView = [[MMPickerView alloc] init];
    [pickerView setDelegate:self];
    [pickerView setDataSource:self];
    [pickerView setShowsSelectionIndicator:YES];
    pickerView.label = textField;
    pickerView.unidadeDeTempo = unidadeDeTempo;
    
    if (unidadeDeTempo) {
        //selecionar os valores salvos
        NSInteger dezena = (([unidadeDeTempo.quantidade intValue]%100)/10);
        NSInteger unidade = (([unidadeDeTempo.quantidade intValue]%100)%10);
        
        [pickerView selectRow:dezena inComponent:0 animated:NO];
        [pickerView selectRow:unidade inComponent:1 animated:NO];
        [pickerView selectRow:[unidadeDeTempo.unidade integerValue] inComponent:2 animated:NO];
    }
    
    UIToolbar *toolbar = [[UIToolbar alloc] init];
    [toolbar setFrame:CGRectMake(0, self.view.frame.size.height - pickerView.frame.size.height - 50, self.view.frame.size.width, 50)];
    [toolbar setBarStyle:UIBarStyleBlackOpaque];
    
    UIBarButtonItem *btnDone = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(selBtnDonePickerView:)];
    [toolbar setItems:@[btnDone]];
    
    [textField setInputView:pickerView];
    [textField setInputAccessoryView:toolbar];
    
    UnidadeDeTempoManager *manager = [UnidadeDeTempoManager sharedInstance];
    [textField setText:[manager criarLabel:unidadeDeTempo]];
    
    return pickerView;
}

- (UIView *)criarViewBtnAdicionarNaView:(UIView *)view comLabel:(NSString *)texto
{
    UIView *viewBtn = [MMView criarRetangulo:CGRectMake(MARGEM_X, view.frame.size.height, self.view.frame.size.width - (2*MARGEM_X), 30)];
    
    [viewBtn setBackgroundColor:[UIColor yellowColor]];
    
    UILabel *lblBtn = [MMLabel criarBtn:CGRectMake(MARGEM_X, 0, viewBtn.frame.size.width - (2*MARGEM_X), 30)];
    [lblBtn setText:texto];
    [viewBtn addSubview:lblBtn];
    
    [view setFrame:CGRectMake(view.frame.origin.x, view.frame.origin.y, view.frame.size.width, view.frame.size.height + viewBtn.frame.size.height + MARGEM_Y)];
    [view addSubview:viewBtn];
    
    return viewBtn;
}

#pragma mark - Table view data source (TableView: tableViewConteudo)

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}

#pragma mark - Métodos dos selector's

- (void)toqueImageView:(id)sender {
    MMTapGestureRecognizer *tapGestureRecognizerComObjeto = (MMTapGestureRecognizer *)sender;
    id objeto = tapGestureRecognizerComObjeto.objeto;
    
    if ([objeto isKindOfClass:[UIImageView class]]) {
        UIImageView *imageView = (UIImageView *)objeto;
        
        refImageViewPicker = imageView;
        
        UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles: nil];
        
        itensActionSheet = [[NSMutableArray alloc] init];
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            [itensActionSheet addObject:@"Tirar uma foto"];
        }
        [itensActionSheet addObject:@"Escolher da biblioteca"];
        if (refImageViewPicker.image) {
            [itensActionSheet addObject:@"Remover imagem"];
            actionSheet.destructiveButtonIndex = itensActionSheet.count - 1;
        }
        [itensActionSheet addObject:@"Cancelar"];
        actionSheet.cancelButtonIndex = itensActionSheet.count - 1;
        
        for (NSString *botao in itensActionSheet) {
            [actionSheet addButtonWithTitle:botao];
        }
        
        actionSheet.tag = AS_IMAGEVIEW;
        [actionSheet showInView:[UIApplication sharedApplication].keyWindow];
    }
}

#pragma mark - Método para executar as ações da UIActionSheet
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    switch (actionSheet.tag) {
        case AS_IMAGEVIEW: {
            NSString *botao = [itensActionSheet objectAtIndex:buttonIndex];
            if ([botao isEqualToString:@"Tirar uma foto"]) {
                [self exibirImagePickerController:true];
            } else if ([botao isEqualToString:@"Escolher da biblioteca"]) {
                [self exibirImagePickerController:false];
            } else if ([botao isEqualToString:@"Remover imagem"]) {
                UIActionSheet *actionSheetConfirma = [[UIActionSheet alloc] initWithTitle:@"Tem certeza que deseja remover a imagem?" delegate:self cancelButtonTitle:@"Não" destructiveButtonTitle:@"Sim" otherButtonTitles:nil];
                actionSheetConfirma.destructiveButtonIndex = 0;
                actionSheetConfirma.tag = AS_CONFIRMA;
                [actionSheetConfirma showInView:[UIApplication sharedApplication].keyWindow];
            }
            break;
        }
        case AS_CONFIRMA: {
            if (buttonIndex == 0) { //SIM
                refImageViewPicker.image = nil;
                [[NSNotificationCenter defaultCenter] postNotificationName:@"atualizarImagemImageView" object:refImageViewPicker];
            }
            break;
        }
        default:
            break;
    }
}

#pragma mark - Métodos do ImagePickerController

- (void)exibirImagePickerController:(BOOL)sourceCamera
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    
    [picker setDelegate:self];
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera] && sourceCamera) {
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    }else{
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    
    [picker setAllowsEditing:YES];
    
    [self presentViewController:picker animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    UIImage *originalImage = nil;
    originalImage = [info objectForKey:UIImagePickerControllerEditedImage];
    if (originalImage == nil) {
        originalImage = [info objectForKey:UIImagePickerControllerOriginalImage];
    }
    if (originalImage == nil) {
        originalImage = [info objectForKey:UIImagePickerControllerCropRect];
    }
    
    //At this point you have the selected image in originalImage
    refImageViewPicker.image = originalImage;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"atualizarImagemImageView" object:refImageViewPicker];
}

#pragma mark - Data source do PickerView

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    UnidadeDeTempoManager *manager = [UnidadeDeTempoManager sharedInstance];
    
    if (component == 2) {
        return [manager quantidadeDeUnidades];
    } else {
        return 10;
    }
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    if (component == 2) {
        return 150;
    } else {
        return 30;
    }
}

#pragma mark - Delegate do PickerView

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    MMPickerView *mmPickerView = (MMPickerView *)pickerView;
    
    UnidadeDeTempoManager *manager = [UnidadeDeTempoManager sharedInstance];
    
    if (!mmPickerView.unidadeDeTempo) {
        mmPickerView.unidadeDeTempo = [manager criarUnidadeDeTempo];
    }
    
    if (component == 2) {
        mmPickerView.unidadeDeTempo.unidade = [NSNumber numberWithInteger:row];
    } else {
        NSInteger dezena = [pickerView selectedRowInComponent:0];
        NSInteger unidade = [pickerView selectedRowInComponent:1];
        mmPickerView.unidadeDeTempo.quantidade = [NSNumber numberWithInt:(((int)dezena*10) + (int)unidade)];
        [pickerView reloadComponent:2]; //para atualizar o singular/plural
    }
    
    mmPickerView.label.text = [manager criarLabel:mmPickerView.unidadeDeTempo];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    MMPickerView *mmPickerView = (MMPickerView *)pickerView;
    
    UnidadeDeTempoManager *manager = [UnidadeDeTempoManager sharedInstance];
    
    if (component == 2) {
        return [[manager obterUnidadesDeTempoDoTempo:mmPickerView.unidadeDeTempo] objectAtIndex:row];
    } else {
        return [NSString stringWithFormat:@"%ld", (long)row];
    }
}

#pragma mark - Selector do botão da toolbar (PickerView)

- (void)selBtnDonePickerView:(id)sender
{
    
}

#pragma mark - Métodos Gerais

- (void)setContentSizeScrollView
{
    [mainView setContentSize:CGSizeMake(self.view.frame.size.width, posicaoY)];
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
