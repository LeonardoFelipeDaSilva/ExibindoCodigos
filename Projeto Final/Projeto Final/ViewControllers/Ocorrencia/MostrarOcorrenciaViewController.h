//
//  MostrarOcorrenciaViewController.h
//  Projeto Final
//
//  Created by Leonardo Felipe da Silva on 12/2/14.
//  Copyright (c) 2014 Mack Mobile - BEPiD. All rights reserved.
//

#import "OcorrenciaManager.h"
#import "BaseManager.h"
@interface MostrarOcorrenciaViewController : BaseViewController
{
    OcorrenciaDoenca *ocorrencia;
    
    NSString *data;
    UILabel *sintomasLabel;

}
@property UILabel *sintomasLabel;
@property OcorrenciaDoenca *ocorrencia;
@property UISegmentedControl *segmentedControl;
@property UIImageView *imageView;

- (id)initWithPageNumber:(int)page;

- (void)changePage:(id)sender;


@end
