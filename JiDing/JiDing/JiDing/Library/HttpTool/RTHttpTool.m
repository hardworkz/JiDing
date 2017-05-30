//
//  RTHttpTool.m
//  花意
//
//  Created by adminstrator on 15/9/18.
//  Copyright (c) 2015年 ZZL. All rights reserved.
//

#import "RTHttpTool.h"
#import "AFNetworking.h"

@interface RTHttpTool ()<UIAlertViewDelegate>

@end

@implementation RTHttpTool
//判断内容是否全部为空格  yes 全部为空格  no 不是
+ (BOOL) isEmpty:(NSString *) str {
    
    if (!str) {
        return true;
    } else {
        //A character set containing only the whitespace characters space (U+0020) and tab (U+0009) and the newline and nextline characters (U+000A–U+000D, U+0085).
        NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
        
        //Returns a new string made by removing from both ends of the receiver characters contained in a given character set.
        NSString *trimedString = [str stringByTrimmingCharactersInSet:set];
        
        if ([trimedString length] == 0) {
            return true;
        } else {
            return false;
        }
    }
}

+ (NSString *)returnPhotoStringWithString:(NSString *)string
{
    BOOL isPre = [string hasPrefix:@"http"];
    NSString *urlString;
    if (isPre) {
        urlString = string;
    }else
    {
//        NSString *newStr = [string stringByReplacingOccurrencesOfString:@"\\" withString:@"/"];
//        NSString *returnString = [NSString stringWithFormat:@"%@?path=%@",GET_ICON,newStr];
//        
//        urlString = returnString;
        //http://7xkwpn.com1.z0.glb.clouddn.com
        //http://oe7j3laae.bkt.clouddn.com
        
        urlString = [NSString stringWithFormat:@"http://7xkwpn.com1.z0.glb.clouddn.com%@",string];
    }
    
    return urlString;
}
/*排序计算核心
 NSComparator cmptr = ^(HotelOfferModel *obj1, HotelOfferModel *obj2){
 if ([obj1.distance integerValue] > [obj2.distance integerValue]) {
 return (NSComparisonResult)NSOrderedDescending;
 }
 
 if ([obj1.distance integerValue] < [obj2.distance integerValue]) {
 return (NSComparisonResult)NSOrderedAscending;
 }
 return (NSComparisonResult)NSOrderedSame;
 };
 */
//- (NSArray *)sortArray:(NSArray *)array
//{
//    NSComparator cmptr = ^(HotelOfferModel *obj1, HotelOfferModel *obj2){
//        if ([obj1.distance integerValue] > [obj2.distance integerValue]) {
//            return (NSComparisonResult)NSOrderedDescending;
//        }
//        
//        if ([obj1.distance integerValue] < [obj2.distance integerValue]) {
//            return (NSComparisonResult)NSOrderedAscending;
//        }
//        return (NSComparisonResult)NSOrderedSame;
//    };
//    NSArray *sortArray = [array sortedArrayUsingComparator:cmptr];
//    return sortArray;
//}

+ (BOOL)validateNumber:(NSString*)number textField:(UITextField *)textfield
{
    BOOL res = YES;
    
    NSCharacterSet* tmpSet = [NSCharacterSet characterSetWithCharactersInString:@"1234567890"];
    int i = 0;
    while (i < number.length) {
        NSString * string = [number substringWithRange:NSMakeRange(i, 1)];
        NSRange range = [string rangeOfCharacterFromSet:tmpSet];
        if (range.length == 0) {
            res = NO;
            break;
        }
        i++;
    }
    return res;
}
+ (BOOL)validateNumber:(NSString*)number textField:(UITextField *)textfield limitString:(NSString *)limitStr
{
    BOOL res = YES;
    
    NSCharacterSet* tmpSet = [NSCharacterSet characterSetWithCharactersInString:limitStr];
    int i = 0;
    while (i < number.length) {
        NSString * string = [number substringWithRange:NSMakeRange(i, 1)];
        NSRange range = [string rangeOfCharacterFromSet:tmpSet];
        if (range.length == 0) {
            res = NO;
            [[Toast makeText:@"请勿输入非法字符!"] show];
            break;
        }
        i++;
    }
    return res;
}

