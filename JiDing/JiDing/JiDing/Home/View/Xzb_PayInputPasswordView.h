//
//  Xzb_PayInputPasswordView.h
//  xzb
//
//  Created by 张荣廷 on 16/9/20.
//  Copyright © 2016年 xuwk. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^PayResultBlock)(NSString *message);
typedef void (^ForgetPwdBlock)();

@interface Xzb_PayInputPasswordView : UIView
@property (nonatomic , weak) UIButton *cover;
@property (nonatomic,weak)  UITextField *passwordTextField;
@property (nonatomic,weak)  UILabel *payMoneyLabel;
@property (nonatomic,strong) NSString *payMoney;
@property (nonatomic,strong) NSString *orderID;

@property(nonatomic,copy)PayResultBlock payBlock;//余额支付结果回调
@property(nonatomic,copy)ForgetPwdBlock forgetPwdBlock;//忘记密码block

- (void)show;
- (void)coverClick;
@end
