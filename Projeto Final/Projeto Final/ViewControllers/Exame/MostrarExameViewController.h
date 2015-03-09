//
//  MostrarExameViewController.h
//  Projeto Final
//
//  Created by Leonardo Felipe da Silva on 12/2/14.
//  Copyright (c) 2014 Mack Mobile - BEPiD. All rights reserved.
//

#import "BaseManager.h"
#import "ExameManager.h"

@interface MostrarExameViewController : BaseViewController


{
    Exame *exame;
  
    NSString *data;
    UILabel *fotoLabel;
    
    
    //FOTO
    UIPageControl *pageControlFoto;
    UIScrollView *scrollViewFotos;
    int pageNumber;
    BOOL pageControlUsed;
    //    UIButton *btnPrescricao;
    
}
@property UILabel *fotoLabel;
@property Exame *exame;
@property UISegmentedControl *segmentedControl;
@property UIImageView *imageView;
@property UIView *soprapegar;

- (id)initWithPageNumber:(int)page;

- (void)changePage:(id)sender;
@end
