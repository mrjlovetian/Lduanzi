//
//  system settings settingsViewController.h
//  MyMovie
//
//  Created by 韩森 on 14-8-12.
//  Copyright (c) 2014年 lanou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SystemSettingsViewController : UIViewController <UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, retain)UITableView * tableView;
@property (nonatomic, retain)UILabel *cacheLab;
@end
