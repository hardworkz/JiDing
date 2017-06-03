//
//  StayInFriendsModel.h
//  xzb
//
//  Created by 张荣廷 on 16/7/22.
//  Copyright © 2016年 xuwk. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 {"nickName":"小瞎米新人"
 ,"userPhoto":"/customer\198\head\d192718fb01f4feb8a3cdff70f142ae4.jpg"
 ,"checkinDate":"2016-07-21 10:03:51"
 ,"remark":""
 }
 */
@interface StayInFriendsModel : NSObject
@property (nonatomic , copy) NSString *userID;/**<用户呢称*/
@property (nonatomic , copy) NSString *nickName;/**<用户呢称*/
@property (nonatomic , copy) NSString *userPhoto;/**<用户头像*/
@property (nonatomic , copy) NSString *checkinDate;/**<入住日期*/
@property (nonatomic , copy) NSString *remark;/**<签名*/
@property (nonatomic , assign) CGFloat cellHeight;/**<cell高度*/
@end
