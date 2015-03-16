//
//  PinglunCell.h
//  test
//
//  Created by baoyuan on 14-9-2.
//  Copyright (c) 2014年 baoyuan. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AsynlmageView;
@class PinglunModel;
@interface PinglunCell : UITableViewCell
@property (nonatomic, retain)AsynlmageView *userImage;
@property (nonatomic, retain)UILabel *userLab;
@property (nonatomic, retain)UILabel *timeLab;
@property (nonatomic, retain)UILabel *contentLab;
@property (nonatomic, retain)UILabel *pingContantLab;
@property (nonatomic, retain)PinglunModel *plmode;
@property (nonatomic, retain)UIView *baView;
+ (CGFloat)getCellHeight:(PinglunModel *)plmode;
@end
