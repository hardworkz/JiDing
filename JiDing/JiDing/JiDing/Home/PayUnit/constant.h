//
//  constant.h
//  Shopping
//
//  Created by lyhcn on 15/5/17.
//  Copyright (c) 2015年 lyhcn. All rights reserved.
//

#ifndef Shopping_constant_h
#define Shopping_constant_h


#endif

#import <Foundation/Foundation.h>
#import <SystemConfiguration/SystemConfiguration.h>
#import <MobileCoreServices/MobileCoreServices.h>
//#import "GraphUtils.h"
//#import "StringUtils.h"

#define APP_ID @"290613410"
#define SERVER_URL @"http://115.159.25.170:8090"

#define WEB_VIEW_URL @"http://115.159.23.205:8080/xzbClient/index.html"
#define WEB_CONSOLE_URL @"http://115.159.23.205:8080"
#define WEB_ROOT @"xzbClient"

//#define WEB_VIEW_URL @"http://192.168.1.10:8081"
//#define WEB_CONSOLE_URL @"http://192.168.1.10:28080"
//#define WEB_ROOT @"xzbPlatform"

#define AuthScope @"snsapi_message,snsapi_userinfo,snsapi_friend,snsapi_contact"
#define kAuthOpenID @"0c806938e2413ce73eef92cc3"
#define kAuthState @"xxx"
#define WX_PAY_SERVER_URL @"pay/webchatPrePay.do"


#define UMSocialKey @"55b26b7d67e58e3e7500389a"
#define WX_API @"wx96227f9fdc237c74"
#define WX_AppId @"wx96227f9fdc237c74"
#define WX_appSecret @"0b59c80bcdbdc04bf85b99470ae40cf9"
#define WX_URL @"http://www.umeng.com/social"

#define APP_SCHEME @"wx96227f9fdc237c74"
#define ALI_partner  @"2088021265404642"
#define ALI_seller  @"twb@chinaxzb.com"
#define ALI_PAY_SERVER_URL @"alipay/getOrderInfo.do"
#define ALI_privateKey @"MIICdQIBADANBgkqhkiG9w0BAQEFAASCAl8wggJbAgEAAoGBAK/6mVuWDdXsLVNDzdtOb0oAtMpVrEqws1l5oLBuK0Mk6u9AZmcuIiOYn4bv3IdzyAW4ca18EVuzqQD2JwvSDeAON4kcYg4UJikPXIO5cJQxVOYCfaXtfJ9kbaFyN4tRvp3mduXGaE2rMu6d5DgLtDaV+Cf/9rpB6JLiXzuFOdChAgMBAAECgYAFi37jjOHYuL1g30UQQPNuwIDx0ys/mzu7eQKgLIh+cB5a9YuEesammnuEU/B98B8AVyR10+/0FMAhgKAQVkkLldcHDvCrolpUNDro6ITXfr7mEjEZb7WMN8ZGMxMKBJn/2FwsjTAzbYBspFTK98/gPQ/Z3feApERMHWKOASwPMQJBAOmvLKVTSiXbGXCiiRPyH1XpFshY35OMwuBP+pMSiv/7kypjvMMFjW2uZeK4JbWIyATAQkKP5NXrsw4MjhMLvjUCQQDAyLb3xexXrE8l1zgVOQfwE1EjMBot7eML7U5v6btP5nE2zb9YVidMCmepRDV4KDPQD33f8ZsPY5lUTUxpH0Y9AkArTFDaZR9U+k6xZvw9HNyff2vAPW9XmHo3M7p667GjkoqHDSnZfLriurCYHISoKSrebn0Ydi7xUBXCIaNldgSNAkA/sdEp+f3FVcvsr7f64xXpTyiOnLT5mdBbP3Ob7DiUBIpBViczM3vWVtW7Cis0YOwFgSjQlc3qfrjJLqThUpDtAkAC1rDTUJIZhM+aeLgjU5YMI0+OmCcbiponAaphzPJCmEjQlWl8/zQqCkNKjU/R4l/IwpSXpUYI7lSXIyIRIWx6"

#define NOTIFY_URL [NSString stringWithFormat:@"%@/alipay/aliNotify.do",BaseURL]
//    NSString *url = @"http://192.168.1.7:8080/";

//    NSString *url = @"http://localhost:8080/";
//    NSString *url = @"http://115.159.25.170:8090/builderServer/index.html";
//    NSString *url = @"http://192.168.1.5:28080/xiusheServer/map/map.jsp";
//    NSString *url = @"http://localhost:28080/builderServer/map/map.jsp";

#define IS_IOS_7 ([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0)?YES:NO
#define SYSTEM_VERSION_LESS_THAN(v) ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)//用来获取手机的系统，判断系统是多少
#define StatusBarStyle UIStatusBarStyleLightContent

#define StateBarHeight ((IS_IOS_7)?20:0)

#define NavBarHeight ((IS_IOS_7)?65:45)

#define CustomNavBarHeight ((IS_IOS_7)?65:0)

#define BottomHeight ((IS_IOS_7)?49:0)

#define ToolBarHeight ((IS_IOS_7)?49:49)

#define ScreenHeight ((IS_IOS_7)?([UIScreen mainScreen].bounds.size.height):([UIScreen mainScreen].bounds.size.height - 20))

#define ConentViewWidth  [UIScreen mainScreen].bounds.size.width

#define ConentViewHeight ((IS_IOS_7)?([UIScreen mainScreen].bounds.size.height-13):([UIScreen mainScreen].bounds.size.height -63))
#define MapViewHeight ((IS_IOS_7)?([UIScreen mainScreen].bounds.size.height):([UIScreen mainScreen].bounds.size.height -20))

#define ConentViewFrame CGRectMake(0,NavBarHeight,ConentViewWidth,ConentViewHeight)

#define MaskViewDefaultFrame CGRectMake(0,NavBarHeight,ConentViewWidth,ConentViewHeight)

#define MaskViewFullFrame CGRectMake(0,0,ConentViewWidth,[UIScreen mainScreen].bounds.size.height-20)

#define color(r, g, b, a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]

#define baseColorAlpha(a)  color(75,113,194,a)
#define baseColor baseColorAlpha(1)

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define UIColorFromRGBAlph(rgbValue,alpah) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:alpah]

#define bgColor color(255,255,255,1)
#define firstColor UIColorFromRGB(0x1ab3f2)
#define secondColor UIColorFromRGB(0xffbc11)
#define thridColor UIColorFromRGB(0x6db827)
#define titleColor UIColorFromRGB(0x333333)
#define contentColor UIColorFromRGB(0x999999)
#define grayColor UIColorFromRGB(0xf4f4f4)
#define LINE_HEIGHT 0.5f