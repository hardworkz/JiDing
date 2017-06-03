//
//  WXPayUtils.h
//  xiuse
//
//  Created by yanhuilv on 16/3/20.
//  Copyright © 2016年 lyhcn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OrderInfo.h"
#import "WXApi.h"

@interface WXPayUtils : NSObject

+ (void)jumpToBizPay:(UIViewController *) viewController orderInfo:(OrderInfo*) orderInfo;

@end
