//
//  HomeViewController.h
//  test
//
//  Created by baoyuan on 14-9-1.
//  Copyright (c) 2014年 baoyuan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeViewController : UIViewController<UITableViewDelegate, UITableViewDataSource, UITabBarControllerDelegate>
@property (nonatomic, retain)NSMutableArray *showArray;

@end
