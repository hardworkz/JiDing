//
//  Xzb_MyOrderInfosModel.h
//  xzb
//
//  Created by rainze on 16/7/25.
//  Copyright © 2016年 xuwk. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 {"orderBusinessLevel":"2"
 ,"businessId":52
 ,"id":8513
 ,"payType":"1"
 ,"totalIncome":"0.01"
 ,"roomType":"1"
 ,"timePeriod":2
 ,"orderCode":"xzb201607181102082688"
 ,"cancelTime":5
 ,"serverDate":"2016-07-22 18:16:02"
 ,"payDate":"2016-07-18 11:13:54"
 ,"checkinDate":"2016-07-18 11:14:24"
 ,"leaveDate":"2016-07-19 00:00:00"
 ,"description":"1晚/1间  |   浪漫圆床房    |  ￥ 0.01"
 ,"orderDate":"2016-07-18 11:13:37"
 ,"checkinStatus":"4"
 ,"businessName":"尚客优快捷酒店"
 ,"roomPhoto":"//business//room\82\8103915ff59345359c6998602c458127.png,//business//room\82\0f00ea39a24e4e00ab8e38187c81f153.png"
 ,"businessLevel":"2"
 ,"businessPhoto":"user5-128x128.png"
 ,"price":"0.01"
 ,"orderUserid":195
 ,"orderType":"1"
 ,"isToday":0
 ,"orderStatus":"2"
 }
 */


@interface Xzb_MyOrderInfosModel : NSObject

@property (nonatomic, copy) NSString *orderBusinessLevel;
@property (nonatomic, copy) NSString *businessId;
@property (nonatomic, copy) NSString *ID;
@property (nonatomic, copy) NSString *payType;
@property (nonatomic, copy) NSString *totalIncome;

/** 房型
 1:大床房 2:标准房 3:商务房 4:家庭房
 */
@property (nonatomic, copy) NSString *roomType;

@property (nonatomic, copy) NSString *timePeriod;
@property (nonatomic, copy) NSString *orderCode;
@property (nonatomic, copy) NSString *cancelTime;
@property (nonatomic, copy) NSString *serverDate;
@property (nonatomic, copy) NSString *payDate;
@property (nonatomic, copy) NSString *checkinDate;
@property (nonatomic, copy) NSString *leaveDate;
@property (nonatomic, copy) NSString *descriptions;
@property (nonatomic, copy) NSString *orderDate;

/** 入住状态
 -1:已取消 2:待入住 3:已入住 4:已离店 6:预定未入住
 */
@property (nonatomic, copy) NSString *checkinStatus;

@property (nonatomic, copy) NSString *businessName;
@property (nonatomic, copy) NSString *roomPhoto;

/** 酒店星级
 0:民宿客栈 1:快捷连锁 2:二星/经济 3:三星/舒适 4:四星/高档 5:五星/豪华 6:一元酒店
 */
@property (nonatomic, copy) NSString *businessLevel;

@property (nonatomic, copy) NSString *businessPhoto;
@property (nonatomic, copy) NSString *price;
@property (nonatomic, copy) NSString *orderUserid;
@property (nonatomic, copy) NSString *orderType;
@property (nonatomic, copy) NSString *isToday;

/**订单状态 orderStatus
 -4:取消待商家确认  -3:已退款 -2:退款中 -1:已取消 0:待接单 1:待付款 2:已付款 3:已评价
 */
@property (nonatomic, copy) NSString *orderStatus;

@property (nonatomic, copy) NSString *roomName;

@property (nonatomic, assign) BOOL cancleEnable; // 是否在退款时间内
@property (nonatomic, assign) NSInteger seconds;

@end
