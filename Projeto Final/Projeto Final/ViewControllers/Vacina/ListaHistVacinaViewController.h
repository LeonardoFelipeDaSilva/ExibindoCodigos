//
//  ListaHistVacinaViewController.h
//  Projeto Final
//
//  Created by Leonardo Felipe da Silva on 10/30/14.
//  Copyright (c) 2014 Mack Mobile - BEPiD. All rights reserved.
//

#import "BoxesCreatorViewController.h"
#import "VacinaManager.h"
#import "MMPrincipal.h"

@interface ListaHistVacinaViewController : MMTableViewControllerDropDown
{
    Vacina *vacina;
}

@property UIViewController *viewControllerPai;

- (id)initWithVacina:(Vacina *)vacina2;
- (void)atualizarDados;

@end
