//
//  CadRemViewController.h
//  Projeto Final
//
//  Created by Leonardo Felipe da Silva on 22/08/14.
//  Copyright (c) 2014 Mack Mobile - BEPiD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "Remedio.h"

@interface RemedioViewController : BaseViewController <UITableViewDataSource, UITableViewDelegate>
{
    Remedio *remedio;
    
    UIImageView *imgFotoBlur;
    UIImageView *imgFotoIcone;
}

@end
