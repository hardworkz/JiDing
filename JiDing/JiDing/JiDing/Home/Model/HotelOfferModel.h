//
//  HotelOfferModel.h
//  xzb
//
//  Created by 张荣廷 on 16/6/9.
//  Copyright © 2016年 xuwk. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 {"ylocation":"118.181564"
 ,"timePeriod":0
 ,"orderType":"1"
 ,"countDown":5
 ,"image":"user5-128x128.png"
 ,"roomId":136
 ,"hotelId":80
 ,"distance":1.13
 ,"level":"4"
 ,"price":"0.02"
 ,"xlocation":"24.488284"
 ,"roomType":"2"
 ,"orderRelId":28468
 ,"name":"%E4%BD%B0%E7%BF%94%E8%BD%AF%E4%BB%B6%E5%9B%AD%E9%85%92%E5%BA%97"
 ,"payType":"1"
 ,"appraise":90
 }
 */
@interface HotelOfferModel : NSObject
@property (nonatomic,strong) NSString *hotelId;/**<酒店ID*/
@property (nonatomic,strong) NSString *name;/**<酒店名称*/
@property (nonatomic,strong) NSString *image;/**<酒店图片*/
@property (nonatomic,strong) NSString *appraise;/**<酒店好评率*/
@property (nonatomic,strong) NSString *score;/**<酒店平均评分*/
@property (nonatomic,strong) NSString *countDown;/**<付款倒计时(分钟)*/
@property (nonatomic,strong) NSString *roomId;/**<房间ID*/
@property (nonatomic,strong) NSString *roomType;/**<房型*/
@property (nonatomic,strong) NSString *roomName;/**<房型名称*/
@property (nonatomic,strong) NSString *level;/**<酒店星级*/
@property (nonatomic,strong) NSString *price;/**<报价价格*/
@property (nonatomic,strong) NSString *distance;/**<距离*/
@property (nonatomic,strong) NSString *distanceStr;/**<距离带单位*/
@property (nonatomic,strong) NSString *payType;/**<付款方式*/
@property (nonatomic,strong) NSString *orderRelId;/**<报价ID*/
@property (nonatomic,strong) NSString *xlocation;/**<酒店纬度*/
@property (nonatomic,strong) NSString *ylocation;/**<酒店经度*/
@property (nonatomic,strong) NSString *timePeriod;/**<钟点房时间*/
@property (nonatomic,strong) NSString *orderType;/**<区别全日房和钟点房*/
@property (nonatomic,strong) NSString *seconds;/**<倒计时时间*/
@property (nonatomic,strong) NSTimer *timer;/**<模型定时器付款倒计时*/
@property (nonatomic,assign) BOOL starAction;/**<模型定时器付款倒计时*/
- (void)attAction;
@end
