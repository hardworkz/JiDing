//
//  UserAccountTool.m
//  0YuanGO
//
//  Created by 敲代码mac1号 on 16/3/9.
//  Copyright © 2016年 Silicici. All rights reserved.
//

#import "UserAccountTool.h"

#define HMAccountFilepath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"account.data"]
#define HMMessageArrayFilepath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"messageArray.data"]

@implementation UserAccountTool
/**
 *  保存账号
 *
 */
+ (void)saveWithAccount:(UserAccount *)account
{
    // 归档
    NSLog(@"path %@",HMAccountFilepath);
    BOOL isSuccess = [NSKeyedArchiver archiveRootObject:account toFile:HMAccountFilepath];
    if (isSuccess) {
        NSLog(@"归档成功");
    }else{
        NSLog(@"归档失败");
    }
}
/**
 *  读取帐号
 *
 */
+ (UserAccount *)account
{
    UserAccount *account = [NSKeyedUnarchiver unarchiveObjectWithFile:HMAccountFilepath];
    if (account == nil) {
        account = [[UserAccount alloc] init];
    }
    return account;
}
/**
 *  删除账号
 */
+ (void)deleteAccountSuccess:(void(^)())success failuer:(void(^)())failure{
    
    NSFileManager *manager=[NSFileManager defaultManager];
    NSError *error=nil;
    
    BOOL b = [manager removeItemAtPath:HMAccountFilepath error:&error];
    
    if (b) {
        success();
    }else {
        failure();
    }
    
}
@end
