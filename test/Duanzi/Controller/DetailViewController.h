//
//  DetailViewController.h
//  test
//
//  Created by baoyuan on 14-9-3.
//  Copyright (c) 2014年 baoyuan. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Duanzi;

@interface DetailViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, retain)Duanzi *duanzi;
@property (nonatomic, retain)NSMutableArray *deatialArray;
@end
