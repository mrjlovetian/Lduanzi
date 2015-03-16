//
//  WebViewController.m
//  TestWeb
//
//  Created by baoyuan on 14-9-10.
//  Copyright (c) 2014年 baoyuan. All rights reserved.
//

#import "WebViewController.h"
#import "CustomURLCache.h"
#import "MBProgressHUD.h"

@interface WebViewController ()<UIWebViewDelegate>

@end

@implementation WebViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        CustomURLCache *urlCache = [[CustomURLCache alloc] initWithMemoryCapacity:20 * 1024 * 1024
                                                                     diskCapacity:200 * 1024 * 1024
                                                                         diskPath:nil
                                                                        cacheTime:0];
        [CustomURLCache setSharedURLCache:urlCache];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UIImageView *imageVC = [[UIImageView alloc] initWithFrame:CGRectMake(0, 20, 320, 44)];
    UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(115, 5, 90, 30)];
    titleLab.text = @"L段子博客";
    [imageVC addSubview:titleLab];
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [backBtn setTitle:@"X" forState:UIControlStateNormal];
    backBtn.titleLabel.font = [UIFont systemFontOfSize:40];
    [backBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    backBtn.frame = CGRectMake(20, 5, 30, 30);
    imageVC.userInteractionEnabled = YES;
    [imageVC addSubview:backBtn];
    [self.view addSubview:imageVC];
    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 64, 320, [UIScreen mainScreen].bounds.size.height - 64)];
    self.webView.delegate = self;
    [self.view addSubview:_webView];
    
    self.webView.scalesPageToFit = YES;
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.cnblogs.com/MRJ1101/p/3969275.html"]]];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    CustomURLCache *urlCache = (CustomURLCache *)[NSURLCache sharedURLCache];
    [urlCache removeAllCachedResponses];
    // Dispose of any resources that can be recreated.
}

#pragma mark - webview

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.labelText = @"Loading...";
}
#pragma mark - back
- (void)back
{
    NSLog(@"11111111111111111111");
    [self dismissViewControllerAnimated:YES completion:nil];
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
