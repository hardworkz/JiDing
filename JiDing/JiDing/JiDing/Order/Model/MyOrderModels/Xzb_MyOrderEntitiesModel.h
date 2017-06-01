//
//  Xzb_MyOrderEntitiesModel.h
//  xzb
//
//  Created by rainze on 16/7/25.
//  Copyright © 2016年 xuwk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Xzb_MyOrderInfosModel.h"
#import "Xzb_MyOrderMetaModel.h"
/**
 "entities":{"orderInfos":[{"orderBusinessLevel":"2"
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
 }],"meta":{"total":14
 ,"totalPage":2
 }}
 */

@interface Xzb_MyOrderEntitiesModel : NSObject

@property (nonatomic, strong) NSArray<Xzb_MyOrderInfosModel *> *orderInfos;
@property (nonatomic, strong) Xzb_MyOrderMetaModel *meta;

@end
