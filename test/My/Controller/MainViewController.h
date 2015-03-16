//
//  MainViewController.h
//  TestLogin
//
//  Created by baoyuan on 14-9-4.
//  Copyright (c) 2014年 baoyuan. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol changValue <NSObject>

- (void)changValue:(NSString *)str userImage:(NSString *)image;

@end

@interface MainViewController : UIViewController
@property (nonatomic, assign)id<changValue> delegate;
@property (nonatomic, retain)NSString *userIMurl;
@property (nonatomic, retain)NSString *userName;

@property (nonatomic, retain)UILabel *infoLab;
@end
