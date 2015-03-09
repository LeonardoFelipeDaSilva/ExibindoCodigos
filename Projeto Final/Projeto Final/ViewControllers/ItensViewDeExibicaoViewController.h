//
//  ItensViewDeExibicaoViewController.h
//  Projeto Final
//
//  Created by Leonardo Felipe da Silva on 10/31/14.
//  Copyright (c) 2014 Mack Mobile - BEPiD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ItensViewDeExibicaoViewController : UIViewController

- (UIView *)criarTableViewExibição: (UITableView *)tableView;
- (CGRect)criarSegmentedControl: (UIView *)view2;
- (UIView *)criarViewCabecalho: (UIView *)view2;
- (UIImageView *)criarImagemViewCabecalho: (UIView *)view2;
- (UILabel *)criarLabelNome: (CGRect )rect;
- (UILabel *)criarLabelOutros: (CGRect )rect;



@end
