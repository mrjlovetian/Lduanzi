//
//  TpiceturCell.h
//  test
//
//  Created by baoyuan on 14-9-3.
//  Copyright (c) 2014年 baoyuan. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AsynlmageView;
@class PictureModel;
@class MCTopAligningLabel;
@class TpiceturCell;

@class MCFireworksButton;
@protocol enjoy <NSObject>

- (void)rootUser:(TpiceturCell *)cell;
- (void)message:(MCFireworksButton *)btn;
- (void)changColorlikeBtn:(TpiceturCell *)cell;
- (void)changColorassigntBtn:(TpiceturCell *)cell;
@end
@interface TpiceturCell : UITableViewCell

@property (nonatomic, retain)AsynlmageView *contIm;
@property (nonatomic, retain)UIButton *userName;
@property (nonatomic, retain)UILabel *txtLab;
@property (nonatomic, retain)AsynlmageView *userIm;
@property (nonatomic, retain)PictureModel *pictureMode;
@property (nonatomic, retain)MCFireworksButton *likeBtn;
@property (nonatomic, retain)MCFireworksButton *assginBtn;

@property (nonatomic, retain)UIButton *shareBtn;
@property (nonatomic, retain)AsynlmageView *hotIM;
@property (nonatomic, retain)UILabel *likeLab;
@property (nonatomic, retain)UILabel *assigntLab;
@property (nonatomic, retain)UILabel *pinglunLab;

@property (nonatomic, retain)UILabel *spaceLab;
@property (nonatomic, assign)id <enjoy> delegate;
@property (nonatomic, retain)NSString *isTure;
@property (nonatomic, retain)UIView *view;

@property (nonatomic, assign)BOOL Dselect;
@property (nonatomic, retain)NSMutableArray *likeArray;
//@property (nonatomic, retain)NSString *userId;
+ (CGFloat)getCellHeight:(PictureModel *)pictureMode;
@end
