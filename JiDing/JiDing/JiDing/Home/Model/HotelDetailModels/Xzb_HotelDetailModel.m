//
//  Xzb_HotelDetailModel.m
//  xzb
//
//  Created by 张荣廷 on 16/7/25.
//  Copyright © 2016年 xuwk. All rights reserved.
//

#import "Xzb_HotelDetailModel.h"

@implementation Xzb_HotelDetailModel
+ (void)load
{
    [Xzb_HotelDetailModel mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
        return @{@"descriptions":@"description"};
    }];
}
- (NSMutableArray *)roomPhotoArray
{
    if (_roomPhotoArray == nil) {
        _roomPhotoArray = [NSMutableArray array];
    }
    if (_roomPhotoArray.count != 0) {
        return _roomPhotoArray;
    }
    NSArray *array = [_roomPhoto componentsSeparatedByString:@","];
    [_roomPhotoArray removeAllObjects];
    for (NSString *string in array) {
        Xzb_PhotoModel *model = [[Xzb_PhotoModel alloc] init];
        model.photoUrl = string;
        [_roomPhotoArray addObject:model];
    }

    return _roomPhotoArray;
}
- (NSString *)businessPhoto
{
    return [RTHttpTool returnPhotoStringWithString:_businessPhoto];
}

- (NSArray *)typeArray
{
    return [_payType componentsSeparatedByString:@","];
}
- (NSString *)width
{
    return [NSString stringWithFormat:@"%.f",[_width floatValue] / 100];
}
- (NSString *)roomDays
{
    if ([self.orderType integerValue] == 2) {
        int hour = 0;
        if ([self.timePeriod intValue] == 1) {
            hour = 3;
        }else if ([self.timePeriod intValue] == 2){
            hour = 4;
        }else if ([self.timePeriod intValue] == 3){
            hour = 5;
        }
        return [NSString stringWithFormat:@"%zd小时",hour];
    }
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *arriveDay = [formatter dateFromString:_checkinDate];
    NSDate *leaveDay = [formatter dateFromString:_leaveDate];
    NSTimeInterval seconds = [leaveDay timeIntervalSinceDate:arriveDay];
    NSInteger day = seconds / (24 * 60 *60);
    return [NSString stringWithFormat:@"共%@间%zd晚",_roomNum,day];
}

- (NSString *)nights
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *arriveDay = [formatter dateFromString:_checkinDate];
    NSDate *leaveDay = [formatter dateFromString:_leaveDate];
    NSTimeInterval seconds = [leaveDay timeIntervalSinceDate:arriveDay];
    NSInteger day = seconds / (24 * 60 *60);
    return [NSString stringWithFormat:@"%zd",day];
}

- (NSString *)totalPrice
{
    float total;
    if ([self.orderType integerValue] == 2) {
        total = [self.price doubleValue] * [self.roomNum integerValue];
    }else {
        total = [self.roomNum integerValue] * [self.nights integerValue] *[self.price doubleValue];
    }
    if ([self.orderBusinessLevel integerValue] == 6) {
        return @"1.00";
    }else if (self.typeArray.count == 1) {
        if ([self.typeArray.firstObject integerValue] == 2) {
            return [NSString stringWithFormat:@"%.2f",total];
        }else {
            return [NSString stringWithFormat:@"%.2f",total];
        }
    }else {
        return [NSString stringWithFormat:@"%.2f",total];
    }
}

- (NSString *)roomPrice
{
    float total;
    if ([self.orderType integerValue] == 2) {
        total = [self.price doubleValue] * [self.roomNum integerValue];
    }else {
        total = [self.roomNum integerValue] * [self.nights integerValue] *[self.price doubleValue];
    }
    if ([self.orderBusinessLevel integerValue] == 6) {
        return @"1.00";
    }else if (self.typeArray.count == 1) {
        if ([self.typeArray.firstObject integerValue] == 2) {
            return [NSString stringWithFormat:@"%.2f",total / 2];
        }else {
            return [NSString stringWithFormat:@"%.2f",total];
        }
    }else {
        return [NSString stringWithFormat:@"%.2f",total];
    }
}

@end
