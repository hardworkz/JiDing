//
//  UserAccount.h
//  0YuanGO
//
//  Created by 敲代码mac1号 on 16/3/9.
//  Copyright © 2016年 Silicici. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserAccount : NSObject
@property (nonatomic, copy) NSString *userId;/**<用户id*/
@property (nonatomic, copy) NSString *username;/**<用户名*/
@property (nonatomic, copy) NSString *email;/**<用户邮箱*/
@property (nonatomic, copy) NSString *nickName;/**<用户昵称*/
@property (nonatomic, copy) NSString *password;/**<用户密码*/
@property (nonatomic, copy) NSString *mobile;/**<用户手机号*/
@property (nonatomic, copy) NSString *state;
@property (nonatomic, copy) NSString *brith;/**<用户生日*/
@property (nonatomic, copy) NSString *province;/**<省*/
@property (nonatomic, copy) NSString *city;/**<市*/
@property (nonatomic, copy) NSString *area;/**<地区*/
@property (nonatomic, copy) NSString *spreadNum;
@property (nonatomic, copy) NSString *forgetPwd;/**<用户忘记密码*/
@property (nonatomic, copy) NSString *lastLogin;/**<最后一次登录时间*/
@property (nonatomic, copy) NSString *loginToken;/**<用户登录token*/
@property (nonatomic, copy) NSString *regDate;
@property (nonatomic, copy) NSString *modifyUser;
@property (nonatomic, copy) NSString *modifyDate;
@property (nonatomic, copy) NSString *userPhoto;/**<用户头像*/
@property (nonatomic, copy) NSString *sex;/**<用户性别*/
@property (nonatomic, copy) NSString *remark;/**<个性签名*/
@property (nonatomic, copy) NSString *identityCard;/**<身份证号*/
@property (nonatomic, copy) NSString *realName;/**<真实姓名*/
@property (nonatomic, copy) NSString *inviteCode;/**<用户邀请码*/
@property (nonatomic, copy) NSString *payPassword;/**<支付密码*/
@property (nonatomic, copy) NSString *couponMoney;/**<支付密码*/
@property (nonatomic, copy) NSString *emUserName;/**<环信昵称*/
@property (nonatomic, copy) NSString *emPassword;/**<环信密码*/
@property (nonatomic, copy) NSString *incomeType;/**<邀请页面type判读参数*/
@property (nonatomic, copy) NSString *qqid;/**<绑定的qq*/
@property (nonatomic, copy) NSString *webchatid;/**<绑定的微信*/
@property (nonatomic, copy) NSString *signature;/**个性签名*/
@end
