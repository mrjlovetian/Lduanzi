//
//  HelpWithAboutViewController.m
//  MyMovie
//
//  Created by 韩森 on 14-8-13.
//  Copyright (c) 2014年 lanou. All rights reserved.
//

#import "HelpWithAboutViewController.h"
#import "FeedbackViewController.h"

@interface HelpWithAboutViewController ()

@end

@implementation HelpWithAboutViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithRed:233/255.0 green:172/255.0 blue:0 alpha:1.0];

    UIImageView *navIM = [[UIImageView alloc] initWithFrame:CGRectMake(0, 20, 320, 44)];
    UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(120, 5, 80, 32)];
    titleLab.text = @"帮助关于";
    [navIM addSubview:titleLab];
    navIM.backgroundColor = [UIColor colorWithRed:233/255.0 green:172/255.0 blue:0 alpha:1.0];
    navIM.userInteractionEnabled = YES;
    UIButton *backBTN = [UIButton buttonWithType:UIButtonTypeCustom];
    backBTN.frame = CGRectMake(20, 5, 60, 30);
    [backBTN setTitle:@"BACK" forState:UIControlStateNormal];
    [backBTN addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [navIM addSubview:backBTN];
    [self.view addSubview:navIM];
    
    UIScrollView * scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, 320, [UIScreen mainScreen].bounds.size.height-64)];
    scrollView.contentSize = CGSizeMake(320, 613);
    [self.view addSubview:scrollView];
    
    UIImageView *helpImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"jianjie.png"]];
    helpImageView.frame = CGRectMake(0, 0, 320, 613);
    
    [scrollView addSubview:helpImageView];
    


}

- (void)back
{
    [self dismissViewControllerAnimated:YES completion:nil];
}



- (void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBar.hidden = YES;
    
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
