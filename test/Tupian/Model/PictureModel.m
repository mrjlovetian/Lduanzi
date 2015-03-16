//
//  PictureModel.m
//  test
//
//  Created by baoyuan on 14-9-3.
//  Copyright (c) 2014年 baoyuan. All rights reserved.
//

#import "PictureModel.h"

@implementation PictureModel
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [super encodeWithCoder:aCoder];
    [aCoder encodeObject:self.tDespircet forKey:@"DESPIRECT"];
    [aCoder encodeObject:self.tConUrl forKey:@"CONURL"];
    [aCoder encodeObject:self.tHeight forKey:@"HEIGHT"];
    [aCoder encodeObject:self.tWeight forKey:@"WEITH"];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        //对name进行解码, 通过键值解码
        self.userName = [aDecoder decodeObjectForKey:@"NAME"];
        self.userImageUrl = [aDecoder decodeObjectForKey:@"USERIMAGE"];
        self.userId = [aDecoder decodeObjectForKey:@"USERID"];
        self.groupId = [aDecoder decodeObjectForKey:@"GROUPID"];
        self.hotDot = [aDecoder decodeObjectForKey:@"HOT"];
        self.like = [aDecoder decodeObjectForKey:@"LIKE"];
        self.assignt = [aDecoder decodeObjectForKey:@"ASSIGNT"];
        self.content = [aDecoder decodeObjectForKey:@"CONTENT"];
        self.tDespircet = [aDecoder decodeObjectForKey:@"DESPIRECT"];
        self.tConUrl = [aDecoder decodeObjectForKey:@"CONURL"];
        self.tHeight = [aDecoder decodeObjectForKey:@"HEIGHT"];
        self.tWeight = [aDecoder decodeObjectForKey:@"WEITH"];
        
    }
    return self;
}
@end
