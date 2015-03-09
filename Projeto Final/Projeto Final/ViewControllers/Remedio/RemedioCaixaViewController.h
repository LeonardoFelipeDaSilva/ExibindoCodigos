//
//  RemedioCaixaViewController.h
//  Projeto Final
//
//  Created by Lucas Saito on 06/10/14.
//  Copyright (c) 2014 Mack Mobile - BEPiD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "RemedioCaixa.h"

@interface RemedioCaixaViewController : BaseViewController <UITableViewDataSource, UITableViewDelegate>
{
    RemedioCaixa *remedioCaixa;
    Remedio *remedio;
}

@property RemedioCaixa *remedioCaixa;
@property Remedio *remedio;

@end