+(NSString *)GetTomorrowDay:(NSDate *)aDate isRung:(BOOL)isRung
{
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *components = [gregorian components:NSWeekdayCalendarUnit | NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit fromDate:aDate];
    [components setDay:([components day]+1)];
    
    NSDate *beginningOfWeek = [gregorian dateFromComponents:components];
    NSDateFormatter *dateday = [[NSDateFormatter alloc] init];
    if (isRung) {
        [dateday setDateFormat:@"yyyy-MM-dd"];
    }else
    {
        [dateday setDateFormat:@"yyyy年MM月dd日"];
    }
    return [dateday stringFromDate:beginningOfWeek];
}
+(NSString *)GetTodayDay:(NSDate *)aDate isRung:(BOOL)isRung
{
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *components = [gregorian components:NSWeekdayCalendarUnit | NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit fromDate:aDate];
    [components setDay:([components day])];
    
    NSDate *beginningOfWeek = [gregorian dateFromComponents:components];
    NSDateFormatter *dateday = [[NSDateFormatter alloc] init];
    if (isRung) {
        [dateday setDateFormat:@"yyyy-MM-dd"];
    }else
    {
        [dateday setDateFormat:@"yyyy年MM月dd日"];
    }
    return [dateday stringFromDate:beginningOfWeek];
}

