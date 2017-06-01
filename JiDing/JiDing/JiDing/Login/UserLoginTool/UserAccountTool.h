//
//  UserAccountTool.h
//  0YuanGO
//
//  Created by 敲代码mac1号 on 16/3/9.
//  Copyright © 2016年 Silicici. All rights reserved.
//

#import <Foundation/Foundation.h>

@class UserAccount;
@interface UserAccountTool : NSObject

//保存账号
+ (void)saveWithAccount:(UserAccount *)account;
//读取账号
+ (UserAccount *)account;
//删除账号
+ (void)deleteAccountSuccess:(void(^)())success failuer:(void(^)())failure;
@end
