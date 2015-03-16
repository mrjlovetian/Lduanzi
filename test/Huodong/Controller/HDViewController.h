//
//  HDViewController.h
//  test
//
//  Created by baoyuan on 14-9-4.
//  Copyright (c) 2014年 baoyuan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HDViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, retain)NSMutableArray *tPictureArray;
@property (nonatomic, retain)NSString *hUserCount;
@property (nonatomic, retain)NSString *hTitle;
@property (nonatomic, retain)NSString *hText;
@property (nonatomic, retain)NSString *hStartTime;
@property (nonatomic, retain)NSString *hEndTime;
@property (nonatomic, retain)NSString *hWidth;
@property (nonatomic, retain)NSString *hHeight;
@property (nonatomic, retain)NSString *hImageUrl;

@property (nonatomic, retain)NSMutableArray *bigArray;
@property (nonatomic, retain)NSMutableArray *detailArray;
@end
