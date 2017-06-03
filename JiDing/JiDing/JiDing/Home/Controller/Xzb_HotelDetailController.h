//
//  Xzb_HotelDetailController.h
//  xzb
//
//  Created by 张荣廷 on 16/7/15.
//  Copyright © 2016年 xuwk. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HotelOfferModel;
@interface Xzb_HotelDetailController : RootViewController
@property (nonatomic,strong) NSString *orderID;
@property (nonatomic,strong) NSString *orderRelID;
@property (nonatomic,strong) NSString *businessID;
@property (nonatomic,strong) HotelOfferModel *model;
@property (nonatomic, assign) BOOL isComment;
@end
