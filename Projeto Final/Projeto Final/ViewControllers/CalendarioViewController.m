//
//  CalendarioViewController.m
//  Projeto Final
//
//  Created by Adriana Yuri on 28/10/14.
//  Copyright (c) 2014 Mack Mobile - BEPiD. All rights reserved.
//

#import "CalendarioViewController.h"
#import "DateUtil.h"
#import "SACalendar.h"
#import "HelpViewController.h"


@interface CalendarioViewController () <SACalendarDelegate>

@end

@implementation CalendarioViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        UIImage *image = [UIImage imageNamed:@"calendario_line.png"];
        self.tabBarItem.image = [self imageWithImage:image scaledToSize:CGSizeMake(30, 30)];
        UIImage *imageSelect = [UIImage imageNamed:@"calendario_color_2.png"];
        
        self.tabBarItem.selectedImage = [self imageWithImage:imageSelect scaledToSize:CGSizeMake(30, 30)];
//        [[UITabBar appearance] setSelectedImageTintColor:[UIColor clearColor]];
        // Custom initialization
    }
    return self;
}

- (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize {
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    SACalendar *calendar = [[SACalendar alloc]initWithFrame:CGRectMake(0,-65, 320, 310)
                                            scrollDirection:ScrollDirectionHorizontal
                                              pagingEnabled:YES];
    //    calendar.backgroundColor = [UIColor grayColor];
    
    UIView *sideRightLineView1 = [[UIView alloc]initWithFrame:CGRectMake(2, 55, 1, 265)];
    sideRightLineView1.backgroundColor = cellTopLineColor;
    
    UIView *sideRightLineView2 = [[UIView alloc]initWithFrame:CGRectMake(320/7*1, 55, 1, 265)];
    sideRightLineView2.backgroundColor = cellTopLineColor;
    
    UIView *sideRightLineView3 = [[UIView alloc]initWithFrame:CGRectMake(320/7*2, 55, 1, 265)];
    sideRightLineView3.backgroundColor = cellTopLineColor;
    
    UIView *sideRightLineView4 = [[UIView alloc]initWithFrame:CGRectMake(320/7*3, 55, 1, 265)];
    sideRightLineView4.backgroundColor = cellTopLineColor;
    
    UIView *sideRightLineView5 = [[UIView alloc]initWithFrame:CGRectMake(320/7*4+1, 55, 1, 265)];
    sideRightLineView5.backgroundColor = cellTopLineColor;
    
    UIView *sideRightLineView6 = [[UIView alloc]initWithFrame:CGRectMake(320/7*5+1, 55, 1, 265)];
    sideRightLineView6.backgroundColor = cellTopLineColor;
    
    UIView *sideRightLineView7 = [[UIView alloc]initWithFrame:CGRectMake(320/7*6+1, 55, 1, 265)];
    sideRightLineView7.backgroundColor = cellTopLineColor;
    
    UIView *sideRightLineView8 = [[UIView alloc]initWithFrame:CGRectMake(320/7*7+1, 55, 1, 265)];
    sideRightLineView8.backgroundColor = cellTopLineColor;
    
    UIView *downLineView1 = [[UIView alloc] initWithFrame:CGRectMake(2, 55, 315, 1)];
    downLineView1.backgroundColor = cellTopLineColor;
    
    UIView *downLineView2 = [[UIView alloc] initWithFrame:CGRectMake(2, 265/6*1+55, 315, 1)];
    downLineView2.backgroundColor = cellTopLineColor;
    
    UIView *downLineView3 = [[UIView alloc] initWithFrame:CGRectMake(2, 265/6*2+55, 315, 1)];
    downLineView3.backgroundColor = cellTopLineColor;
    
    UIView *downLineView4 = [[UIView alloc] initWithFrame:CGRectMake(2, 265/6*3+55, 315, 1)];
    downLineView4.backgroundColor = cellTopLineColor;
    
    UIView *downLineView5 = [[UIView alloc] initWithFrame:CGRectMake(2, 265/6*4+55, 315, 1)];
    downLineView5.backgroundColor = cellTopLineColor;
    
    UIView *downLineView6 = [[UIView alloc] initWithFrame:CGRectMake(2, 265/6*5+55, 315, 1)];
    downLineView6.backgroundColor = cellTopLineColor;
    
    UIView *downLineView7 = [[UIView alloc] initWithFrame:CGRectMake(2, 265/6*6+55, 315, 1)];
    downLineView7.backgroundColor = cellTopLineColor;
    
    UIView *downLineView8 = [[UIView alloc] initWithFrame:CGRectMake(10, 265/6*7+55, 315, 1)];
    downLineView8.backgroundColor = cellTopLineColor;

    
    
    calendar.delegate = self;
    
    
    [self.view addSubview:calendar];
    [self.view addSubview:sideRightLineView1];
    [self.view addSubview:sideRightLineView2];
    [self.view addSubview:sideRightLineView3];
    [self.view addSubview:sideRightLineView4];
    [self.view addSubview:sideRightLineView5];
    [self.view addSubview:sideRightLineView6];
    [self.view addSubview:sideRightLineView7];
    [self.view addSubview:sideRightLineView8];
    [self.view addSubview:downLineView1];
    [self.view addSubview:downLineView2];
    [self.view addSubview:downLineView3];
    [self.view addSubview:downLineView4];
    [self.view addSubview:downLineView5];
    [self.view addSubview:downLineView6];
    [self.view addSubview:downLineView7];
//    [self.view addSubview:downLineView8];
    
    
    self.view.backgroundColor = [UIColor grayColor];
    
    
}

-(void)viewDidAppear:(BOOL)animated
{
    [[[self tabBarController] navigationItem] setTitle:@"Calendário"];
    [[[self tabBarController] navigationItem] setTitleView:nil]; //remover a view com os perfis (bolinhas)
    
    UIBarButtonItem *barButtonLife = [[UIBarButtonItem alloc] initWithTitle:@" LiFE  " style:UIBarButtonItemStylePlain target:self action:@selector(exibirHelp:)];
    [[[self tabBarController] navigationItem] setLeftBarButtonItem: barButtonLife];
    
//    UIBarButtonItem *barButtonAdd = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(adicionar)];
    [[[self tabBarController] navigationItem] setRightBarButtonItem: nil];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
    
}

- (void)exibirHelp:(id)sender
{
    HelpViewController *helpTela = [[HelpViewController alloc]init];
    [UIView animateWithDuration:0.9 animations:^{
        [UIView setAnimationCurve:UIViewAnimationCurveLinear];
        [self.navigationController pushViewController:helpTela animated:YES];
        [UIView setAnimationTransition:UIViewAnimationTransitionNone forView:self.navigationController.view cache:NO];
        
    }];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
