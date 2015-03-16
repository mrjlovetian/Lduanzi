//
//  UserViewController.h
//  test
//
//  Created by baoyuan on 14-9-2.
//  Copyright (c) 2014年 baoyuan. All rights reserved.
//

#import <UIKit/UIKit.h>
@class UserModel;
@interface UserViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, retain)NSString *userId;
@property (nonatomic, retain)UserModel *user;
@end
