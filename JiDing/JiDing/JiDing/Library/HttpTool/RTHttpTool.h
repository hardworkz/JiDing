//
//  RTHttpTool.h
//  花意
//
//  Created by adminstrator on 15/9/18.
//  Copyright (c) 2015年 ZZL. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  日期格式
 */
typedef NS_ENUM(NSUInteger, FormatType) {
    /**
     *  中文格式日期
     */
    FormatTypeChineseFormat = 0,
    /**
     *  横杆格式日期
     */
    FormatTypeRung
};
@interface RTHttpTool : NSObject
//判断用户是否已经下线，请求接口
//+ (void)isLogoutHttpWithSuccess:(void (^)(BOOL isLogout))result;
//判断内容是否全部为空格  yes 全部为空格  no 不是
+ (BOOL) isEmpty:(NSString *) str;
//用户没有登录提示
//+ (BOOL)userLogoutToast;
/**
 *  转换图片url路径
 */
+ (NSString *)returnPhotoStringWithString:(NSString *)string;
/**
 *  数组排序升序
 */
//- (NSArray *)sortArray:(NSArray *)array;
/*
 * 获取当前日期数字字符串
 */
+ (id)stringWithDate;
/*
 * 获取今天日期的格式化字符串
 */
+(NSString *)GetTodayDay:(NSDate *)aDate formatType:(FormatType)formatType;
/*
 * 获取明天日期的格式化字符串
 */
+(NSString *)GetTomorrowDay:(NSDate *)aDate formatType:(FormatType)formatType;
/*
 * 将data转成json
 */
+ (id)jsonWithResponseObj:(id)response;
/*
 * 将字典转成json字符串
 */
+ (NSString *)jsonStringWithDictionary:(NSDictionary *)dict;
/*!
 * @brief 把格式化的JSON格式的字符串转换成字典
 * @param jsonString JSON格式的字符串
 * @return 返回字典
 */
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;
/*
 * 判读输入的字符是否为数字 ，是则返回YES
 */
+ (BOOL)validateNumber:(NSString*)number textField:(UITextField *)textfield;

/*
 * 判读输入的字符是否为限制内的字符
 */
+ (BOOL)validateNumber:(NSString*)number textField:(UITextField *)textfield limitString:(NSString *)limitStr;
/*
 * GET请求
 */
+ (void)get:(NSString *)url addHUD:(BOOL)addHUD param:(NSDictionary *)param success:(void(^)(id responseObj))success failure:(void(^)(NSError *error))failure;
/*
 * GET请求
 */
+ (void)post:(NSString *)url addHUD:(BOOL)addHUD param:(NSDictionary *)param success:(void(^)(id responseObj))success failure:(void(^)(NSError *error))failure;
/**
 *  上传单张照片
 *
 *  @param url      请求路径
 *  @param param    请求参数
 *  @param image    上传数据
 *  @param fileName 文件名
 *  @param success  成功block
 *  @param failure  失败block
 */
+ (void)post:(NSString *)url addHUD:(BOOL)addHUD param:(NSDictionary *)param dataBlock:(UIImage *)image fileName:(NSString *)fileName success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;
/**
 *  上传多张照片
 *
 *  @param url      请求路径
 *  @param param    请求参数
 *  @param array    上传数据数组
 *  @param fileName 文件名
 *  @param success  成功block
 *  @param failure  失败block
 */
+ (void)post:(NSString *)url addHUD:(BOOL)addHUD param:(NSDictionary *)param dataArray:(NSArray *)array fileName:(NSString *)fileName success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;
@end
