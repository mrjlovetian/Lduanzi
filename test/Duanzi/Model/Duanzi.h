//
//  Duanzi.h
//  test
//
//  Created by baoyuan on 14-9-1.
//  Copyright (c) 2014年 baoyuan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Duanzi : NSObject<NSCoding>
@property (nonatomic, retain)NSString *userName;//用户名
@property (nonatomic, retain)NSString *userImageUrl;//用户头像
@property (nonatomic, retain)NSString *userId;//用户ID

@property (nonatomic, retain)NSString *hotDot;//热点
@property (nonatomic, retain)NSString *like;//赞成
@property (nonatomic, retain)NSString *assignt;//反对
@property (nonatomic, retain)NSString *content;//内容
@property (nonatomic, retain)NSString *groupId;

//@property (nonatomic, assign)BOOL select;
@end
