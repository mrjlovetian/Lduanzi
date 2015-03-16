//
//  ShoucangViewController.h
//  test
//
//  Created by baoyuan on 14-9-3.
//  Copyright (c) 2014年 baoyuan. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Duanzi;
@interface ShoucangViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, retain)NSString *userId;
@property (nonatomic, retain)NSMutableArray *userArray;
@property (nonatomic, retain)Duanzi *duanzi;
@end
