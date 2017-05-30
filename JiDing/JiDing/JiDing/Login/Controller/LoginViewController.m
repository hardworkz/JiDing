//
//  LoginViewController.m
//  JiDing
//
//  Created by zhangrongting on 2017/5/29.
//  Copyright © 2017年 zhangrongting. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()<UITextFieldDelegate>
{
    UIImageView *iconView;
    UITextField *phoneTextField;
    UITextField *pwdTextField;
    UIButton *loginBtn;
    UIButton *registerBtn;
    UIButton *forgetPwdBtn;
}
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"登录";
    
    //设置一张透明图片遮盖导航栏底下的黑色线条
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"shadow"]
                            forBarPosition:UIBarPositionAny
                                barMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    [self setupView];
}
- (void)setupView
{
    //设置登录应用图标
    iconView = [[UIImageView alloc] init];
    iconView.image = [UIImage imageNamed:@"输入账号"];
    iconView.frame = CGRectMake(0, 30, SCREEN_WIDTH, 100);
    iconView.contentMode = UIViewContentModeCenter;
    [self.view addSubview:iconView];
    
    //用户账号
    UIView *phoneView = [[UIView alloc] init];
    phoneView.backgroundColor = AppLightLineColor;
    phoneView.frame = CGRectMake(40, CGRectGetMaxY(iconView.frame) + 20, SCREEN_Width - 80, 50);
    phoneView.layer.cornerRadius = 25;
    [self.view addSubview:phoneView];
    
    UIImageView *phoneIconView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 0, 30, 50)];
    phoneIconView.image = [UIImage imageNamed:@"输入账号"];
    phoneIconView.contentMode = UIViewContentModeCenter;
    [phoneView addSubview:phoneIconView];
    
    phoneTextField = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(phoneIconView.frame), 0, SCREEN_WIDTH - 125, 50)];
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:@"输入账号"];
    [str addAttribute:NSForegroundColorAttributeName value:HEXCOLOR(0x929292) range:NSMakeRange(0,str.length)];
    phoneTextField.attributedPlaceholder = str;
    phoneTextField.backgroundColor = [UIColor clearColor];
    phoneTextField.tintColor = AppMainColor;
    phoneTextField.delegate = self;
    phoneTextField.keyboardType = UIKeyboardTypePhonePad;
    [phoneView addSubview:phoneTextField];

    //用户密码
    UIView *pwdView = [[UIView alloc] init];
    pwdView.backgroundColor = AppLightLineColor;
    pwdView.frame = CGRectMake(40, CGRectGetMaxY(phoneView.frame) + 20, SCREEN_Width - 80, 50);
    pwdView.layer.cornerRadius = 25;
    [self.view addSubview:pwdView];
    
    UIImageView *pwdIconView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 0, 30, 50)];
    pwdIconView.image = [UIImage imageNamed:@"输入密码"];
    pwdIconView.contentMode = UIViewContentModeCenter;
    [pwdView addSubview:pwdIconView];
    
    pwdTextField = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(phoneIconView.frame), 0, SCREEN_WIDTH - 125, 50)];
    NSMutableAttributedString *str2 = [[NSMutableAttributedString alloc] initWithString:@"输入密码"];
    [str2 addAttribute:NSForegroundColorAttributeName value:HEXCOLOR(0x929292) range:NSMakeRange(0,str2.length)];
    pwdTextField.attributedPlaceholder = str2;
    pwdTextField.backgroundColor = [UIColor clearColor];
    pwdTextField.tintColor = AppMainColor;
    pwdTextField.delegate = self;
    pwdTextField.keyboardType = UIKeyboardTypePhonePad;
    [pwdView addSubview:pwdTextField];

    //登录按钮
    loginBtn = [[UIButton alloc] init];
    loginBtn.backgroundColor = AppMainColor;
    loginBtn.layer.cornerRadius = 25;
    [loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    loginBtn.frame = CGRectMake(40, CGRectGetMaxY(pwdView.frame) + 20, SCREEN_WIDTH - 80, 50);
    [loginBtn addTarget:self action:@selector(loginBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginBtn];
    //注册账号
    registerBtn = [[UIButton alloc] init];
    [registerBtn setTitleColor:AppDeepGrayTextColor forState:UIControlStateNormal];
    [registerBtn.titleLabel setAppFontWithSize:14];
    [registerBtn setTitle:@"注册账号" forState:UIControlStateNormal];
    registerBtn.frame = CGRectMake(40, CGRectGetMaxY(loginBtn.frame) + 10, 100, 20);
    [registerBtn addTarget:self action:@selector(registerBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:registerBtn];
    //忘记密码
    forgetPwdBtn = [[UIButton alloc] init];
    [forgetPwdBtn setTitleColor:AppDeepGrayTextColor forState:UIControlStateNormal];
    [forgetPwdBtn.titleLabel setAppFontWithSize:14];
    [forgetPwdBtn setTitle:@"忘记密码?" forState:UIControlStateNormal];
    forgetPwdBtn.frame = CGRectMake(SCREEN_WIDTH - 100- 40, CGRectGetMaxY(loginBtn.frame) + 10, 100, 20);
    [forgetPwdBtn addTarget:self action:@selector(forgetPwdBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:forgetPwdBtn];
    
    //第三方登录按钮
    for (int i = 0; i<3; i++) {
        UIButton *button = [[UIButton alloc] init];
        button.frame = CGRectMake((SCREEN_WIDTH - 150)/4 + (50 + (SCREEN_WIDTH - 150)/4)*i,SCREEN_HEIGHT - 50 - 50 - 64, 50, 50);
        if (i == 0) {
            [button setBgImage:@"QQ"];
        }else if(i == 1){
            [button setBgImage:@"微信"];
        }else{
            [button setBgImage:@"微博"];
        }
        [button addTarget:self action:@selector(SDKLogin:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];

    }
}
#pragma mark - action
- (void)loginBtnClicked:(UIButton *)button
{
    
}
- (void)SDKLogin:(UIButton *)button
{
    
}
- (void)registerBtnClicked:(UIButton *)button
{
    
}
- (void)forgetPwdBtnClicked:(UIButton *)button
{
    
}
@end
