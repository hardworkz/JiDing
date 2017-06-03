//
//  Xzb_PayInputPasswordView.m
//  xzb
//
//  Created by 张荣廷 on 16/9/20.
//  Copyright © 2016年 xuwk. All rights reserved.
//

#import "Xzb_PayInputPasswordView.h"

@implementation Xzb_PayInputPasswordView

-(UIView*)topView{
    
    return [[[UIApplication sharedApplication] delegate] window];
}
- (void)show
{
    self.frame = CGRectMake(20, SCREEN_Height, SCREEN_Width - 40, 220);
    self.layer.cornerRadius = 5;
    [[self topView] addSubview:self];
    //添加遮盖
    UIButton *cover = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, SCREEN_Height)];
    
    cover.backgroundColor = [UIColor blackColor];
    cover.alpha = 0;
    [cover addTarget:self action:@selector(coverClick) forControlEvents:UIControlEventTouchUpInside];
    self.cover = cover;
    
    [[self topView] insertSubview:cover belowSubview:self];
    
    [UIView animateWithDuration:0.25 animations:^{
        cover.alpha = 0.4;
    }];
}
- (void)coverClick
{
    [UIView animateWithDuration:0.25 animations:^{
        self.alpha = 0.0;
        self.cover.alpha = 0.0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        [self.cover removeFromSuperview];
    }];
}
- (instancetype)init
{
    if (self == [super init]) {
        self.backgroundColor = [UIColor whiteColor];
        UILabel *payMoneyLabel = [[UILabel alloc] init];
        payMoneyLabel.frame = CGRectMake(0, 0, SCREEN_Width - 40, 60);
        payMoneyLabel.backgroundColor = [UIColor whiteColor];
        payMoneyLabel.textAlignment = NSTextAlignmentCenter;
        payMoneyLabel.numberOfLines = 0;
        payMoneyLabel.textColor = AppMainColor;
        payMoneyLabel.font = [UIFont systemFontOfSize:15];
//        payMoneyLabel.text = @"余额支付";
        payMoneyLabel.layer.cornerRadius = 5;
        payMoneyLabel.layer.masksToBounds = YES;
        [self addSubview:payMoneyLabel];
        self.payMoneyLabel = payMoneyLabel;
        
        UIButton *cancle = [[UIButton alloc] init];
        cancle.frame = CGRectMake(SCREEN_Width - 40 - 8 - 30, 8, 30 , 30);
        [cancle setTitleColor:AppGreenTextColor forState:UIControlStateNormal];
        [cancle setImage:[UIImage imageNamed:@"支付－删除"] forState:UIControlStateNormal];
        [cancle addTarget:self action:@selector(coverClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:cancle];
        
        UIView *devider = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(payMoneyLabel.frame), SCREEN_Width - 40, 0.5)];
        devider.backgroundColor = AppLineColor;
        [self addSubview:devider];
        
        UIView *inputView = [[UIView alloc] init];
        inputView.frame = CGRectMake(0, CGRectGetMaxY(devider.frame), SCREEN_Width - 40, 100);
        inputView.backgroundColor = AppMainBgColor;
        [self addSubview:inputView];
        
        UILabel *tipLabel = [[UILabel alloc] init];
        tipLabel.frame = CGRectMake(0, 0, SCREEN_Width - 40, 40);
        tipLabel.textAlignment = NSTextAlignmentCenter;
        tipLabel.text = @"请输入支付密码";
        tipLabel.textColor = AppMainGrayTextColor;
        tipLabel.font = [UIFont systemFontOfSize:15];
        [inputView addSubview:tipLabel];
        
        UIButton *forgetPwd = [[UIButton alloc] init];
        forgetPwd.frame = CGRectMake(CGRectGetMaxX(tipLabel.frame) - 60 - 10, 0, 60, 40);
        [forgetPwd setTitle:@"忘记密码" forState:UIControlStateNormal];
        forgetPwd.titleLabel.font = [UIFont systemFontOfSize:14];
        [forgetPwd setTitleColor:AppGreenBtnColor forState:UIControlStateNormal];
        [forgetPwd addTarget:self action:@selector(forgetPwdClicked) forControlEvents:UIControlEventTouchUpInside];
        [inputView addSubview:forgetPwd];
        
        UITextField *passwordTextField = [[UITextField alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(tipLabel.frame), ScreenWidth - 40 - 20, 50)];
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:@"请输入支付密码"];
        [str addAttribute:NSForegroundColorAttributeName value:[UIColor lightGrayColor] range:NSMakeRange(0,str.length)];
        [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:NSMakeRange(0,str.length)];
        passwordTextField.attributedPlaceholder = str;
        passwordTextField.backgroundColor = [UIColor whiteColor];
        passwordTextField.tintColor = AppMainColor;
        passwordTextField.textColor = [UIColor blackColor];
        passwordTextField.secureTextEntry = YES;
        passwordTextField.layer.cornerRadius = 5;
        passwordTextField.layer.borderWidth = 1;
        passwordTextField.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, 0)];
        //设置显示模式为永远显示(默认不显示)
        passwordTextField.leftViewMode = UITextFieldViewModeAlways;
        passwordTextField.layer.borderColor = AppLineColor.CGColor;
        [inputView addSubview:passwordTextField];
        self.passwordTextField = passwordTextField;

        UIView *deviderTwo = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(inputView.frame), SCREEN_Width - 20 - 40, 0.5)];
        deviderTwo.backgroundColor = AppLineColor;
        [self addSubview:deviderTwo];
        
        UIButton *done = [[UIButton alloc] init];
        done.frame = CGRectMake(0, CGRectGetMaxY(deviderTwo.frame), SCREEN_Width - 40, 60);
        done.backgroundColor = [UIColor whiteColor];
        [done setTitle:@"确认付款" forState:UIControlStateNormal];
        [done setTitleColor:AppGreenBtnColor forState:UIControlStateNormal];
        [done addTarget:self action:@selector(doneClicked) forControlEvents:UIControlEventTouchUpInside];
        done.layer.cornerRadius = 5;
        [self addSubview:done];
    }
    return self;
}
- (void)setPayMoney:(NSString *)payMoney
{
    _payMoney = payMoney;
    
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"余额支付\n%@",payMoney]];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0,4)];
    [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:17] range:NSMakeRange(0,4)];
    
    self.payMoneyLabel.attributedText = str;
}
- (void)doneClicked
{
    if ([self.passwordTextField.text isEqualToString:@""]) {
        [[Toast makeText:@"支付密码不能为空"] show];
        return;
    }
    if (self.passwordTextField.text.length <6) {
        [[Toast makeText:@"支付密码长度不能小于6位"] show];
        return;
    }
    if (self.passwordTextField.text.length >20) {
        [[Toast makeText:@"支付密码长度不能大于20位"] show];
        return;
    }
    RTLog(@"%@",self.passwordTextField.text);
    UserAccount *account = [UserAccountTool account];
    [RTHttpTool post:POST_BALANCE_PAY addHUD:YES param:@{USERID:account.userId,TOKEN:account.loginToken,@"payPassword":self.passwordTextField.text,ORDERID:self.orderID} success:^(id responseObj) {
        if ([responseObj[SUCCESS] intValue] == 1) {
            
            [self coverClick];
            if (self.payBlock) {
                self.payBlock(@"支付成功");
            }
            [[Toast makeText:@"支付成功"] show];
        }else{
            [[Toast makeText:responseObj[MESSAGE]] show];
            if (self.payBlock) {
                self.payBlock(@"支付失败");
            }
            self.passwordTextField.text = @"";
        }
    } failure:^(NSError *error) {
        RTLog(@"%@",error);
        if (self.payBlock) {
            self.payBlock(@"网络错误");
        }
    }];

}
- (void)forgetPwdClicked
{
    if (self.forgetPwdBlock) {
        self.forgetPwdBlock();
    }
}
@end
