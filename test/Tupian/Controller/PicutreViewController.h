//
//  PicutreViewController.h
//  test
//
//  Created by baoyuan on 14-9-3.
//  Copyright (c) 2014年 baoyuan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PicutreViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, retain)NSMutableArray *tPictureArray;
@end
