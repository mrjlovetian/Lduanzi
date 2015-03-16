//
//  system settings settingsViewController.m
//  MyMovie
//
//  Created by 韩森 on 14-8-12.
//  Copyright (c) 2014年 lanou. All rights reserved.
//

#import "SystemSettingsViewController.h"
#import "SysSettingsCell.h"
#import <SystemConfiguration/SystemConfiguration.h>
#import "Reachability.h"

@interface SystemSettingsViewController ()
{
    BOOL _open;
    UISwitch * _switchView1;
    UISwitch * _switchView2;
}
@end

@implementation SystemSettingsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        _open = YES;
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];

   
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, 480) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    //观看禁止锁屏
    _switchView1 = [[UISwitch alloc] initWithFrame:CGRectMake(260, 37, 20, 20)];
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"open"] isEqualToString:@"YES"]) {
        NSLog(@"啦啦啦啦啦啦");
        [_switchView1 setOn:YES animated:NO];
    }
    
    [_switchView1 addTarget:self action:@selector(switchAction1:) forControlEvents:UIControlEventValueChanged];
    [_tableView addSubview:_switchView1];

    //允许3G/4G缓存
    _switchView2 = [[UISwitch alloc] initWithFrame:CGRectMake(260, 72, 20, 20)];
    [_switchView2 addTarget:self action:@selector(switchAction2) forControlEvents:UIControlEventValueChanged];
    [_tableView addSubview:_switchView2];
    
    

    self.cacheLab = [[UILabel alloc] initWithFrame:CGRectMake(240, 137, 80, 40)];
    
    [self.tableView addSubview:_cacheLab];

    /*[NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(reloate) userInfo:nil repeats:YES];*/
}

- (void)reloate
{
     NSString *cachPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask, YES) objectAtIndex:0];
   self.cacheLab.text = [NSString stringWithFormat:@"%.2fM", [self folderSizeAtPath:cachPath]];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self reloate];
    _open = [[[NSUserDefaults standardUserDefaults] objectForKey:@"switch"] boolValue];
    //_switchView1.on = _open;
    self.navigationController.navigationBar.hidden = NO;

}


//观看禁止锁屏
- (void)switchAction1:(UISwitch *)aSwitch
{
//    [UIApplication sharedApplication].idleTimerDisabled=YES;//不自动锁屏
    NSLog(@"bbbbbbbbbbbbbbbbbbbbbbbbbb%@",(aSwitch.on == 1 ? @"YES" : @"NO"));
    [[NSUserDefaults standardUserDefaults] setObject:(aSwitch.on == 1 ? @"YES" : @"NO")forKey:@"open"];

}


//允许3G/4G缓存
- (void)switchAction2
{
  UIAlertView *alerView0 = [[UIAlertView alloc] initWithTitle:@"警告" message:@"没有wifi或者3G/4G网络" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];

    UIAlertView *alerView1 = [[UIAlertView alloc] initWithTitle:@"网络提示" message:@"有wifi可以使用" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
    UIAlertView * alerView2 = [[UIAlertView alloc] initWithTitle:@"网络提示" message:@"有3G可以使用" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
    

    if (_open == NO){
        _open = YES;
        Reachability *r = [Reachability reachabilityWithHostName:@"www.apple.com"];
        switch ([r currentReachabilityStatus]) {
            case NotReachable:
                [alerView0 show];
                
                break;
            case ReachableViaWiFi:
                [alerView1 show];
               
                break;
                
            case ReachableViaWWAN:
                [alerView2 show];
                
                
                break;
                
            default:
                break;
        }
    }else{
        _open = NO;
    
    }

    
}



//清除系统缓存
- (void)clearWithTap
{
    NSString *cachPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask, YES) objectAtIndex:0];
    
    NSArray *files = [[NSFileManager defaultManager] subpathsAtPath:cachPath];
    
    //[self folderSizeAtPath:cachPath];
    NSLog(@"files :%lu",(unsigned long)[files count]);
    
    for (NSString *p in files) {
        
        NSError *error;
        
        NSString *path = [cachPath stringByAppendingPathComponent:p];
        
        if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
            
            [[NSFileManager defaultManager] removeItemAtPath:path error:&error];
            
        }
    }
    [self performSelectorOnMainThread:@selector(clearCacheSuccess) withObject:nil waitUntilDone:YES];
    self.cacheLab.text = @"0.0M";
}

//清除完成
- (void)clearCacheSuccess
{
    UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"清除成功" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"返回", nil];
    
    [alertView show];
}

#pragma mark - cacheSize
//单个文件的大小
- (long long) fileSizeAtPath:(NSString*) filePath{
    NSFileManager* manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:filePath]){
        return [[manager attributesOfItemAtPath:filePath error:nil] fileSize];
    }
    return 0;
}

//遍历文件夹获得文件夹大小，返回多少M
- (float ) folderSizeAtPath:(NSString*) folderPath{
    NSFileManager* manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath:folderPath]) return 0;
    NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath:folderPath] objectEnumerator];
    NSString* fileName;
    long long folderSize = 0;
    while ((fileName = [childFilesEnumerator nextObject]) != nil){
        NSString* fileAbsolutePath = [folderPath stringByAppendingPathComponent:fileName];
        folderSize += [self fileSizeAtPath:fileAbsolutePath];
    }
    return folderSize/(1024.0*1024.0);
}


#pragma mark - UITableViewDelegate,UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 2;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 2;
    }else
    {
        return 1;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{   static NSString * cellIdentity = @"cell";
    SysSettingsCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentity];
    if (cell == nil) {
        cell = [[SysSettingsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentity] ;
    }
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            cell.label1.text = @"    保持观看记录";

        }else
        cell.label1.text = @"    允许3G/4G网络缓存";

    }else if (indexPath.section == 1)
    {
        cell.label1.text = @"    清除系统缓存";
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clearWithTap)];
        [cell addGestureRecognizer:tap];
    }
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 35;
    
}


- (void)viewWillDisappear:(BOOL)animated
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
