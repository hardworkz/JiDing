//
//  PayUtils.h
//  xiuse
//
//  Created by yanhuilv on 16/4/24.
//  Copyright © 2016年 lyhcn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "OrderInfo.h"


@protocol PayDelegate <NSObject>

@optional

- (void)payCallback:(NSDictionary *)response;

@end
typedef NS_ENUM(NSInteger, PayType)
{
    PayTypeRecharge = 0,// 只显示当前月之前
    PayTypePay
};
@interface PayUtils : NSObject


@property (nonatomic, assign) id<PayDelegate> delegate;

- (void) wxpayfor:(UIViewController *) viewController orderInfo:(OrderInfo*) orderInfo;

- (void) alipayfor:(OrderInfo *)orderInfo param:(NSDictionary *)param payType:(PayType)payType;

+(instancetype)sharedUtils;
@end
