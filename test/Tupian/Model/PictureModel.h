//
//  PictureModel.h
//  test
//
//  Created by baoyuan on 14-9-3.
//  Copyright (c) 2014年 baoyuan. All rights reserved.
//

#import "Duanzi.h"

@interface PictureModel : Duanzi<NSCoding>
@property (nonatomic, retain)NSString *tConUrl;
@property (nonatomic, retain)NSString *tWeight;
@property (nonatomic, retain)NSString *tHeight;
@property (nonatomic, retain)NSString *tDespircet;
@end
