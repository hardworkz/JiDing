//
//  Xzb_ApplicationDataTool.m
//  xzb
//
//  Created by 张荣廷 on 16/8/15.
//  Copyright © 2016年 xuwk. All rights reserved.
//

#import "Xzb_ApplicationDataTool.h"

#define HMApplicationDataFilepath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"applicationData.data"]

@implementation Xzb_ApplicationDataTool
/**
 *  保存账号
 *
 */
+ (void)saveWithAccount:(Xzb_ApplicationData *)account
{
    // 归档
    NSLog(@"path %@",HMApplicationDataFilepath);
    BOOL isSuccess = [NSKeyedArchiver archiveRootObject:account toFile:HMApplicationDataFilepath];
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
+ (Xzb_ApplicationData *)account
{
    Xzb_ApplicationData *account = [NSKeyedUnarchiver unarchiveObjectWithFile:HMApplicationDataFilepath];
    if (account == nil) {
        account = [[Xzb_ApplicationData alloc] init];
    }
    return account;
}
/**
 *  删除账号
 */
+ (void)deleteAccountSuccess:(void(^)())success failuer:(void(^)())failure{
    
    NSFileManager *manager=[NSFileManager defaultManager];
    NSError *error=nil;
    
    BOOL b = [manager removeItemAtPath:HMApplicationDataFilepath error:&error];
    
    if (b) {
        success();
    }else {
        failure();
    }
}
@end
