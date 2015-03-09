//
//  CampoViewController.h
//  Projeto Final
//
//  Created by Lucas Saito on 08/09/14.
//  Copyright (c) 2014 Mack Mobile - BEPiD. All rights reserved.
//

#import "BaseViewController.h"

@interface CampoViewController : BaseViewController <UIPickerViewDataSource, UIPickerViewDelegate>
{
    NSString *tipo;
    id refObjeto;
    NSString *nomeAtributo;
}

@property NSString *tipo;
@property id refObjeto;
@property NSString *nomeAtributo;

@end
