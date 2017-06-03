//
//  PayUtils.m
//  xiuse
//
//  Created by yanhuilv on 16/4/24.
//  Copyright © 2016年 lyhcn. All rights reserved.
//

#import "PayUtils.h"
#import "constant.h"
#import "WXPayUtils.h"
#import <AlipaySDK/AlipaySDK.h>
#import "APAuthV2Info.h"
#import "Order.h"
#import "DataSigner.h"
#import "AFNetworking.h"

@implementation PayUtils

@synthesize delegate = _delegate;
#pragma mark - 单例
+(instancetype)sharedUtils {
    static dispatch_once_t onceToken;
    static PayUtils *instance;
    dispatch_once(&onceToken, ^{
        instance = [[PayUtils alloc] init];
    });
    return instance;
}
- (void) alipayfor:(OrderInfo*)orderInfo param:(NSDictionary *)param payType:(PayType)payType
{
    /*
     *点击获取prodcut实例并初始化订单信息
     */
    
    /*
     *商户的唯一的parnter和seller。
     *签约后，支付宝会为每个商户分配一个唯一的 parnter 和 seller。
     */
    
    /*============================================================================*/
    /*=======================需要填写商户app申请的===================================*/
    /*============================================================================*/
    NSString *partner = ALI_partner;
    NSString *seller = ALI_seller;
    NSString *privateKey = ALI_privateKey;
    /*============================================================================*/
    /*============================================================================*/
    /*============================================================================*/
    
    //partner和seller获取失败,提示
    if ([partner length] == 0 ||
        [seller length] == 0 ||
        [privateKey length] == 0)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:@"缺少partner或者seller或者私钥。"
                                                       delegate:self
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil];
        [alert show];
        
        return;
    }
    
    /*
     *生成订单信息及签名
     */
    //将商品信息赋予AlixPayOrder的成员变量
    Order *order = [[Order alloc] init];
    order.partner = partner;
    order.seller = seller;
    order.tradeNO = orderInfo.orderCode; //订单ID（由商家自行制定）
    order.productName = orderInfo.orderName; //商品标题
    order.productDescription = orderInfo.orderDescription; //商品描述
    order.amount = orderInfo.orderPrice; //商品价格
    order.notifyURL =  NOTIFY_URL; //回调URL
    
    order.service = @"mobile.securitypay.pay";
    order.paymentType = @"1";
    order.inputCharset = @"utf-8";
    order.itBPay = @"30m";
    order.showUrl = @"m.alipay.com";
    
    //应用注册scheme,在AlixPayDemo-Info.plist定义URL types
    NSString *appScheme = APP_SCHEME;
    
    //将商品信息拼接成字符串
    
    NSString *orderSpec = [order description];
    NSLog(@"orderSpec = %@",orderSpec);
    
    //获取私钥并将商户信息签名,外部商户可以根据情况存放私钥和签名,只需要遵循RSA签名规范,并将签名字符串base64编码和UrlEncode
    
    id<DataSigner> signer = CreateRSADataSigner(privateKey);
    
    //判读是充值还是支付
    if (payType == PayTypePay) {//支付
        //请求支付宝支付后台接口
        RTLog(@"支付的字典为:%@",param);
        [RTHttpTool get:ALIPAY_ORDER_INFO addHUD:YES param:param success:^(id responseObj) {
            NSLog(@"alipay:%@",responseObj);
            if ([responseObj[SUCCESS] intValue] == 1) {
                NSString *signedString = [signer signString:responseObj[ENTITIES][MAP][@"orderInfo"]];
                
                //将签名成功字符串格式化为订单字符串,请严格按照该格式
                NSString *orderString = nil;
                if (responseObj[ENTITIES][MAP][@"sign"] != nil) {
                    orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"",
                                   responseObj[ENTITIES][MAP][@"orderInfo"], signedString, @"RSA"];
                    
                    [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
                        NSLog(@"reslut = %@",resultDic);
                        NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
                        
                        if ([[resultDic objectForKey:@"resultStatus"]integerValue]==9000) {
                            [dict setObject:@TRUE forKey:@"success"];
                            [dict setObject:@"支付成功" forKey:@"message"];
                        }
                        else if ([[resultDic objectForKey:@"resultStatus"]integerValue]==8000) {
                            [dict setObject:@FALSE forKey:@"success"];
                            [dict setObject:@"支付结果确认中" forKey:@"message"];
                        }
                        else if ([[resultDic objectForKey:@"resultStatus"]integerValue]==6001) {
                            [dict setObject:@FALSE forKey:@"success"];
                            [dict setObject:@"支付中断，请重新支付" forKey:@"message"];
                        }
                        else{
                            
                            [dict setObject:@FALSE forKey:@"success"];
                            [dict setObject:@"支付失败" forKey:@"message"];
                        }
                        
                        [_delegate payCallback:dict];
                    }];
                }
            }else
            {
                [[Toast makeText:responseObj[MESSAGE]] show];
            }
        } failure:^(NSError *error) {
            
        }];
    }else//充值
    {
        NSString *signedString = [signer signString:orderSpec];
        //将签名成功字符串格式化为订单字符串,请严格按照该格式
        NSString *orderString = nil;
        if (signedString != nil) {
            orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"",
                           orderSpec, signedString, @"RSA"];
            
            [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
                NSLog(@"reslut = %@",resultDic);
                NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
                
                if ([[resultDic objectForKey:@"resultStatus"]integerValue]==9000) {
                    [dict setObject:@TRUE forKey:@"success"];
                    [dict setObject:@"支付成功" forKey:@"message"];
                }
                else if ([[resultDic objectForKey:@"resultStatus"]integerValue]==8000) {
                    [dict setObject:@FALSE forKey:@"success"];
                    [dict setObject:@"支付结果确认中" forKey:@"message"];
                }
                else if ([[resultDic objectForKey:@"resultStatus"]integerValue]==6001) {
                    [dict setObject:@FALSE forKey:@"success"];
                    [dict setObject:@"支付中断，请重新支付" forKey:@"message"];
                }
                else{
                    
                    [dict setObject:@FALSE forKey:@"success"];
                    [dict setObject:@"支付失败" forKey:@"message"];
                }
                
                [_delegate payCallback:dict];
            }];
        }

    }
    
}
- (void) wxpayfor:(UIViewController *) viewController orderInfo:(OrderInfo*) orderInfo{
    [WXPayUtils jumpToBizPay:viewController orderInfo:orderInfo];
}
@end
