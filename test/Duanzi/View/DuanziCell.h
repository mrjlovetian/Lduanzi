//
//  DuanziCell.h
//  test
//
//  Created by baoyuan on 14-9-1.
//  Copyright (c) 2014年 baoyuan. All rights reserved.
//

#import <UIKit/UIKit.h>


@class Duanzi;
@class AsynlmageView;
@class DuanziCell;
@class BTRippleButtton;

@class MCFireworksButton;
//@class LLL;
@protocol cellPostVlaue<NSObject>

- (void)cellPrint:(DuanziCell *)cell;
- (void)message:(MCFireworksButton *)btn;
//- (void)changeBtn:(MCFireworksButton *)btn;
- (void)changColorlikeBtn:(DuanziCell *)cell;
- (void)changColorassigntBtn:(DuanziCell *)cell;
@end

@interface DuanziCell : UITableViewCell


@property (nonatomic, retain)AsynlmageView *userImage;
@property (nonatomic, retain)UIButton *userBtn;
@property (nonatomic, retain)UILabel *contentLab;
@property (nonatomic, retain)MCFireworksButton *likeBtn;
@property (nonatomic, retain)MCFireworksButton *assginBtn;
@property (nonatomic, retain)UIButton *hotData;
@property (nonatomic, retain)Duanzi *cellDuanzi;
@property (nonatomic, retain)NSString *userId;

@property (nonatomic, retain)AsynlmageView *hotIM;
@property (nonatomic, retain)UILabel *likeLab;
@property (nonatomic, retain)UILabel *assigntLab;
@property (nonatomic, retain)UILabel *pinglunLab;
@property (nonatomic, retain)UIView *view;

@property (nonatomic, retain)UIButton *shareBtn;
@property (nonatomic, retain)NSString *isTure;

@property (nonatomic, assign)BOOL Dselect;
@property (nonatomic, retain)NSMutableArray *likeArray;
+ (CGFloat)getCellHeight:(Duanzi *)duanzi;
@property (nonatomic, assign)id<cellPostVlaue> delegate;
@end
