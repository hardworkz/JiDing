//
//  UserAccount.m
//  0YuanGO
//
//  Created by 敲代码mac1号 on 16/3/9.
//  Copyright © 2016年 Silicici. All rights reserved.
//

#import "UserAccount.h"

@implementation UserAccount
+ (void)load {
    [UserAccount
     mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
        return @{
                 @"userId":@"id"
                 };
    }];
}
//+ (NSDictionary *)mj_objectClassInArray
//{
//    return @{@"dynamics":[UserDynamic class]};
//}

//将对象写入文件

/*
 "customerInfo":  {
 
 "id":  95,
 
 "username":  "18659220497",
 
 "email":  null,
 
 "nickName":  "灏忔椇",
 
 "password":  "297aa8e78200883ae51115e163d4ab57",
 
 "state":  "1",
 
 "mobile":  "18659220497",
 
 "brith":  null,
 
 "province":  null,
 
 "city":  null,
 
 "area":  null,
 
 "spreadNum":  null,
 
 "forgetPwd":  null,
 
 "lastLogin":  "2016-05-19 14:34:50",
 
 "regDate":  "2016-05-19 14:34:50",
 
 "modifyUser":  null,
 
 "modifyDate":  "2016-05-19 14:34:50",
 
 "userPhoto":  "default_head.jpeg",
 
 "sex":  null,
 
 "remark":  null
 
 }
 */
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.userId forKey:@"userId"];
    [aCoder encodeObject:self.username forKey:@"username"];
    [aCoder encodeObject:self.email forKey:@"email"];
    [aCoder encodeObject:self.nickName forKey:@"nickName"];
    [aCoder encodeObject:self.password forKey:@"password"];
    [aCoder encodeObject:self.state forKey:@"state"];
    [aCoder encodeObject:self.mobile forKey:@"mobile"];
    [aCoder encodeObject:self.brith forKey:@"brith"];
    [aCoder encodeObject:self.province forKey:@"province"];
    [aCoder encodeObject:self.city forKey:@"city"];
    [aCoder encodeObject:self.area forKey:@"area"];
    [aCoder encodeObject:self.spreadNum forKey:@"spreadNum"];
    [aCoder encodeObject:self.forgetPwd forKey:@"forgetPwd"];
    [aCoder encodeObject:self.lastLogin forKey:@"lastLogin"];
    [aCoder encodeObject:self.regDate forKey:@"regDate"];
    [aCoder encodeObject:self.modifyUser forKey:@"modifyUser"];
    [aCoder encodeObject:self.modifyDate forKey:@"modifyDate"];
    [aCoder encodeObject:self.userPhoto forKey:@"userPhoto"];
    [aCoder encodeObject:self.sex forKey:@"sex"];
    [aCoder encodeObject:self.remark forKey:@"remark"];
    [aCoder encodeObject:self.loginToken forKey:@"loginToken"];
    [aCoder encodeObject:self.identityCard forKey:@"identityCard"];
    [aCoder encodeObject:self.realName forKey:@"realName"];
    [aCoder encodeObject:self.inviteCode forKey:@"inviteCode"];
    [aCoder encodeObject:self.payPassword forKey:@"payPassword"];
    [aCoder encodeObject:self.qqid forKey:@"qqid"];
    [aCoder encodeObject:self.webchatid forKey:@"webchatid"];
    [aCoder encodeObject:self.signature forKey:@"signature"];
}
//从文件中取出解析
- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        self.userId = [aDecoder decodeObjectForKey:@"userId"];
        self.username = [aDecoder decodeObjectForKey:@"username"];
        self.email = [aDecoder decodeObjectForKey:@"email"];
        self.nickName = [aDecoder decodeObjectForKey:@"nickName"];
        self.password = [aDecoder decodeObjectForKey:@"password"];
        self.state = [aDecoder decodeObjectForKey:@"state"];
        self.mobile = [aDecoder decodeObjectForKey:@"mobile"];
        self.brith = [aDecoder decodeObjectForKey:@"brith"];
        self.province = [aDecoder decodeObjectForKey:@"province"];
        self.city = [aDecoder decodeObjectForKey:@"city"];
        self.area = [aDecoder decodeObjectForKey:@"area"];
        self.spreadNum = [aDecoder decodeObjectForKey:@"spreadNum"];
        self.forgetPwd = [aDecoder decodeObjectForKey:@"forgetPwd"];
        self.lastLogin = [aDecoder decodeObjectForKey:@"lastLogin"];
        self.regDate = [aDecoder decodeObjectForKey:@"regDate"];
        self.modifyUser = [aDecoder decodeObjectForKey:@"modifyUser"];
        self.modifyDate = [aDecoder decodeObjectForKey:@"modifyDate"];
        self.userPhoto = [aDecoder decodeObjectForKey:@"userPhoto"];
        self.sex = [aDecoder decodeObjectForKey:@"sex"];
        self.remark = [aDecoder decodeObjectForKey:@"remark"];
        self.loginToken = [aDecoder decodeObjectForKey:@"loginToken"];
        self.identityCard = [aDecoder decodeObjectForKey:@"identityCard"];
        self.realName = [aDecoder decodeObjectForKey:@"realName"];
        self.inviteCode = [aDecoder decodeObjectForKey:@"inviteCode"];
        self.payPassword = [aDecoder decodeObjectForKey:@"payPassword"];
        self.qqid = [aDecoder decodeObjectForKey:@"qqid"];
        self.webchatid = [aDecoder decodeObjectForKey:@"webchatid"];
        self.signature = [aDecoder decodeObjectForKey:@"signature"];
    }
    return self;
}
- (NSString *)userPhoto
{
    return [RTHttpTool returnPhotoStringWithString:_userPhoto];
}
- (NSString *)nickName
{
    if (_nickName) {
        return _nickName;
    }else{
        return @"未登录";
    }
}
- (NSString *)sex
{
    if ([_sex isEqualToString:@"1"]) {
        return @"男";
    }else if ([_sex isEqualToString:@"2"])  {
        return @"女";
    }else
    {
        return _sex;
    }
}

- (NSString *)brith
{
    if (_brith.length >= 10) {
        return [_brith substringToIndex:10];
    }else {
        return _brith;
    }
    
}

@end
