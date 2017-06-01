//
//  Xzb_ApplicationData.h
//  xzb
//
//  Created by 张荣廷 on 16/8/15.
//  Copyright © 2016年 xuwk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Xzb_ApplicationData : NSObject
@property (nonatomic, copy) NSString *bankCardNum;/**<默认绑定银行卡号*/
@property (nonatomic, copy) NSString *bankCardTypeName;/**<默认绑定银行名称*/
@property (nonatomic, copy) NSString *bankTypeName;/**<默认绑定银行卡类型名称*/
@property (nonatomic, copy) NSString *isShowUpdate;/**<默认绑定银行卡类型名称*/
@property (nonatomic, copy) NSString *bankCount;/**<绑定银行卡数*/

@property (nonatomic, copy) NSString *orderNo;/**<用户提交订单号*/
@property (nonatomic, copy) NSString *purpose;/**<目的*/
@property (nonatomic, copy) NSString *user_x;/**<用户经度*/
@property (nonatomic, copy) NSString *user_y;/**<用户纬度*/
@property (nonatomic, copy) NSString *areaName;/**<用户城市名称*/
@property (nonatomic, copy) NSString *userAddress;/**<用户位置*/
@property (nonatomic, copy) NSString *township;/**<所在街道*/
@property (nonatomic, copy) NSString *roomNum;/**<选择房间数*/
@property (nonatomic, copy) NSString *dayNum;/**<入住天数*/
@property (nonatomic,assign)  BOOL isFirst;/**<第一次进入地图页面*/
@end
