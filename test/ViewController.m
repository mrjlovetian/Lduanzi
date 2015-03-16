//
//  ViewController.m
//  test
//
//  Created by baoyuan on 14-9-1.
//  Copyright (c) 2014年 ___FULLUSERNAME___. All rights reserved.
//

#import "ViewController.h"
#import "EAIntroView.h"

@interface ViewController ()<EAIntroDelegate>

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if (self.view.bounds.size.height > 480) {
        UIImageView *backIM = [[UIImageView alloc] initWithFrame:self.view.frame];
        backIM.image = [UIImage imageNamed:@"kaiji2.png"];
        [self.view addSubview:backIM];
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(114, 400, 80, 25);
        [self.view addSubview:btn];
        [btn addTarget:self action:@selector(join) forControlEvents:UIControlEventTouchUpInside];
    }
    else
    {
        UIImageView *backIM = [[UIImageView alloc] initWithFrame:self.view.frame];
        backIM.image = [UIImage imageNamed:@"kaiji.png"];
        [self.view addSubview:backIM];
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(113, 339, 77, 23);
        [self.view addSubview:btn];
        [btn addTarget:self action:@selector(join) forControlEvents:UIControlEventTouchUpInside];
    }
    
    self.navigationController.navigationBar.hidden = YES;
    
    //[self.navigationController pushViewController:vc animated:YES];
   
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)join
{
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@ "Main_iPhone" bundle: nil ];
    // 获取目标故事板的初始视图控制器并跳转
    [self.navigationController pushViewController:storyboard.instantiateInitialViewController animated:YES];
}

- (void)viewWillAppear:(BOOL)animated
{
    
        [self showIntroWithCrossDissolve];
    
}

- (void)addPictures
{
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    imageView.tag = 100;
    if (self.view.bounds.size.height == 568) {
        imageView.image = [UIImage imageNamed:@"kaiji2.png"];
    }
    else{
        imageView.image = [UIImage imageNamed:@"kaiji1.png"];
    }
    [self.view addSubview:imageView];
    [self performSelector:@selector(removePictures) withObject:self afterDelay:1.5];
}

- (void)removePictures
{
    [[self.view viewWithTag:100] removeFromSuperview];
}
- (void)showIntroWithCrossDissolve {
    EAIntroPage *page1 = [EAIntroPage page];
    
    page1.bgImage = [UIImage imageNamed:@"1"];
    page1.titleImage = [UIImage imageNamed:@"original"];
    
    EAIntroPage *page2 = [EAIntroPage page];
   
    page2.bgImage = [UIImage imageNamed:@"2"];
    page2.titleImage = [UIImage imageNamed:@"supportcat"];
    
    EAIntroPage *page3 = [EAIntroPage page];
    
    page3.bgImage = [UIImage imageNamed:@"3"];
    page3.titleImage = [UIImage imageNamed:@"femalecodertocat"];
    
    EAIntroView *intro = [[EAIntroView alloc] initWithFrame:self.view.bounds andPages:@[page1,page2,page3]];
    
    [intro setDelegate:self];
    
    [intro showInView:self.view animateDuration:0.0];
    NSLog(@"000000");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