+ (id)stringWithDate
{
    NSString* dateStr;
    NSDateFormatter* formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"YYYYMMddHHmmss"];
    dateStr = [formatter stringFromDate:[NSDate date]];
    return dateStr;
}
+ (NSString *)jsonStringWithDictionary:(NSDictionary *)dict
{
    if (dict) {
        NSData * jsonData = [NSJSONSerialization dataWithJSONObject:dict options:0 error:nil];
        NSString * jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        return jsonString;
    }else
    {
        return @"";
    }
}
/*!
 * @brief 把格式化的JSON格式的字符串转换成字典
 * @param jsonString JSON格式的字符串
 * @return 返回字典
 */
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    if (jsonString == nil) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}
+ (id)jsonWithResponseObj:(id)response
{
//    NSData *data = response;
//    id json =  [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    return response;
}
//+ (void)get:(NSString *)url addHUD:(BOOL)addHUD param:(NSDictionary *)param success:(void(^)(id responseObj))success failure:(void(^)(NSError *error))failure
//{
//    if (addHUD) {
//        [AppHelper showHUD:@""];
//    }
//    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
//    mgr.requestSerializer.timeoutInterval = 30.0f;
//    mgr.responseSerializer = [AFJSONResponseSerializer serializer];
//    [mgr GET:url parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        if(addHUD) [AppHelper removeHUD];
//        id json = [self jsonWithResponseObj:responseObject];
//        NSString *msg = json[MESSAGE];
//        [self JudgeOfflineIfNeed:msg];
//        
//        //成功的回调
//        if(success){
//            success(responseObject);
//        }
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        if(addHUD) [AppHelper removeHUD];
//        //失败的回调
//        if(failure){
//            failure(error);
//        }
//        [[Toast makeText:@"访问服务器出错了~~"] show];
//    }];
//}
//+ (void)post:(NSString *)url addHUD:(BOOL)addHUD param:(NSDictionary *)param success:(void(^)(id responseObj))success failure:(void(^)(NSError *error))failure
//{
//    if (addHUD) {
//        [AppHelper showHUD:@""];
//    }
//    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
//    //申明返回的结果是json类型
//    mgr.responseSerializer = [AFJSONResponseSerializer serializer];
//    mgr.requestSerializer.timeoutInterval = 30.0f;
////    mgr.requestSerializer = [AFJSONRequestSerializer serializer];
//    
//    [mgr POST:url parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        if(addHUD) [AppHelper removeHUD];
//        NSString *msg = responseObject[MESSAGE];
//        [self JudgeOfflineIfNeed:msg];
//        
//        //成功的回调
//        if(success){
//            success(responseObject);
//        }
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        if(addHUD) [AppHelper removeHUD];
//        //失败的回调
//        if(failure){
//            failure(error);
//        }
//        [[Toast makeText:@"访问服务器出错了~~"] show];
//    }];
//}
//+ (void)post:(NSString *)url addHUD:(BOOL)addHUD param:(NSDictionary *)param dataBlock:(UIImage *)image fileName:(NSString *)fileName success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure
//{
//    if (addHUD) {
//        [AppHelper showHUD:@""];
//    }
//    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
//    mgr.requestSerializer = [AFJSONRequestSerializer serializer];
//    mgr.requestSerializer.timeoutInterval = 30.0f;
//    mgr.responseSerializer = [AFJSONResponseSerializer serializer];
//    [mgr POST:url parameters:param constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
//        for(NSString *key in param.mj_keyValues)
//        {
//            NSString *value = [param objectForKey:key];
//            NSData* userIdData = [value dataUsingEncoding:NSUTF8StringEncoding];
//            [formData appendPartWithFormData:userIdData name:key];
//        }
//        NSData *data = UIImageJPEGRepresentation(image, 0.5);
//        [formData appendPartWithFileData:data name:@"photo.jpg" fileName:fileName mimeType:@"binary/octet-stream"];
//    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        if(addHUD) [AppHelper removeHUD];
//        NSString *msg = responseObject[MESSAGE];
//        [self JudgeOfflineIfNeed:msg];
//        
//        if (success) {
//            success(responseObject);
//        }
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        if(addHUD) [AppHelper removeHUD];
//        if (failure) {
//            failure(error);
//        }
//        [[Toast makeText:@"访问服务器出错了~~"] show];
//    }];
//}
//+ (void)post:(NSString *)url addHUD:(BOOL)addHUD param:(NSDictionary *)param dataArray:(NSArray *)array fileName:(NSString *)fileName success:(void (^)(id))success failure:(void (^)(NSError *))failure
//{
//    if (addHUD) {
//        [AppHelper showHUD:@""];
//    }
//    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
//    mgr.requestSerializer = [AFJSONRequestSerializer serializer];
//    mgr.requestSerializer.timeoutInterval = 30.0f;
//    mgr.responseSerializer = [AFJSONResponseSerializer serializer];
//    
//    [mgr POST:url parameters:param constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
//        for (int i = 0; i < array.count; i++)
//        {
//            //UIimage对象=》NSData数据（进行图片压缩）
//            UIImage *img = array[i];
//            NSData *data = UIImageJPEGRepresentation(img, 0.5);
//            
//            //给上传的每一张图片定义不同文件名
//            NSString *fileNames = [NSString stringWithFormat:@"%@_%d.png",fileName,i+1];
//            
//            //将当前图片的NSData数据添加formData
//            [formData appendPartWithFileData:data name:[NSString stringWithFormat:@"photo_%d.jpg",i] fileName:fileNames mimeType:@"binary/octet-stream"];
//            //image/png   binary/octet-stream
//        }
//    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        if(addHUD) [AppHelper removeHUD];
//        NSString *msg = responseObject[MESSAGE];
//        [self JudgeOfflineIfNeed:msg];
//        
//        if (success) {
//            success(responseObject);
//        }
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        if(addHUD) [AppHelper removeHUD];
//        if (failure) {
//            failure(error);
//        }
//        [[Toast makeText:@"访问服务器出错了~~"] show];
//    }];
//}
+ (void)JudgeOfflineIfNeed:(NSString *)msg
{
    if ([msg isEqualToString:@"无效token"]) {
//        [[NSNotificationCenter defaultCenter] postNotificationName:LogoutNotification object:nil];
    }
}

@end
