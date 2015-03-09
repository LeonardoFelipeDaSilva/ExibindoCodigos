//
//  SintomasDaOcorViewController.h
//  Projeto Final
//
//  Created by Leonardo Felipe da Silva on 10/10/14.
//  Copyright (c) 2014 Mack Mobile - BEPiD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OcorrenciaManager.h"
@interface SintomasDaOcorViewController : UITableViewController<UITableViewDataSource, UITableViewDelegate>
@property OcorrenciaDoenca *ocorrencia;
@property UITextView *textView;

- (id)initWithOcorrencia;
@end
