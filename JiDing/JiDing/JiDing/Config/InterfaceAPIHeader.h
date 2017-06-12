//
//  InterfaceAPIHeader.h
//  JiDing
//
//  Created by 泡果 on 2017/6/1.
//  Copyright © 2017年 zhangrongting. All rights reserved.
//

#ifndef InterfaceAPIHeader_h
#define InterfaceAPIHeader_h

#define BaseURL @"http://39.108.7.252:8080/xzbApi"

//获取短信验证码 参数 phoneCode 请求方式GET
#define GET_CODE [NSString stringWithFormat:@"%@/login/verifyPhone35.do",BaseURL]

//验证短信验证码 参数 phoneCode verifyCode userId 请求方式POST
#define LOGIN [NSString stringWithFormat:@"%@/login/verifyPhoneCode35.do",BaseURL]

//个人资料修改 请求方式POST
#define UPDATE_INFO [NSString stringWithFormat:@"%@/customerinfo/updateCustomer.do",BaseURL]

//用户头像上传 参数 userId 请求方式POST
#define UPDATE_PHOTO [NSString stringWithFormat:@"%@/customerinfo/uploadPhoto.do",BaseURL]

//用户关注、粉丝、赞我数量 请求方式GET
#define GET_FANS_NUM [NSString stringWithFormat:@"%@/customerOwn/getOwnNum.do",BaseURL]

//用户关注 请求方式GET
#define GET_ATTENTION [NSString stringWithFormat:@"%@/customerOwn/attention.do",BaseURL]

//用户取消关注 请求方式GET
#define GET_CANCLE_ATTENTION [NSString stringWithFormat:@"%@/customerOwn/cancelAttention.do",BaseURL]

//用户相册 请求方式GET
#define GET_MY_PICTURES [NSString stringWithFormat:@"%@/customerOwn/getMyAlbum.do",BaseURL]

//用户备注设置 请求方式GET
#define GET_SET_OTHER_REMARK [NSString stringWithFormat:@"%@/customerOwn/setOtherRemark.do",BaseURL]

//用户当天是否签到 请求方式GET
#define GET_DID_SIGN [NSString stringWithFormat:@"%@/customerOwn/checkTodaySigned.do",BaseURL]

//用户的虾米数 请求方式GET
#define GET_XM_NUM [NSString stringWithFormat:@"%@/customerOwn/getXmNum.do",BaseURL]

//用户签到 请求方式GET
#define MY_SIGN_GET [NSString stringWithFormat:@"%@/customerOwn/signed.do",BaseURL]

//用户签到次数及日期 请求方式GET
#define MY_MON_SIGN_GET [NSString stringWithFormat:@"%@/customerOwn/thisMonthSigned.do",BaseURL]

//获取用户头像 请求方式GET
#define GET_USERINFO_BY_ID [NSString stringWithFormat:@"%@/customerinfo/getUserInfoById.do",BaseURL]

//用户评论图片上传 参数 userId 请求方式POST
#define UPDATE_COMMENT_PHOTO [NSString stringWithFormat:@"%@/commentInfo/uploadCommentImage.do",BaseURL]

//获取用户的详细信息 请求方式GET
#define GET_USER_INFO [NSString stringWithFormat:@"%@/customerOwn/getOtherInformation.do",BaseURL]

//获取头像路径 参数 path 请求方式GET
#define GET_ICON [NSString stringWithFormat:@"%@/icon.do",BaseURL]

//根据用户ID获取用户信息 参数 id 请求方式GET
#define GET_BY_ID [NSString stringWithFormat:@"%@/customerinfo/getById.do",BaseURL]

//获取关于我们 参数 client versionId 请求方式GET
#define ABOUT_US [NSString stringWithFormat:@"%@/aboutUs/selectOneByVersion.do",BaseURL]

//获取服务协议 参数 client versionId 请求方式GET
#define AGREEMENT_INFO [NSString stringWithFormat:@"%@/agreementInfo/selectOneByVersion.do",BaseURL]

//版本获取 参数 versionId 请求方式GET
#define VERSION [NSString stringWithFormat:@"%@/version/getLastVersion.do",BaseURL]

//意见反馈 参数 appType adverContent adverUserTel adverUserName version 请求方式POST
#define ADVICE_INFO [NSString stringWithFormat:@"%@/adviceInfo/addNewAdvice.do",BaseURL]

#pragma mark - 一键入住新增订单接口

//新增订单  请求方式POST
#define ADD_NEW_ORDER [NSString stringWithFormat:@"%@/orderInfo/addNewOrder.do",BaseURL]

//用户订单补充接口  请求方式POST
#define UPDATE_ORDER [NSString stringWithFormat:@"%@/orderInfo/updateOrder.do",BaseURL]

