//
//  MostrarConsultaViewController.h
//  Projeto Final
//
//  Created by Leonardo Felipe da Silva on 12/8/14.
//  Copyright (c) 2014 Mack Mobile - BEPiD. All rights reserved.
//

#import "ConsultaManager.h"
#import "BaseManager.h"
@interface MostrarConsultaViewController : BaseViewController
{
    Consulta *consulta;
    
    NSString *data;
    UILabel *anotacoesLabel;
    
}
@property UILabel *anotacoesLabel;
@property Consulta *consulta;
@property UISegmentedControl *segmentedControl;
@property UIImageView *imageView;

- (id)initWithPageNumber:(int)page;

- (void)changePage:(id)sender;

@end
