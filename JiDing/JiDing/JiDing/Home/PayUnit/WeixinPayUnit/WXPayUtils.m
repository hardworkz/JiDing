//
//  WXPayUtils.m
//  xiuse
//
//  Created by yanhuilv on 16/3/20.
//  Copyright © 2016年 lyhcn. All rights reserved.
//

#import "WXPayUtils.h"
#import "constant.h"
#import "OrderInfo.h"
#import "WXApiManager.h"
#import "AFNetworking.h"

@implementation WXPayUtils
+ (void)jumpToBizPay:(UIViewController *) viewController orderInfo:(OrderInfo*) orderInfo{
    
    //============================================================
    // V3&V4支付流程实现
    // 注意:参数配置请查看服务器端Demo
    // 更新时间：2015年11月20日
    //============================================================
    
//    NSURL *url = [NSURL URLWithString:WEB_CONSOLE_URL];
//    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:url];
    
//    NSString *photoUrl = [NSString stringWithFormat:@"/%@/%@",WEB_ROOT,WX_PAY_SERVER_URL];
    
//    [RTHttpTool post:WEICHAT_PRE_PAY param:@{} success:^(id responseObj) {
//        if ([responseObj[SUCCESS] intValue] == 1) {
//            NSMutableString *stamp  = [responseObj objectForKey:@"timestamp"];
//            
//            //调起微信支付
//            PayReq* req             = [[PayReq alloc] init];
//            req.partnerId           = [responseObj objectForKey:@"partnerid"];
//            req.prepayId            = [responseObj objectForKey:@"prepayid"];
//            req.nonceStr            = [responseObj objectForKey:@"noncestr"];
//            req.timeStamp           = stamp.intValue;
//            req.package             = [responseObj objectForKey:@"package"];
//            req.sign                = [responseObj objectForKey:@"sign"];
//            [WXApi sendReq:req];
//            
//            //日志输出
//            NSLog(@"appid=%@\npartid=%@\nprepayid=%@\nnoncestr=%@\ntimestamp=%ld\npackage=%@\nsign=%@",[responseObj objectForKey:@"appid"],req.partnerId,req.prepayId,req.nonceStr,(long)req.timeStamp,req.package,req.sign );
//        }
//    } failure:^(NSError *error) {
//        
//    }];
    
//    NSURLRequest *request = [httpClient multipartFormRequestWithMethod:@"POST" path:photoUrl parameters:nil constructingBodyWithBlock: ^(id <AFMultipartFormData> formData) {
//        [formData appendPartWithFormData:[orderInfo.orderCode dataUsingEncoding:NSUTF8StringEncoding] name:@"outTradeNo"];
//        [formData appendPartWithFormData:[orderInfo.orderName dataUsingEncoding:NSUTF8StringEncoding] name:@"subject"];
//        [formData appendPartWithFormData:[orderInfo.orderDescription dataUsingEncoding:NSUTF8StringEncoding] name:@"body"];
//        [formData appendPartWithFormData:[orderInfo.orderPrice dataUsingEncoding:NSUTF8StringEncoding] name:@"price"];
//    }];
//    
//    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc]initWithRequest:request];
//    [operation  setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSLog(@"%@",operation.responseString);
//        
//        NSMutableDictionary *dict = NULL;
//        //解析服务端返回json数据
//        NSError *error;
//        //IOS5自带解析类NSJSONSerialization从response中解析出数据放到字典中
//        dict = [NSJSONSerialization JSONObjectWithData:operation.responseData options:NSJSONReadingMutableLeaves error:&error];
//        
//        NSLog(@"%@",dict);
//        
//        if(operation.responseData != nil&&[[dict objectForKey:@"success"] boolValue]){
//            NSDictionary * result = [dict objectForKey:@"result"];
//            NSMutableString *retcode = [result objectForKey:@"retcode"];
//            if (retcode.intValue == 0){
//                NSMutableString *stamp  = [result objectForKey:@"timestamp"];
//                
//                //调起微信支付
//                PayReq* req             = [[PayReq alloc] init];
//                req.partnerId           = [result objectForKey:@"partnerid"];
//                req.prepayId            = [result objectForKey:@"prepayid"];
//                req.nonceStr            = [result objectForKey:@"noncestr"];
//                req.timeStamp           = stamp.intValue;
//                req.package             = [result objectForKey:@"package"];
//                req.sign                = [result objectForKey:@"sign"];
//                [WXApi sendReq:req];
//                
//                //日志输出
//                NSLog(@"appid=%@\npartid=%@\nprepayid=%@\nnoncestr=%@\ntimestamp=%ld\npackage=%@\nsign=%@",[dict objectForKey:@"appid"],req.partnerId,req.prepayId,req.nonceStr,(long)req.timeStamp,req.package,req.sign );
////                return @"";
//            }else{
////                return [dict objectForKey:@"retmsg"];
//            }
//        }else{
////            return @"服务器返回错误，未获取到json对象";
//        }
//        
//    }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"error: %@,%@",  operation.responseString,error);
//    }];
//    
//    [operation start];
    
    
    
    
//    //解析服务端返回json数据
//    NSError *error;
//    //加载一个NSURL对象
//    NSString *urlString = [NSString stringWithFormat:@"%@/%@/%@?outTradeNo=%@&subject=%@&body=%@&price=%@",WEB_CONSOLE_URL,WEB_ROOT,WX_PAY_SERVER_URL,orderInfo.orderCode,orderInfo.orderName,orderInfo.orderDescription,orderInfo.orderPrice];
//    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
//    //将请求的url数据放到NSData对象中
//    NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
//    if ( response != nil) {
//        NSMutableDictionary *dict = NULL;
//        //IOS5自带解析类NSJSONSerialization从response中解析出数据放到字典中
//        dict = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableLeaves error:&error];
//        
//        NSLog(@"url:%@",urlString);
//        if(dict != nil&&[[dict objectForKey:@"success"] boolValue]){
//            NSDictionary * result = [dict objectForKey:@"result"];
//            NSMutableString *retcode = [result objectForKey:@"retcode"];
//            if (retcode.intValue == 0){
//                NSMutableString *stamp  = [result objectForKey:@"timestamp"];
//                
//                //调起微信支付
//                PayReq* req             = [[PayReq alloc] init];
//                req.partnerId           = [result objectForKey:@"partnerid"];
//                req.prepayId            = [result objectForKey:@"prepayid"];
//                req.nonceStr            = [result objectForKey:@"noncestr"];
//                req.timeStamp           = stamp.intValue;
//                req.package             = [result objectForKey:@"package"];
//                req.sign                = [result objectForKey:@"sign"];
//                [WXApi sendReq:req];
//                
////                SendAuthReq* sreq = [[SendAuthReq alloc] init];
////                sreq.scope = kAuthScope; // @"post_timeline,sns"
////                sreq.state = kAuthState;
////                sreq.openID = kAuthOpenID;
////                [WXApi sendAuthReq:sreq
////                    viewController:viewController
////                          delegate:[WXApiManager sharedManager]];
//
//                //日志输出
//                NSLog(@"appid=%@\npartid=%@\nprepayid=%@\nnoncestr=%@\ntimestamp=%ld\npackage=%@\nsign=%@",[dict objectForKey:@"appid"],req.partnerId,req.prepayId,req.nonceStr,(long)req.timeStamp,req.package,req.sign );
//                return @"";
//            }else{
//                return [dict objectForKey:@"retmsg"];
//            }
//        }else{
//            return @"服务器返回错误，未获取到json对象";
//        }
//    }else{
//        return @"服务器返回错误";
//    }
}
@end