//用户订单补充接口  请求方式POST
#define GET_COUNT_BY_PROVINCE_CITY [NSString stringWithFormat:@"%@/activity/getCountByProvinceCity.do",BaseURL]

#pragma mark - 钱包模块接口，充值和支付接口

//获取用户可提现金额，可消费金额 参数 userId token 请求方式GET
#define GET_ACCOUNT_MONEY [NSString stringWithFormat:@"%@/customerinfo/getAccountMoney.do",BaseURL]

//充值明细 参数 userId token 请求方式GET
#define GET_CUSOTEMER_RECHARGE [NSString stringWithFormat:@"%@/customerinfo/getCusotmerRecharge.do",BaseURL]

//充值活动列表接口 参数 userId token 请求方式GET
#define GET_RECHARGE_ACTIVITYS [NSString stringWithFormat:@"%@/activity/getRechargeActivitys.do",BaseURL]

//支付宝支付接口 参数 userId token 请求方式GET
#define ALIPAY_ORDER_INFO [NSString stringWithFormat:@"%@/alipay/getOrderInfo.do",BaseURL]

//支付宝充值接口 参数 userId token 请求方式GET
#define ALIPAY_ORDER_INFO_FOR_RECHARGE [NSString stringWithFormat:@"%@/alipay/getOrderInfoForRecharge.do",BaseURL]

//微信支付接口 参数 userId token 请求方式GET
#define WEICHAT_PRE_PAY [NSString stringWithFormat:@"%@/pay/webchatPrePay.do",BaseURL]

//微信充值接口 参数 userId token 请求方式GET
#define WEICHAT_PRE_PAY_FOR_RECHARGE [NSString stringWithFormat:@"%@/pay/webchatPrePayForRecharge.do",BaseURL]

//余额支付接口 参数 orderId userId token totalIncome应付总金额 请求方式GET
#define BALANCE_PAY [NSString stringWithFormat:@"%@/orderInfo/balancePay.do",BaseURL]
//余额支付接口带密码 参数 orderId userId token payPassword应付总金额 请求方式POST
#define POST_BALANCE_PAY [NSString stringWithFormat:@"%@/orderInfo/balancePay35.do",BaseURL]

#pragma mark - 订单模块接口

//用户抵用券列表 参数 userId token 请求方式GET
#define GET_CUSOTEMER_COUPON [NSString stringWithFormat:@"%@/customerinfo/getCusotmerCoupon3.do",BaseURL]

//旧的用户抵用券列表 参数 userId token 请求方式GET
#define GET_OLD_CUSOTEMER_COUPON [NSString stringWithFormat:@"%@/customerinfo/getCusotmerCoupon.do",BaseURL]

//用户抵用券数量 参数 userId token 请求方式GET
#define GET_CUSOTEMER_COUPON_COUNT [NSString stringWithFormat:@"%@/customerinfo/getCusotmerCouponCount.do",BaseURL]

//广告列表 参数 appType (1:商户 2：用户) 请求方式GET
#define LIST_ADVERTISEMENT [NSString stringWithFormat:@"%@/advertisementInfo/listAdvertisement.do",BaseURL]

//获取首页活动酒店类型 参数 customerId (用户id) 请求方式GET
#define CUSTOMER_HOTEL_REL [NSString stringWithFormat:@"%@/businessInfo/customerHotelRel.do",BaseURL]

//评论接口  请求方式POST
#define ADD_NEW_COMMENT_INFO [NSString stringWithFormat:@"%@/commentInfo/addNewCommentInfo.do",BaseURL]

//获取订单信息接口 参数 orderId  userId  token 请求方式GET
#define GET_ORDER_BY_ID [NSString stringWithFormat:@"%@/orderInfo/getById.do",BaseURL]

//酒店详情接口 参数 orderId  userId  token 请求方式GET
#define GET_BY_D_TO_ID [NSString stringWithFormat:@"%@/orderInfo/getByDtoId.do",BaseURL]

//订单列表接口 参数 userId  token 请求方式GET
#define SELECT_D_TO_LIST_FOR_MOBILE_ID [NSString stringWithFormat:@"%@/orderInfo/selectDtoListForMobile.do",BaseURL]

//订单取消接口 参数 id  userId  token 请求方式POST
#define CANCLE_ORDER [NSString stringWithFormat:@"%@/orderInfo/cancelOrder.do",BaseURL]

//订单详情接口 参数 orderId  userId  token 请求方式GET
#define GET_BY_ORDER_DETAIL_ID [NSString stringWithFormat:@"%@/orderInfo/getById.do",BaseURL]

