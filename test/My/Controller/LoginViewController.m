//
//  LoginViewController.m
//  test
//
//  Created by baoyuan on 14-9-6.
//  Copyright (c) 2014年 baoyuan. All rights reserved.
//

#import "LoginViewController.h"
#import <ShareSDK/ShareSDK.h>
#import <Parse/Parse.h>
#import "MainViewController.h"
@interface LoginViewController ()

@end

@implementation LoginViewController

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
    self.view.backgroundColor = [UIColor whiteColor];
    UIImageView *backIM = [[UIImageView alloc] initWithFrame:CGRectMake(0, 20, 320, [UIScreen mainScreen].bounds.size.height - 20)];
    backIM.image = [UIImage imageNamed:@"login.png"];
    [self.view addSubview:backIM];
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(7, 35, 50, 25);
    [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    //backBtn.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:backBtn];
    
    if ([UIScreen mainScreen].bounds.size.height > 480) {
        UIButton *sinaBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        sinaBtn.frame = CGRectMake(20, 225, 60, 65);
        [sinaBtn addTarget:self action:@selector(login:) forControlEvents:UIControlEventTouchUpInside];
        //sinaBtn.backgroundColor = [UIColor yellowColor];
        [self.view addSubview:sinaBtn];
        
        /*UIButton *renrenBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        renrenBtn.frame = CGRectMake(93, 210, 70, 70);
        [renrenBtn addTarget:self action:@selector(login:) forControlEvents:UIControlEventTouchUpInside];
        //renrenBtn.backgroundColor = [UIColor yellowColor];
        [self.view addSubview:renrenBtn];*/
        
        /*UIButton *QQBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        QQBtn.frame = CGRectMake(172, 205, 57, 70);
        [QQBtn addTarget:self action:@selector(login:) forControlEvents:UIControlEventTouchUpInside];
        //QQBtn.backgroundColor = [UIColor yellowColor];
        [self.view addSubview:QQBtn];*/
        
        UIButton *kaixinBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        kaixinBtn.frame = CGRectMake(240, 225, 55, 70);
        [kaixinBtn addTarget:self action:@selector(login:) forControlEvents:UIControlEventTouchUpInside];
        //kaixinBtn.backgroundColor = [UIColor yellowColor];
        [self.view addSubview:kaixinBtn];
        sinaBtn.tag = 101;
        /*renrenBtn.tag = 102;
        QQBtn.tag = 103;*/
        kaixinBtn.tag = 104;
    }
    else
    {
        UIButton *sinaBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        sinaBtn.frame = CGRectMake(20, 185, 60, 65);
        [sinaBtn addTarget:self action:@selector(login:) forControlEvents:UIControlEventTouchUpInside];
        //sinaBtn.backgroundColor = [UIColor yellowColor];
        [self.view addSubview:sinaBtn];
        
        /*UIButton *renrenBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        renrenBtn.frame = CGRectMake(93, 170, 70, 70);
        [renrenBtn addTarget:self action:@selector(login:) forControlEvents:UIControlEventTouchUpInside];
        //renrenBtn.backgroundColor = [UIColor yellowColor];
        [self.view addSubview:renrenBtn];
        
        UIButton *QQBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        QQBtn.frame = CGRectMake(172, 170, 57, 70);
        [QQBtn addTarget:self action:@selector(login:) forControlEvents:UIControlEventTouchUpInside];
        //QQBtn.backgroundColor = [UIColor yellowColor];
        [self.view addSubview:QQBtn];*/
        
        UIButton *kaixinBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        kaixinBtn.frame = CGRectMake(240, 185, 55, 70);
        [kaixinBtn addTarget:self action:@selector(login:) forControlEvents:UIControlEventTouchUpInside];
        //kaixinBtn.backgroundColor = [UIColor yellowColor];
        [self.view addSubview:kaixinBtn];
        sinaBtn.tag = 101;
        /*renrenBtn.tag = 102;
        QQBtn.tag = 103;*/
        kaixinBtn.tag = 104;
    }
    NSLog(@"%f", [UIScreen mainScreen].bounds.size.height);
    // Do any additional setup after loading the view.
}

- (void)back
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)login:(UIButton *)btn
{
    ShareType tyep = 0;
    if (btn.tag == 101) {
        tyep = ShareTypeSinaWeibo;
    }
    else if (btn.tag == 102)
    {
        tyep = ShareTypeRenren;
    }
    else if (btn.tag == 103)
    {
        tyep = ShareTypeQQ;
    }
    else {
        tyep = ShareTypeKaixin;
    }
    
    [ShareSDK getUserInfoWithType:tyep
                      authOptions:nil
                           result:^(BOOL result, id<ISSPlatformUser> userInfo, id<ICMErrorInfo> error) {
                               
                               if (result)
                               {
                                   PFQuery *query = [PFQuery queryWithClassName:@"UserInfo"];
                                   [query whereKey:@"uid" equalTo:[userInfo uid]];
                                   [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
                                       
                                       if ([objects count] == 0)
                                       {
                                           PFObject *newUser = [PFObject objectWithClassName:@"UserInfo"];
                                           [newUser setObject:[userInfo uid] forKey:@"uid"];
                                           [newUser setObject:[userInfo nickname] forKey:@"name"];
                                           [newUser setObject:[userInfo profileImage] forKey:@"icon"];
                                           [newUser saveInBackground];
                                           
                                           UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"Hello %@", [userInfo nickname]] message:@"欢迎注册" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles: nil];
                                           [alertView show];
                                                                                  }
                                       else
                                       {
                                           UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"Hello %@", [userInfo nickname]] message:@"欢迎回来" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles: nil];
                                           [alertView show];
                                          // NSLog(@"%@", [userInfo profileImage]);
                                          
                                       }
                                       [self.delegate successLogn:[userInfo profileImage] userName:[userInfo nickname]];
                                       
                                       MainViewController *mainVC = [[MainViewController alloc] init] ;
                                       mainVC.userName = [userInfo nickname];
                                       mainVC.userIMurl = [userInfo profileImage];
                                       [self presentViewController:mainVC animated:YES completion:nil];
                                   }];
                                   
                                   
                                   //mainVC.delegate = self;
                                   
                               }
                               
                           }];
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
