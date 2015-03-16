//
//  AppDelegate.m
//  test
//
//  Created by baoyuan on 14-9-1.
//  Copyright (c) 2014年 ___FULLUSERNAME___. All rights reserved.
//

#import "AppDelegate.h"

#import <ShareSDK/ShareSDK.h>
#import <Parse/Parse.h>

#import "ViewController.h"
/*#import <TencentOpenAPI/QQApiInterface.h>
#import <TencentOpenAPI/TencentOAuth.h>*/
@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    NSLog(@"%@", NSHomeDirectory());
    
    if(![[NSUserDefaults standardUserDefaults] boolForKey:@"firstLaunch"])
        
    {
        
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"firstLaunch"];
        
        NSLog(@"第一次启动");
        
        
        ViewController *userGuideViewController = [[ViewController alloc] init];
        UINavigationController *rootvc = [[UINavigationController alloc] initWithRootViewController:userGuideViewController];
        
        
        self.window.rootViewController = rootvc;
        
    }
    
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self createThree];
    //[self.window makeKeyAndVisible];
    // Override point for customization after application launch.
    return NO;
}



- (void)createThree
{
    [ShareSDK registerApp:@"2f9ef2795842"];
    [ShareSDK connectSinaWeiboWithAppKey:@"30038251"
                               appSecret:@"7b74be22fdb9fcbad867df77a7e0bcd5"
                             redirectUri:@"http://www.zzia.edu.cn"];
    
    /*[ShareSDK connectRenRenWithAppKey:@"271562"
     appSecret:@"6f3dceef12df4d96916ebeb12647ce58"];//人人登陆
     */
    [ShareSDK connectKaiXinWithAppKey:@"425874573260578ac06836526d974c88"
                            appSecret:@"540cb60b24258a514cf21244704b4fcd"
                          redirectUri:@"http://www.zzia.edu.cn"];//开心网
    
    /*[ShareSDK connectQQWithQZoneAppKey:@"1102491810"
     qqApiInterfaceCls:[QQApiInterface class]
     tencentOAuthCls:[TencentOAuth class]];//腾讯
     
     [ShareSDK connectQZoneWithAppKey:@"1102491810"
     appSecret:@"aed9b0303e3ed1e27bae87c33761161d"
     qqApiInterfaceCls:[QQApiInterface class]
     tencentOAuthCls:[TencentOAuth class]];//腾讯
     */
    [Parse setApplicationId:@"ZPQFFIVutBAe5PzDfQT6BsKkisMo331l9boDM99t"
                  clientKey:@"WiFIK1he9xLG2R639dZW6rBKufuJLej5wMR28mCS"];
}
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - share
- (BOOL)application:(UIApplication *)application
      handleOpenURL:(NSURL *)url
{
    return [ShareSDK handleOpenURL:url
                        wxDelegate:self];
}

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation
{
    return [ShareSDK handleOpenURL:url
                 sourceApplication:sourceApplication
                        annotation:annotation
                        wxDelegate:self];
}
@end
