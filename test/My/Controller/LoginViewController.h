//
//  LoginViewController.h
//  test
//
//  Created by baoyuan on 14-9-6.
//  Copyright (c) 2014年 baoyuan. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol successLogn <NSObject>

- (void)successLogn:(NSString *)userImage userName:(NSString *)name;
@end

@interface LoginViewController : UIViewController
@property (nonatomic, assign)id <successLogn> delegate;
@end
