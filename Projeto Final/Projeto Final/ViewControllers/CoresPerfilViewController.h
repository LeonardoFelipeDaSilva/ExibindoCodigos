//
//  CoresPerfil.h
//  CoresPerfil
//
//  Created by Adriana Yuri on 10/09/14.
//  Copyright (c) 2014 Adriana. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PessoaManager.h"

@interface CoresPerfil : UITableViewController <UITableViewDataSource, UITableViewDelegate>

@property UIColor *pessoaCor;
@property Pessoa *pessoa;


@end
