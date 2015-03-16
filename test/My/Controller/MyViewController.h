//
//  MyViewController.h
//  test
//
//  Created by baoyuan on 14-9-5.
//  Copyright (c) 2014年 baoyuan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, UIActionSheetDelegate>
@property (nonatomic, retain)NSArray * markArray;
@property (nonatomic, retain)NSArray * textArray;

@property (nonatomic, retain)UILabel * loginLab;

@end
