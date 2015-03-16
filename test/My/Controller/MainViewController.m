//
//  MainViewController.m
//  TestLogin
//
//  Created by baoyuan on 14-9-4.
//  Copyright (c) 2014年 baoyuan. All rights reserved.
//

#import "MainViewController.h"
#import <ShareSDK/ShareSDK.h>

#import "UIViewAdditions.h"
#import "AsynlmageView.h"
@interface MainViewController ()

@end

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
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
    
    UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(122, 34, 80, 30)];
    titleLab.text = @"用户信息";
    titleLab.textColor = [UIColor whiteColor];
    [self.view addSubview:titleLab];
    
    UIButton *checkOut = [UIButton buttonWithType:UIButtonTypeCustom];
    [checkOut setTitle:@"注销" forState:UIControlStateNormal];
    checkOut.frame = CGRectMake(258, 34, 64, 30);
    [checkOut addTarget:self action:@selector(logoutButtonClickHandler:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:checkOut];
    
    
    AsynlmageView *userIm = [[AsynlmageView alloc] initWithFrame:CGRectMake(122, titleLab.bottom + 30, 60, 60)];
    userIm.clipsToBounds = YES;
    userIm.layer.cornerRadius = 6.0;
    userIm.url = _userIMurl;
    [self.view addSubview:userIm];
    
    UILabel *userLab = [[UILabel alloc] initWithFrame:CGRectMake(0, userIm.bottom, 320, 30)];
    userLab.textAlignment = NSTextAlignmentCenter;
    userLab.text = _userName;
    [self.view addSubview:userLab];
    
    [self createUrl];
    
    UILabel *todayLab = [[UILabel alloc] initWithFrame:CGRectMake(20, userLab.bottom + 10, 100, 30)];
    todayLab.text = @"今日推荐";
    [self.view addSubview:todayLab];
    
    self.infoLab = [[UILabel alloc] initWithFrame:CGRectMake(10, todayLab.bottom + 5, 300, 0)];
    self.infoLab.numberOfLines = 0;
    self.infoLab.font = [UIFont systemFontOfSize:14];
    // Do any additional setup after loading the view.
}

- (void)createUrl
{
    NSURL *url = [NSURL URLWithString:@"http://ic.snssdk.com/2/essay/zone/category/data/?category_id=1&level=6&count=30&min_time=1409406750&iid=2299909969&device_id=2623460080&ac=wifi&channel=taobao&aid=7&app_name=joke_essay&version_code=300&device_platform=android&device_type=LA2-T&os_api=17&os_version=4.2.2&uuid=863308022120649&openudid=a814218a3fc50c5b"];
    
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    
    [NSURLConnection sendAsynchronousRequest:urlRequest queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (connectionError) {
            NSLog(@"%@", connectionError);
        }
        else
        {
            NSError *error = nil;
            NSMutableDictionary *tempDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
            if (error) {
                NSLog(@"%@", error);
            }
            else{
               
                NSString *str = [[[[[tempDic objectForKey:@"data"] objectForKey:@"data"] firstObject] objectForKey:@"group"] objectForKey:@"content"];
                
                NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:14], NSFontAttributeName, nil];
                
                CGRect frame = [str boundingRectWithSize:CGSizeMake(300, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
                self.infoLab.frame = CGRectMake(10, self.infoLab.frame.origin.y, 300, frame.size.height);
                self.infoLab.text = [NSString stringWithFormat:@"       %@", str];
                [self.view addSubview:_infoLab];
                NSLog(@"**********************%@", str);
                
            }
        }
    }];
}

- (void)backBtn
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)logoutButtonClickHandler:(UIBarButtonItem *)btn
{
    [ShareSDK cancelAuthWithType:ShareTypeSinaWeibo];
    [ShareSDK cancelAuthWithType:ShareTypeKaixin];
    [ShareSDK cancelAuthWithType:ShareTypeQQ];
    [ShareSDK cancelAuthWithType:ShareTypeRenren];
    [self.delegate changValue:@"未登录" userImage:@"head21.png"];
    [self dismissViewControllerAnimated:YES completion:nil];
    //[self.navigationController popViewControllerAnimated:NO];
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
