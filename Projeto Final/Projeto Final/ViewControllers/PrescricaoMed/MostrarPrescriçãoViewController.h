//
//  MostrarPrescriçãoViewController.h
//  Projeto Final
//
//  Created by Leonardo Felipe da Silva on 11/21/14.
//  Copyright (c) 2014 Mack Mobile - BEPiD. All rights reserved.
//

#import "BaseViewController.h"
#import "PrescicaoMedManager.h"
#import "BaseManager.h"
@interface MostrarPrescric_a_oViewController : BaseViewController

{
    PrescricaoMed *prescMed;
    UITableView *tableView;
    NSString *dataNascimento;
    UIButton *btnRemedio;
    
    
    //FOTO
    UIPageControl *pageControlFoto;
    UIScrollView *scrollViewFotos;
    int pageNumber;
    BOOL pageControlUsed;
//    UIButton *btnPrescricao;
    
}
@property PrescricaoMed *prescMed;
@property UISegmentedControl *segmentedControl;
@property UIImageView *imageView;

- (id)initWithPageNumber:(int)page;

- (void)changePage:(id)sender;
@end
