//
//  ItensViewDeExibicaoViewController.m
//  Projeto Final
//
//  Created by Leonardo Felipe da Silva on 10/31/14.
//  Copyright (c) 2014 Mack Mobile - BEPiD. All rights reserved.
//

#import "ItensViewDeExibicaoViewController.h"

@interface ItensViewDeExibicaoViewController ()

@end

@implementation ItensViewDeExibicaoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (UIView *)criarViewCabecalho: (UIView *)view2
{
    
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(view2.window.frame.origin.x, view2.window.frame.origin.y, view2.frame.size.width, 170)];
//    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, view.frame.size.width, view.frame.size.height)];
    
//    [view addSubview:imageView];
    return view;
    
}

- (CGRect)criarSegmentedControl: (UIView *)view2
{
    
    CGRect rect = CGRectMake(0, 170, view2.frame.size.width, 30) ;
   
    return rect;
}

- (UIView *)criarTableViewExibição: (UITableView *)tableView
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 370, self.view.frame.size.width, self.view.frame.size.height - 220)];
    
    
    
    return view;
}

- (UIImageView *)criarImagemViewCabecalho: (UIView *)view2
{
    UIImageView *imagemView = [[UIImageView alloc]initWithFrame:CGRectMake(15, view2.frame.size.height/4, view2.frame.size.width - 240, view2.frame.size.width - 240)];
    imagemView.layer.cornerRadius = (view2.frame.size.width - 240)/2;
    imagemView.layer.borderColor = [UIColor blackColor].CGColor;
    imagemView.layer.borderWidth = 2.0f;
    return imagemView;
}

- (UILabel *)criarLabelNome: (CGRect )rect
{
    UILabel *nome = [[UILabel alloc]initWithFrame:rect];
    [nome setFont:[UIFont systemFontOfSize:[UIFont systemFontSize]]];
    return nome;
}

- (UILabel *)criarLabelOutros: (CGRect )rect
{
    UILabel *outros = [[UILabel alloc]initWithFrame:rect];
    [outros setFont:[UIFont systemFontOfSize:[UIFont systemFontSize]]];
    return outros;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
