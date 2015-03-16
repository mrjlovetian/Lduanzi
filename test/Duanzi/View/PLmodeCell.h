//
//  PLmodeCell.h
//  test
//
//  Created by baoyuan on 14-9-3.
//  Copyright (c) 2014年 baoyuan. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AsynlmageView;
@class PLModel;
@interface PLmodeCell : UITableViewCell
@property (nonatomic, retain)AsynlmageView *userPicture;
@property (nonatomic, retain)UILabel *userLab;
@property (nonatomic, retain)UILabel *timeLab;
@property (nonatomic, retain)UILabel *pinglunLab;
@property (nonatomic, retain)PLModel *plMode;

@property (nonatomic, retain)UIView *view;
+ (CGFloat)getCellHeight:(PLModel *)plmode;
@end
