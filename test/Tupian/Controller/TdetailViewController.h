//
//  TdetailViewController.h
//  test
//
//  Created by baoyuan on 14-9-3.
//  Copyright (c) 2014年 baoyuan. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PictureModel;
@interface TdetailViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, retain)PictureModel *duanzi;
@property (nonatomic, retain)NSMutableArray *deatialArray;
@property (nonatomic, retain)NSMutableArray *bigArray;
@property (nonatomic, retain)NSMutableArray *smallArray;
@end
