//
//  Xzb_MyOrderDetailGuestInfoListModel.h
//  xzb
//
//  Created by rainze on 16/7/25.
//  Copyright © 2016年 xuwk. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 ,"guestInfoList":[{"userName":"哦哦哦"
 ,"phone":"15805926167"
 ,"roomNum":""
 }]
 */

@interface Xzb_MyOrderDetailGuestInfoListModel : NSObject

@property (nonatomic, copy) NSString *userName;
@property (nonatomic, copy) NSString *phone;
@property (nonatomic, copy) NSString *roomNum;

@end
