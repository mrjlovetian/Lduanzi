//
//  UserModel.h
//  test
//
//  Created by baoyuan on 14-9-2.
//  Copyright (c) 2014年 baoyuan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserModel : NSObject
@property (nonatomic, retain)NSString *description;//描述
@property (nonatomic, retain)NSString *point;//分数
@property (nonatomic, retain)NSString *userName;//用户名
@property (nonatomic, retain)NSString *userPicture;//用户头像
@property (nonatomic, retain)NSString *ugc;//投稿
@property (nonatomic, retain)NSString *comment;//评论
@property (nonatomic, retain)NSString *essay;//收藏

@end
