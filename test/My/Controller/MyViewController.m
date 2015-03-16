//
//  MyViewController.m
//  test
//
//  Created by baoyuan on 14-9-5.
//  Copyright (c) 2014年 baoyuan. All rights reserved.
//

#import "MyViewController.h"
#import "PersonCell.h"
#import "FeedbackViewController.h"
#import "HelpWithAboutViewController.h"
#import "SystemSettingsViewController.h"
#import "MainViewController.h"
#import "AsynlmageView.h"

#import "WebViewController.h"
#import "LinkViewController.h"
#import "LoginViewController.h"
#import <ShareSDK/ShareSDK.h>
#import <Parse/Parse.h>
@interface MyViewController ()<changValue, successLogn>
@property (nonatomic, retain)AsynlmageView * headView;
@end

@implementation MyViewController

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
    UIImageView * bagcView1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 20, 320, 155)];
    bagcView1.image = [UIImage imageNamed:@"up.png"];
    [self.view addSubview:bagcView1];
    
    self.headView = [[AsynlmageView alloc] initWithFrame:CGRectMake(127, 45, 70, 70)];
    self.headView.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"head21" ofType:@"png"]];
    self.headView.layer.cornerRadius = 6.0;
    self.headView.clipsToBounds = YES;
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(login)];
    [_headView addGestureRecognizer:tap];
    _headView.userInteractionEnabled = YES;
    [self.view addSubview:_headView];

    self.loginLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 115, 320, 30)];
    _loginLab.textAlignment = NSTextAlignmentCenter;
    _loginLab.text = @"未登录";
     UITapGestureRecognizer * tapL = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(login)];
    _loginLab.userInteractionEnabled = YES;
    [_loginLab addGestureRecognizer:tapL];
    _loginLab.textColor = [UIColor whiteColor];
    _loginLab.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_loginLab];
    
    self.navigationController.navigationBar.hidden = YES;
    
    UIImageView * backView2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 155, 320, 325)];
    backView2.image = [UIImage imageNamed:@"down.png"];
    [self.view addSubview:backView2];
    backView2.userInteractionEnabled = YES;
    
    UITableView * personView = [[UITableView alloc] initWithFrame:CGRectMake(0, 155, 320, 390) style:UITableViewStylePlain];
    personView.dataSource = self;
    personView.delegate = self;
    personView.backgroundView = backView2;
    personView.separatorStyle = UITableViewCellAccessoryNone;
    [self.view addSubview:personView];
    
    self.markArray = [NSArray arrayWithObjects:@"link.png", @"shezhi.png", @"yijianfankui.png", @"bangzhu.png", @"gaunwang.png",nil];
    self.textArray = [NSArray arrayWithObjects:@"联系我们", @"系统设置", @"意见反馈", @"帮助与关于", @"进入L段子博客", nil];
    
        // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

- (void)login//模态推出登陆页面
{
    if ([_loginLab.text isEqualToString:@"未登录"]) {
        LoginViewController *loginVC = [[LoginViewController alloc] init];
        [self presentViewController:loginVC animated:YES completion:nil];
        loginVC.delegate = self;
    }
    else
    {
        MainViewController *mainVC = [[MainViewController alloc] init] ;
        mainVC.userIMurl = _headView.url;
        mainVC.userName = _loginLab.text;
        [self presentViewController:mainVC animated:YES completion:nil];
        NSLog(@"***************%@", _loginLab.text);
        
        mainVC.delegate = self;
    }
    
}

- (void)changValue:(NSString *)str userImage:(NSString *)image
{
    _loginLab.text = str;
    _headView.image = [UIImage imageNamed:image];
}

- (void)successLogn:(NSString *)userImage userName:(NSString *)name
{
    _loginLab.text = name;
    self.headView.url = userImage;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - datasourseDelega
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * indefine = @"personView";
    PersonCell * cell = [tableView dequeueReusableCellWithIdentifier:indefine];
    if (!cell) {
        cell = [[PersonCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:indefine] ;
    }
    cell.markView.image = [UIImage imageNamed:[self.markArray objectAtIndex:indexPath.row]];
    cell.texLab.text = [self.textArray objectAtIndex:indexPath.row];
    //tableView.backgroundColor = [UIColor clearColor];
    //cell.backgroundColor = [UIColor clearColor];
    //cell.backgroundView.alpha = 0.5;
    //cell.backgroundColor =
    //cell.backgroundView.alpha = 1;
    cell.backgroundColor =  [UIColor colorWithRed:(180.0/255.0) green:(180.0/255.0) blue:(180/255.0) alpha:.3];
    cell.texLab.backgroundColor = [UIColor clearColor];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    //联系我们
    if (indexPath.row == 0) {
        LinkViewController *linkVC = [[LinkViewController alloc] init];
        [self presentViewController:linkVC animated:YES completion:nil];
    }
    //系统设置
    if (indexPath.row == 1) {
        SystemSettingsViewController * sysVC = [[SystemSettingsViewController alloc]init];
        self.navigationController.navigationBar.hidden = NO;
        self.navigationItem.title = @"系统设置";
        [self.navigationController pushViewController:sysVC animated:YES];
        
    }
    //意见反馈
    if (indexPath.row == 2) {
        
        FeedbackViewController * feedBackVC = [[FeedbackViewController alloc] init];
        self.navigationController.navigationBar.hidden = NO;
        [self presentViewController:feedBackVC animated:YES completion:nil];
        
    }
    //帮助关于
    if (indexPath.row == 3) {
        HelpWithAboutViewController * hwaVC = [[HelpWithAboutViewController alloc] init];
        [self presentViewController:hwaVC animated:YES completion:nil];
        
    }
    //进入官网
    if (indexPath.row == 4) {
        WebViewController *lduan = [[WebViewController alloc] init];
        [self presentViewController:lduan animated:YES completion:nil];
    }
    
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
