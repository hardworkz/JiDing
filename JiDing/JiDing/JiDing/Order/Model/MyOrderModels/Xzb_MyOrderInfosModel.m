//
//  Xzb_MyOrderInfosModel.m
//  xzb
//
//  Created by rainze on 16/7/25.
//  Copyright © 2016年 xuwk. All rights reserved.
//

#import "Xzb_MyOrderInfosModel.h"

@implementation Xzb_MyOrderInfosModel
{
    NSInteger _index;
}
+ (void)load
{
    [Xzb_MyOrderInfosModel mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
        return @{
                 @"ID" : @"id",
                 @"descriptions":@"description"
                 };
    }];
}

- (NSString *)businessPhoto
{
    return [RTHttpTool returnPhotoStringWithString:_businessPhoto];
}

- (BOOL)cancleEnable
{
    _index = 0;
    
    if (self.payDate.length && [self.orderStatus integerValue] == 2 && [self.checkinStatus integerValue] == 2) {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSDate *payTime = [formatter dateFromString:self.payDate];
        NSDate *seTime = [formatter dateFromString:self.serverDate];
        NSTimeInterval seconds = [seTime timeIntervalSinceDate:payTime];
        
        if (seconds <= 15*60 && seconds > 0 && [_payType integerValue] != 6) {
            self.seconds = 15*60 - seconds;
            return YES;
        }else {
            return NO;
        }
    }else {
        return NO;
    }
    
}

@end
