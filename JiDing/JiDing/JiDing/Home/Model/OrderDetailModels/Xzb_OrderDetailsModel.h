//
//  Xzb_OrderDetailModel.h
//  xzb
//
//  Created by 张荣廷 on 16/7/26.
//  Copyright © 2016年 xuwk. All rights reserved.
//

#import <Foundation/Foundation.h>
/*
 {"id":8731
 ,"orderCode":"xzb201607201354591561"
 ,"payCode":"2016072021001004120221831599"
 ,"payChannel":"2"
 ,"roomType":"1"
 ,"payType":"1"
 ,"payDate":"2016-07-20 13:55:35"
 ,"orderDate":"2016-07-20 13:55:17"
 ,"description":"1晚/1间  |   清新大床房    |  ￥ 0.01"
 ,"orderUserid":69
 ,"guestInfo":"哦哦哦,15805926167"
 ,"checkinDate":"2016-07-20 00:00:00"
 ,"leaveDate":"2016-07-21 00:00:00"
 ,"roomId":135
 ,"num":1
 ,"price":"0.01"
 ,"totalIncome":"0.01"
 ,"arriveTime":"20:00之前"
 ,"orderType":"1"
 ,"orderChannel":""
 ,"orderStatus":"-3"
 ,"remark":""
 ,"breakfast":"1"
 ,"pick":"1"
 ,"cancelTime":5
 ,"pickTime":""
 ,"businessId":80
 ,"timePeriod":0
 ,"xLocation":"24.488589"
 ,"yLocation":"118.188118"
 ,"checkinStatus":"2"
 ,"checkinStatuss":""
 ,"checkinStatusList":[],"businessLevel":"4"
 ,"orderBusinessLevel":"2"
 ,"businessPhoto":""
 ,"refundCode":""
 ,"guaranteeMoney":""
 ,"cancelRemark":""
 ,"startDate":""
 ,"startDateStr":""
 ,"endDate":""
 ,"endDateStr":""
 ,"dateGap":1
 ,"phone":"15805926167"
 ,"userName":"九暮"
 ,"relaId":0
 ,"isToday":"0"
 ,"guestInfoList":[{"userName":"哦哦哦"
 ,"phone":"15805926167"
 ,"roomNum":""
 }],"orderToday":""
 ,"distance":""
 ,"businessName":"佰翔软件园酒店"
 ,"businessPhone":"15805926167"
 ,"businessLocation":"软件园二期"
 ,"serverDate":"2016-07-22 15:06:37"
 ,"roomPhoto":"//business//room\135\60d3afb41b5346e89687145334baa537.png"
 ,"bedType":""
 ,"floorStart":""
 ,"floorEnd":""
 ,"isWindow":""
 ,"useArea":""
 ,"wifi":""
 ,"supportNum":""
 ,"supportEquipment":""
 ,"media":""
 ,"diet":""
 ,"showerRoom":""
 ,"agentName":""
 ,"couponId":""
 ,"couponMoney":""
 ,"givePay":""
 ,"accountPay":""
 ,"ausid":0
 ,"busid":0
 }
 */
@interface Xzb_OrderDetailsModel : NSObject
@property (nonatomic,strong) NSString *orderId;/**<订单ID*/
@property (nonatomic,strong) NSString *businessId;/**<酒店ID*/
@property (nonatomic,strong) NSString *orderCode;/**<订单编号*/
@property (nonatomic,strong) NSString *descriptions;/**<订单描述*/
@property (nonatomic,strong) NSString *payDate;/**<下单时间*/
@property (nonatomic,strong) NSString *businessName;/**<酒店名称*/
@property (nonatomic,strong) NSString *payType;/**<支付类型*/
@property (nonatomic,strong) NSString *price;/**<订单价格*/
@property (nonatomic,strong) NSString *totalIncome;/**<订单价格*/
@property (nonatomic,strong) NSString *checkinDate;/**<入住时间*/
@property (nonatomic,strong) NSString *leaveDate;/**<离店时间*/
@property (nonatomic,strong) NSString *num;/**<房间数*/
@property (nonatomic,strong) NSString *dateGap;/**<入住天数*/
@property (nonatomic,strong) NSString *guestInfo;/**<入住人*/
//@property (nonatomic,strong) NSArray *guestInfoList;/**<入住联系人数组*/
@property (nonatomic,strong) NSString *checkinStatus;/**<订单状态（待付款(1) 已取消(-1) 待接单(0) 已付款(2) 已评价(3) 已退款(-3) 退款中(-2) 取消待商家确认(-4)）*/
@property (nonatomic,strong) NSString *orderStatus;/**<入住状态（待入住(2) 已入住(3) 已离店(4) 已取消(-1) 预定未入住(6)）*/
@property (nonatomic,strong) NSString *xLocation;/**<纬度*/
@property (nonatomic,strong) NSString *yLocation;/**<经度*/
@property (nonatomic,strong) NSString *arriveTime;/**<到店时间*/
@property (nonatomic,strong) NSString *businessPhone;/**<酒店联系电话*/
@property (nonatomic,strong) NSString *mainTel;/**<酒店总机电话*/
@property (nonatomic,strong) NSString *remark;/**<备注*/

@property (nonatomic, copy) NSString *couponMoney;/**<返现券的金钱*/
@property (nonatomic, copy) NSString *roomName;

@property (nonatomic, copy) NSString *orderDate;/**<订单时间*/

@property (nonatomic, assign) BOOL cancleEnable;
@property (nonatomic, strong) NSString *realPrice;

@property (nonatomic, strong) NSArray *userInfoArray;

@end
