//
//  FeedbackViewController.m
//  test
//
//  Created by baoyuan on 14-9-6.
//  Copyright (c) 2014年 baoyuan. All rights reserved.
//

#import "FeedbackViewController.h"
#import "UIViewAdditions.h"
@interface FeedbackViewController ()
@property (nonatomic, retain)UILabel *sumLab;
@end

@implementation FeedbackViewController

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
    self.view.backgroundColor = [UIColor colorWithRed:245 / 255.0 green:245 / 255.0 blue:245 / 255.0 alpha:1.0];
    
    self.textView = [[UITextView alloc] initWithFrame:CGRectMake(10, 74, 300, 150)];
    self.textView.delegate = self;
    [self.view addSubview:_textView];
    
    self.sumLab = [[UILabel alloc] initWithFrame:CGRectMake(240, _textView.bottom + 5, 80, 25)];
    self.sumLab.text = @"剩余140";
    [self.view addSubview:_sumLab];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(20, _sumLab.bottom + 5, 280, 30);
    [btn addTarget:self action:@selector(submit) forControlEvents:UIControlEventTouchUpInside];
    btn.backgroundColor = [UIColor colorWithRed:54/255.0 green:100/255.0 blue:1.0 alpha:1.0];
    [btn setTitle:@"提交" forState:UIControlStateNormal];
    [self.view addSubview:btn];
    
    UIView *naView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 64)];
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setTitle:@"返回" forState:UIControlStateNormal];
    backBtn.frame = CGRectMake(10, 20, 50, 30);
    [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(120, 20, 80, 30)];
    titleLab.text = @"意见反馈";
    [naView addSubview:titleLab];
    [naView addSubview:backBtn];
    naView.backgroundColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:0.15];
    [self.view addSubview:naView];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - textViewDelegate
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([@"\n" isEqualToString:text]) {
        [textView resignFirstResponder];
        return NO;
    }
    if (_textView.text.length == 0) {
        _sumLab.text = @"剩余140";
        
    }
    else
    {
        int a =  (int)_textView.text.length;
        _sumLab.text = [NSString stringWithFormat:@"剩余%d", 139 - a];
        if (139 - a == 0) {
            return NO;
        }
    }
    return YES;
}

#pragma mark - button
- (void)submit
{
    if ([_textView.text isEqualToString:@""]) {
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"信息内容不能为空" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
       
    }
    else
    {
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://ichannel.snssdk.com/api/feedback/1/post_message/?appkey=essay-joke-android&content=%@&device=LA2-T&app_version=3.0.0&network_type=wifi&iid=2299909969&device_id=2623460080&ac=wifi&channel=taobao&aid=7&app_name=joke_essay&version_code=300&device_platform=android&device_type=LA2-T&os_api=17&os_version=4.2.2&uuid=863308022120649&openudid=a814218a3fc50c5b", [_textView.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        
        [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
            if (connectionError) {
                NSLog(@"%@", connectionError);
            }
            else
            {
                NSError *error = nil;
                NSMutableDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
                if (error) {
                    NSLog(@"%@", error);
                }
                else
                {
                    NSLog(@"%@", dic);
                    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"提交成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                    [alert show];
                }
            }
        }];
        
        
        
    }
    
}

- (void)back
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        [self back];
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
