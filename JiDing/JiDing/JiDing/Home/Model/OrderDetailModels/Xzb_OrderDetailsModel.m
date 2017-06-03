//
//  Xzb_OrderDetailModel.m
//  xzb
//
//  Created by 张荣廷 on 16/7/26.
//  Copyright © 2016年 xuwk. All rights reserved.
//

#import "Xzb_OrderDetailsModel.h"

@implementation Xzb_OrderDetailsModel
- (void)setCheckinDate:(NSString *)checkinDate
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *checkDate = [formatter dateFromString:checkinDate];
    [formatter setDateFormat:@"yyyy年MM月dd日"];
    checkinDate = [formatter stringFromDate:checkDate];
    _checkinDate = checkinDate;
}
- (void)setLeaveDate:(NSString *)leaveDate
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *checkDate = [formatter dateFromString:leaveDate];
    [formatter setDateFormat:@"yyyy年MM月dd日"];
    leaveDate = [formatter stringFromDate:checkDate];
    _leaveDate = leaveDate;
}
//+ (NSDictionary *)mj_objectClassInArray
//{
//    return @{@"guestInfoList":[Xzb_CheckInPeopleModel class]};
//}
+ (void)load
{
    [Xzb_OrderDetailsModel mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
        return @{@"orderId":@"id",@"descriptions":@"description"};
    }];
}

- (BOOL)cancleEnable
{
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *now = [NSDate date];
    NSDate *payTime = [formatter dateFromString:_payDate];
    NSTimeInterval seconds = [now timeIntervalSinceDate:payTime];
    if (seconds < 15 * 60 && [_checkinStatus integerValue] == 2&& [_orderStatus integerValue] == 2) {
        return YES;
    }else {
        return NO;
    }
}

- (NSString *)totalIncome
{
    //    if ([self.payType integerValue] == 2) {
    //        return [NSString stringWithFormat:@"%.2f",[_totalIncome doubleValue] / 2];
    //    }else {
    return _totalIncome;
    //    }
}

- (NSString *)realPrice
{
    if ([self.payType integerValue] == 2) {
        return [NSString stringWithFormat:@"%.2f",[_totalIncome doubleValue] / 2];
    }else {
        return _totalIncome;
    }
}

//- (NSString *)price
//{
//    if ([self.payType integerValue] == 2) {
//        return [NSString stringWithFormat:@"%.2f",[_price doubleValue] / 2];
//    }else {
//        return _price;
//    }
//}

- (NSArray *)userInfoArray {
    NSArray *array =  [_guestInfo componentsSeparatedByString:@","];
    if (array.count >= 3) {
        return @[array[1],array[2]];
    }else {
        return array;
    }
}

@end
