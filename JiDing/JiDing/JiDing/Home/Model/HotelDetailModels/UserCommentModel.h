//
//  UserCommentModel.h
//  xzb
//
//  Created by 张荣廷 on 16/7/19.
//  Copyright © 2016年 xuwk. All rights reserved.
//

#import <Foundation/Foundation.h>
/*
 {"reviewerId":""
 ,"orderId":8661
 ,"startLevel":5
 ,"reviewDate":"2016-07-19 16:32:03"
 ,"roomType":"1"
 ,"content":"还行吧，九楼"
 ,"photos":""
 ,"remark":""
 ,"id":185
 ,"nickName":"小明"
 ,"userPhoto":"/customer\201\head\b8fd65bb152e4b57befcbffc1fcf64d2.jpg"
 }
 */
@interface UserCommentModel : NSObject
@property (nonatomic , copy) NSString *orderId;/**<订单id*/
@property (nonatomic , copy) NSString *reviewDate;/**<回复日期*/
@property (nonatomic , copy) NSString *startLevel;/**<酒店星级*/
@property (nonatomic , copy) NSString *roomType;/**<房间类型*/
@property (nonatomic , copy) NSString *content;/**<评论内容*/
@property (nonatomic , copy) NSString *photos;/**<评论图片字符串“,”号分隔*/
@property (nonatomic , copy) NSString *remark;/**<备注*/
@property (nonatomic , copy) NSString *nickName;/**<昵称*/
@property (nonatomic , copy) NSString *userPhoto;/**<用户头像*/
@property (nonatomic , copy) NSMutableArray *photoArray;/**<用户评论图片*/
@property (nonatomic , assign) CGFloat cellHeight;/**<cell高度*/
@end
