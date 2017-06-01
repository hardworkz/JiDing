//
//  Xzb_ApplicationData.m
//  xzb
//
//  Created by 张荣廷 on 16/8/15.
//  Copyright © 2016年 xuwk. All rights reserved.
//

#import "Xzb_ApplicationData.h"

@implementation Xzb_ApplicationData
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.bankCardNum forKey:@"bankCardNum"];
    [aCoder encodeObject:self.bankCardTypeName forKey:@"bankCardTypeName"];
    [aCoder encodeObject:self.bankTypeName forKey:@"bankTypeName"];
    [aCoder encodeObject:self.isShowUpdate forKey:@"isShowUpdate"];
    [aCoder encodeObject:self.bankCount forKey:@"bankCount"];[aCoder encodeObject:self.orderNo forKey:@"orderNo"];
    [aCoder encodeObject:self.purpose forKey:@"purpose"];
    [aCoder encodeObject:self.user_x forKey:@"user_x"];
    [aCoder encodeObject:self.user_y forKey:@"user_y"];
    [aCoder encodeObject:self.userAddress forKey:@"userAddress"];
    [aCoder encodeObject:self.township forKey:@"township"];
    [aCoder encodeObject:self.roomNum forKey:@"roomNum"];
    [aCoder encodeObject:self.dayNum forKey:@"dayNum"];
    [aCoder encodeObject:self.areaName forKey:@"areaName"];
    [aCoder encodeBool:self.isFirst forKey:@"isFirst"];

}
//从文件中取出解析
- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        self.bankCardNum = [aDecoder decodeObjectForKey:@"bankCardNum"];
        self.bankCardTypeName = [aDecoder decodeObjectForKey:@"bankCardTypeName"];
        self.bankTypeName = [aDecoder decodeObjectForKey:@"bankTypeName"];
        self.isShowUpdate = [aDecoder decodeObjectForKey:@"isShowUpdate"];
        self.bankCount = [aDecoder decodeObjectForKey:@"bankCount"];self.orderNo = [aDecoder decodeObjectForKey:@"orderNo"];
        self.purpose = [aDecoder decodeObjectForKey:@"purpose"];
        self.user_x = [aDecoder decodeObjectForKey:@"user_x"];
        self.user_y = [aDecoder decodeObjectForKey:@"user_y"];
        self.userAddress = [aDecoder decodeObjectForKey:@"userAddress"];
        self.township = [aDecoder decodeObjectForKey:@"township"];
        self.roomNum = [aDecoder decodeObjectForKey:@"roomNum"];
        self.dayNum = [aDecoder decodeObjectForKey:@"dayNum"];
        self.areaName = [aDecoder decodeObjectForKey:@"areaName"];
        self.isFirst = [aDecoder decodeBoolForKey:@"isFirst"];
    }
    return self;
}

@end
