//
//  Duanzi.m
//  test
//
//  Created by baoyuan on 14-9-1.
//  Copyright (c) 2014年 baoyuan. All rights reserved.
//

#import "Duanzi.h"

@implementation Duanzi
#pragma mark - NScoding
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    //对name进行编码, 通过键值编码
    [aCoder encodeObject:self.userName forKey:@"NAME"];
    [aCoder encodeObject:self.userImageUrl forKey:@"USERIMAGE"];
    [aCoder encodeObject:self.userId forKey:@"USERID"];
    [aCoder encodeObject:self.hotDot forKey:@"HOT"];
    [aCoder encodeObject:self.like forKey:@"LIKE"];
    [aCoder encodeObject:self.assignt forKey:@"ASSIGNT"];
    [aCoder encodeObject:self.content forKey:@"CONTENT"];
    [aCoder encodeObject:self.groupId forKey:@"GROUPID"];
    //[aCoder encodeBool:self.select forKey:@"BOOL"];
}
- (id)initWithCoder:(NSCoder *)aDecoder;
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
        //self.select = [aDecoder decodeBoolForKey:@"BOOL"];
    }
    return self;
}
@end