//填写订单接口 参数 请求方式POST
#define CONFIRM_ORDER [NSString stringWithFormat:@"%@/orderInfo/confirmOrder.do",BaseURL]

//酒店评论数据接口 请求方式GET
#define GET_SELECTLIST_FOR_MOBILE [NSString stringWithFormat:@"%@/commentInfo/selectListForMobile.do",BaseURL]

//在住宿友接口 请求方式GET
#define GET_SIMPLE_DAY_FRIEND [NSString stringWithFormat:@"%@/customerinfo/getSimpleDayFriend.do",BaseURL]

#pragma mark - 银行卡接口

//绑定银行卡步骤1接口 请求方式POST
#define BINDING_BANK_CARD_ONE [NSString stringWithFormat:@"%@/businessInfo/cibToEpAuthSyncWithSms.do",BaseURL]

//绑定银行卡步骤2接口 请求方式POST
#define BINDING_BANK_CARD_TWO [NSString stringWithFormat:@"%@/businessInfo/cibToEpAuthCheckSms.do",BaseURL]

//根据银行卡号获取银行信息
#define GET_BANK_INFO [NSString stringWithFormat:@"%@/bankInfo/getBankInfo.do",BaseURL]

//获取绑定的银行卡
#define GET_BANK_LIST [NSString stringWithFormat:@"%@/customerinfo/getBankList.do",BaseURL]

//解除绑定的银行卡
#define UNBIND_BANK_CARD [NSString stringWithFormat:@"%@/businessInfo/epAuthCancel.do",BaseURL]

//获取服务器的版本号
#define UPDATE_VERSION [NSString stringWithFormat:@"%@/version/getLastVersion2.do",BaseURL]

#define GET_MY_GIFT_FOR_XZB [NSString stringWithFormat:@"RESERVE$$EXIT&&**OVER001@"]

#pragma mark - 支付和登录密码设置接口

//修改登录密码
#define POST_UPDATE_CUSTOMER_PASSWORD [NSString stringWithFormat:@"%@/login/updateCustomerPassword.do",BaseURL]

//获取短信验证码
#define GET_VERIFY_PHONE [NSString stringWithFormat:@"%@/login/verifyPhone35.do",BaseURL]

//设置支付密码
#define POST_SET_CUSTOMER_PAY_PASSWORD [NSString stringWithFormat:@"%@/login/setCustomerPayPassword.do",BaseURL]

//修改支付密码
#define POST_UPDATE_CUSTOMER_PAY_PASSWORD [NSString stringWithFormat:@"%@/login/updateCustomerPayPassword.do",BaseURL]

//校验验证码
#define GET_CHECK_VERIFY_CODE [NSString stringWithFormat:@"%@/login/checkVerifyCode.do",BaseURL]

// 设置密码
#define SetPassword [NSString stringWithFormat:@"%@/login/setCustomerPassword.do",BaseURL]
// 密码登录
#define PwdLogin [NSString stringWithFormat:@"%@/login/customsLogin.do",BaseURL]

#pragma mark - 活动接口

//获取一元酒店活动开关接口 请求方式GET
#define GET_ACTIVITY_SWITCH [NSString stringWithFormat:@"%@/activity/getActivitySwitch.do",BaseURL]
//获取用户推荐人数接口 参数 userId 请求方式GET
#define GET_REFERRE_NUM [NSString stringWithFormat:@"%@/activity/getReferreNum.do",BaseURL]
//获取用户推荐码接口 参数 userId 请求方式GET
#define GET_REFERRE_CODE [NSString stringWithFormat:@"%@/activity/getReferralCode.do",BaseURL]
//获取酒店类型价格区间接口 参数 xLocation yLocation 请求方式GET
#define GET_HOTEL_TYPE_PRICE [NSString stringWithFormat:@"%@/activity/getHotelTypePrice.do",BaseURL]
//用户提现申请接口 参数 xLocation yLocation 请求方式GET
#define ADD_USER_CASH [NSString stringWithFormat:@"%@/userCash/addUserCash.do",BaseURL]


#pragma mark - 第三方登录接口

//微信登录
#define POST_WX_LOGIN [NSString stringWithFormat:@"%@/login/webchatLogin.do",BaseURL]
//创建微信登录
#define POST_CREAT_WX_LOGIN [NSString stringWithFormat:@"%@/login/createdWebchatCustomer.do",BaseURL]
//QQ登录
#define POST_QQ_LOGIN [NSString stringWithFormat:@"%@/login/qqLogin.do",BaseURL]
//创建QQ登录
#define POST_CREAT_QQ_LOGIN [NSString stringWithFormat:@"%@/login/createdQQCustomer.do",BaseURL]


#endif /* InterfaceAPIHeader_h */
