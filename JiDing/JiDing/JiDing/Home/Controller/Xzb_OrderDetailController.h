//
//  Xzb_OrderDetailController.h
//  xzb
//
//  Created by 张荣廷 on 16/7/26.
//  Copyright © 2016年 xuwk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Xzb_OrderDetailController : RootViewController
@property (nonatomic,strong) NSString *orderRelID;
@property (nonatomic,strong) NSString *orderID;
@property (nonatomic,assign)  BOOL isPopRootVC;
@property (nonatomic, strong) HotelOfferModel *offerModel;
@property (nonatomic, copy) void(^cancleOrder)();
@property (nonatomic, copy) void(^didChange)();

@end
