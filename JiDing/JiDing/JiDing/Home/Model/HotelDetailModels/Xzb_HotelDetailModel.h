//
//  Xzb_HotelDetailModel.h
//  xzb
//
//  Created by 张荣廷 on 16/7/25.
//  Copyright © 2016年 xuwk. All rights reserved.
//

#import <Foundation/Foundation.h>
/*
 {"id":28435
 ,"reserverId":""
 ,"orderId":8890
 ,"businessId":80
 ,"roomId":135
 ,"price":"0.01"
 ,"payType":"1"
 ,"breakfast":"1"
 ,"pick":"1"
 ,"cancelTime":5
 ,"status":""
 ,"insertDate":""
 ,"pickType":""
 ,"remark":""
 ,"timePeriod":0
 ,"distance":""
 ,"guaranteeMoney":""
 ,"realName":""
 ,"orderBusinessLevel":"2"
 ,"sellMethodInfo":""
 ,"startDate":""
 ,"endDate":""
 ,"userName":""
 ,"userPhoto":""
 ,"roomNum":1
 ,"orderType":"1"
 ,"roomType":""
 ,"isToday":""
 ,"businessLevel":"4"
 ,"businessPhoto":"user5-128x128.png"
 ,"businessName":"佰翔软件园酒店"
 ,"businessXLocation":"24.488284"
 ,"businessYLocation":"118.181564"
 ,"location":"软件园二期"
 ,"score":"0.0"
 ,"rank":"89"
 ,"description":"佰翔软件园酒店"
 ,"mainTel":"15805926167"
 ,"floorStart":3
 ,"floorEnd":6
 ,"bedType":"1"
 ,"useArea":0
 ,"width":0
 ,"length":0
 ,"wifi":"1"
 ,"supportNum":2
 ,"supportEquipment":"1,2,3"
 ,"media":"1,2,3"
 ,"diet":"1,2"
 ,"showerRoom":"1,2,3"
 ,"roomPhoto":"//business//room\135\60d3afb41b5346e89687145334baa537.png"
 ,"isWindow":"1"
 ,"roomName":"清新大床房"
 ,"arriveTime":"20"
 ,"guestInfoList":""
 ,"checkinDate":"2016-07-22 00:00:00"
 ,"leaveDate":"2016-07-23 00:00:00"
 ,"totalIncome":""
 ,"guestInfo":""
 ,"couponId":""
 ,"quotationTime":""
 }
 */
@interface Xzb_HotelDetailModel : NSObject
@property (nonatomic,strong) NSString *orderId;/**<订单ID*/
@property (nonatomic,strong) NSString *businessId;/**<酒店ID*/
@property (nonatomic,strong) NSString *roomName;/**<房型*/
@property (nonatomic,strong) NSString *checkinDate;/**<入住时间*/
@property (nonatomic,strong) NSString *leaveDate;/**<离店时间*/
@property (nonatomic,strong) NSString *arriveTime;/**<预计到店时间*/
@property (nonatomic,strong) NSString *roomPhoto;/**<房型照片*/
@property (nonatomic,strong) NSString *roomNum;/**<房间数目*/
@property (nonatomic,strong) NSMutableArray *roomPhotoArray;/**<房型照片*/
@property (nonatomic,strong) NSString *businessPhoto;/**<酒店照片*/
@property (nonatomic,strong) NSString *businessName;/**<酒店名称*/
@property (nonatomic,strong) NSString *descriptions;/**<酒店介绍*/
@property (nonatomic,strong) NSString *location;/**<酒店地址*/
@property (nonatomic,strong) NSString *businessXLocation;/**<酒店纬度*/
@property (nonatomic,strong) NSString *businessYLocation;/**<酒店经度*/
@property (nonatomic,strong) NSString *businessFacilities;/**<酒店设施字段，逗号隔开*/
@property (nonatomic,strong) NSString *mainTel;/**<酒店电话*/
@property (nonatomic,strong) NSString *price;/**<房间价格*/
@property (nonatomic,strong) NSString *score;/**<酒店评分*/
@property (nonatomic,strong) NSString *payType;/**<支付类型*/
@property (nonatomic,strong) NSString *width;/**<床宽*/
@property (nonatomic,strong) NSString *floorStart;/**<开始楼层*/
@property (nonatomic,strong) NSString *floorEnd;/**<结束楼层*/
@property (nonatomic,strong) NSString *wifi;/**<WIFI支持*/
@property (nonatomic,strong) NSString *useArea;/**<可用面积*/
@property (nonatomic,strong) NSString *isWindow;/**<是否有窗*/
@property (nonatomic,strong) NSString *supportNum;/**<支持人数*/
@property (nonatomic,strong) NSString *pick;/**<接机*/
@property (nonatomic,strong) NSString *breakfast;/**<早餐*/
@property (nonatomic,strong) NSString *rank;/**<好评率*/
@property (nonatomic,strong) NSString *orderType;/**<区别钟点房和全日房*/
@property (nonatomic,strong) NSString *timePeriod;/**<钟点房时间*/
@property (nonatomic,strong) NSString *orderBusinessLevel;/**<等级为6的话，是1元订单*/

@property (nonatomic, strong) NSArray *typeArray;/**<支付类型数组*/

@property (nonatomic, strong, readonly) NSString *roomDays;/**<共X间X晚*/
@property (nonatomic, strong, readonly) NSString *nights;

@property (nonatomic, strong) NSString *totalPrice;/**<总价格*/
@property (nonatomic, strong) NSString *roomPrice;/**<真付钱价格*/
@end
