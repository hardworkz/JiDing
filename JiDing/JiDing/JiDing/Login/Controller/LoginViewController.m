//
//  LoginViewController.m
//  JiDing
//
//  Created by zhangrongting on 2017/5/29.
//  Copyright © 2017年 zhangrongting. All rights reserved.
//

#import "LoginViewController.h"
// 导入shareSDK头文件
#import <ShareSDKExtension/SSEThirdPartyLoginHelper.h>

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
        button.tag = i;
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
    if ([phoneTextField.text isEqualToString:@""]) {
        [[Toast makeText:@"请先输入手机号码"] show];
        return;
    }
    if (phoneTextField.text.length != 11) {
        [[Toast makeText:@"请输入正确手机号码"] show];
        return;
    }
    if ([pwdTextField.text isEqualToString:@""]) {
        [[Toast makeText:@"请先输入密码"] show];
        return;
    }if (pwdTextField.text.length >= 6 && pwdTextField.text.length <= 20) {
        
    }else {
        [[Toast makeText:@"密码长度不正确！（6~20位之间）"] show];
        return;
    }
    button.enabled = NO;
    //获取当前版本号
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[@"CFBundleShortVersionString"];
    
    NSDictionary *param = @{@"username":phoneTextField.text,@"password":pwdTextField.text,USERID:@"0",@"equipmentType":@"2",@"equipmentCode":[OpenUDID value],@"channelId":@"",@"appVersion":currentVersion};
    RTLog(@"%@",param);
    [RTHttpTool post:PwdLogin addHUD:YES param:param success:^(id responseObj) {
        button.enabled = YES;
        RTLog(@"登录返回信息为：%@",responseObj);
        if ([responseObj[SUCCESS] intValue] == 1) {
            //保存登录用户数据
            UserAccount *account = [UserAccount mj_objectWithKeyValues:responseObj[ENTITIES][CUSTOMER_INFO] context:nil];
            [UserAccountTool saveWithAccount:account];
            
            [[NSNotificationCenter defaultCenter] postNotificationName:UserUpdateMessageNotification object:nil];
            [[NSNotificationCenter defaultCenter] postNotificationName:LoginNotification object:nil];
            
        }else
        {
            [[Toast makeText:responseObj[MESSAGE]] show];
        }
    } failure:^(NSError *error) {
        button.enabled = YES;
        RTLog(@"error:%@",error);
    }];

}

/**
 第三方SDK登录

 @param button 登录按钮
 */
- (void)SDKLogin:(UIButton *)button
{
    if (button.tag == 0) {//QQ
        [SSEThirdPartyLoginHelper loginByPlatform:SSDKPlatformTypeQQ onUserSync:^(SSDKUser *user, SSEUserAssociateHandler associateHandler) {
            //在此回调中可以将社交平台用户信息与自身用户系统进行绑定，最后使用一个唯一用户标识来关联此用户信息。
            //在此示例中没有跟用户系统关联，则使用一个社交用户对应一个系统用户的方式。将社交用户的uid作为关联ID传入associateHandler。
            NSString *currentVersion = [NSBundle mainBundle].infoDictionary[@"CFBundleShortVersionString"];
            [RTHttpTool post:POST_QQ_LOGIN addHUD:YES param:@{@"webchatid":user.uid,@"equipmentType":@"2",@"equipmentCode":[OpenUDID value],@"channelId":@"",@"appVersion":currentVersion} success:^(id responseObj) {
                RTLog(@"微信登录返回数据为：%@",responseObj);
                if ([responseObj[SUCCESS] integerValue] == 1) {
                    //保存登录用户数据
                    UserAccount *account = [UserAccount mj_objectWithKeyValues:responseObj[ENTITIES][CUSTOMER_INFO] context:nil];
                    [UserAccountTool saveWithAccount:account];
                    
                }
            } failure:^(NSError *error) {
                
            }];
            NSLog(@"dd%@",user.rawData);
            NSLog(@"dd%@",user.credential);
        } onLoginResult:^(SSDKResponseState state, SSEBaseUser *user, NSError *error) {
            if (state == SSDKResponseStateSuccess)
            {
                
            }
        }];
    }else if (button.tag == 1){//微信
        [SSEThirdPartyLoginHelper loginByPlatform:SSDKPlatformTypeWechat onUserSync:^(SSDKUser *user, SSEUserAssociateHandler associateHandler) {
            //在此回调中可以将社交平台用户信息与自身用户系统进行绑定，最后使用一个唯一用户标识来关联此用户信息。
            //在此示例中没有跟用户系统关联，则使用一个社交用户对应一个系统用户的方式。将社交用户的uid作为关联ID传入associateHandler。
            NSString *currentVersion = [NSBundle mainBundle].infoDictionary[@"CFBundleShortVersionString"];
            [RTHttpTool post:POST_WX_LOGIN addHUD:YES param:@{@"webchatid":user.uid,@"equipmentType":@"2",@"equipmentCode":[OpenUDID value],@"channelId":@"",@"appVersion":currentVersion} success:^(id responseObj) {
                RTLog(@"微信登录返回数据为：%@",responseObj);
                if ([responseObj[SUCCESS] integerValue] == 1) {
                    //保存登录用户数据
                    UserAccount *account = [UserAccount mj_objectWithKeyValues:responseObj[ENTITIES][CUSTOMER_INFO] context:nil];
                    [UserAccountTool saveWithAccount:account];
                    
                }
            } failure:^(NSError *error) {
                
            }];

            NSLog(@"dd%@",user.rawData);
            NSLog(@"dd%@",user.credential);
        } onLoginResult:^(SSDKResponseState state, SSEBaseUser *user, NSError *error) {
            if (state == SSDKResponseStateSuccess)
            {
                
            }
        }];
    }else{//微博
        [SSEThirdPartyLoginHelper loginByPlatform:SSDKPlatformTypeSinaWeibo onUserSync:^(SSDKUser *user, SSEUserAssociateHandler associateHandler) {
            //在此回调中可以将社交平台用户信息与自身用户系统进行绑定，最后使用一个唯一用户标识来关联此用户信息。
            //在此示例中没有跟用户系统关联，则使用一个社交用户对应一个系统用户的方式。将社交用户的uid作为关联ID传入associateHandler。
            NSLog(@"dd%@",user.rawData);
            NSLog(@"dd%@",user.credential);
        } onLoginResult:^(SSDKResponseState state, SSEBaseUser *user, NSError *error) {
            if (state == SSDKResponseStateSuccess)
            {
                
            }
        }];
    }
}
- (void)registerBtnClicked:(UIButton *)button
{
    RegisterViewController *registerVC = [[RegisterViewController alloc] init];
    [self.navigationController pushViewController:registerVC animated:YES];
}
- (void)forgetPwdBtnClicked:(UIButton *)button
{
    ForgetPwdViewController *forgetPwdVC = [[ForgetPwdViewController alloc] init];
    [self.navigationController pushViewController:forgetPwdVC animated:YES];
}
@end
