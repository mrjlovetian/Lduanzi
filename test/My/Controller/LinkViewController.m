//
//  LinkViewController.m
//  test
//
//  Created by baoyuan on 14-9-7.
//  Copyright (c) 2014年 baoyuan. All rights reserved.
//

#import "LinkViewController.h"
#import "UIViewAdditions.h"

@interface LinkViewController ()

@end

@implementation LinkViewController

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
    UIImageView *userBack = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, [UIScreen mainScreen].bounds.size.height)];
    userBack.image = [UIImage imageNamed:@"userBack.png"];
    [self.view addSubview:userBack];
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setTitle:@"BACK" forState:UIControlStateNormal];
    backBtn.frame = CGRectMake(10, 34, 64, 30);
    [backBtn addTarget:self action:@selector(backBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backBtn];
    
    UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(122, 34, 200, 30)];
    titleLab.text = @"联系我们";
    titleLab.textColor = [UIColor whiteColor];
    [self.view addSubview:titleLab];
    
    
    UILabel *QQLab = [[UILabel alloc] initWithFrame:CGRectMake(10, titleLab.bottom + 30, 200, 20)];
    QQLab.text = @"QQ联系:";
    [self.view addSubview:QQLab];
    UILabel *QQhao = [[UILabel alloc] initWithFrame:CGRectMake(10, QQLab.bottom, 300, 30)];
    QQhao.numberOfLines = 0;
    QQhao.font = [UIFont systemFontOfSize:14];
    QQhao.textColor = [UIColor blueColor];
    QQhao.text = @"     QQ:1520312758   QQ群:zzs140507";
    [self.view addSubview:QQhao];
    
    UILabel *emialLab = [[UILabel alloc] initWithFrame:CGRectMake(10, QQhao.bottom + 20, 200, 20)];
    emialLab.text = @"邮箱联系:";
    [self.view addSubview:emialLab];
    UILabel *emialhao = [[UILabel alloc] initWithFrame:CGRectMake(10, emialLab.bottom + 5, 320, 30)];
    emialhao.numberOfLines = 0;
    emialhao.font = [UIFont systemFontOfSize:13];
    emialhao.textColor = [UIColor blueColor];
    emialhao.text = @"     1520312758@qq.com    mrjnumber1@163.com";
    [self.view addSubview:emialhao];
    
    UILabel *weixinLab = [[UILabel alloc] initWithFrame:CGRectMake(10, emialhao.bottom + 10, 200, 20)];
    weixinLab.text = @"微信联系:";
    [self.view addSubview:weixinLab];
    UILabel *weixinhao = [[UILabel alloc] initWithFrame:CGRectMake(10, weixinLab.bottom + 5, 200, 30)];
    weixinhao.text = @"     上川流河";
    weixinhao.font = [UIFont systemFontOfSize:14];
    weixinhao.textColor = [UIColor blueColor];
    [self.view addSubview:weixinhao];
    
    UILabel *guanggaoLab = [[UILabel alloc] initWithFrame:CGRectMake(10, weixinhao.bottom + 10, 200, 30)];
    guanggaoLab.text = @"欢迎您给我们宝贵意见!";
    [self.view addSubview:guanggaoLab];
    // Do any additional setup after loading the view.
}

- (void)backBtn
{
    [self dismissViewControllerAnimated:YES completion:nil];
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
