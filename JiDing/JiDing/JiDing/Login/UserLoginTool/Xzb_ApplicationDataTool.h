//
//  Xzb_ApplicationDataTool.h
//  xzb
//
//  Created by 张荣廷 on 16/8/15.
//  Copyright © 2016年 xuwk. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Xzb_ApplicationData;
@interface Xzb_ApplicationDataTool : NSObject
//保存数据
+ (void)saveWithAccount:(Xzb_ApplicationData *)account;
//读取数据
+ (Xzb_ApplicationData *)account;
//删除数据
+ (void)deleteAccountSuccess:(void(^)())success failuer:(void(^)())failure;
@end
