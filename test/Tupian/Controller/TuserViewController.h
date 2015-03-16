//
//  TuserViewController.h
//  test
//
//  Created by baoyuan on 14-9-3.
//  Copyright (c) 2014年 baoyuan. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TuserModel;

@interface TuserViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, retain)NSString *userId;
@property (nonatomic, retain)TuserModel *tuser;
@end
