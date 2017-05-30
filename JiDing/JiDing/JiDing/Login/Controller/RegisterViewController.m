//
//  RegisterViewController.m
//  JiDing
//
//  Created by zhangrongting on 2017/5/29.
//  Copyright © 2017年 zhangrongting. All rights reserved.
//

#import "RegisterViewController.h"

@interface RegisterViewController ()<UITextFieldDelegate>
{
    UITextField *phoneTextField;
    Xzb_CountDownButton *reGetCodeBtn;
    UITextField *verifyCodeTextField;
    UITextField *newPasswordTextField;
    UITextField *confirmPasswordTextField;
}
@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"注册";
    self.view.backgroundColor = AppLightLineColor;
    //输入手机号码
    UIView *phoneView = [[UIView alloc] init];
    phoneView.backgroundColor = [UIColor whiteColor];
    phoneView.frame = CGRectMake(0,10, SCREEN_Width, 44);
    [self.view addSubview:phoneView];
    
    phoneTextField = [[UITextField alloc] init];
    phoneTextField.keyboardType = UIKeyboardTypePhonePad;
    phoneTextField.delegate = self;
    phoneTextField.tintColor = AppMainColor;
    phoneTextField.frame = CGRectMake(10, 0, SCREEN_Width * 0.5, 44);
    phoneTextField.enabled = NO;
    phoneTextField.backgroundColor = [UIColor whiteColor];
    [phoneView addSubview:phoneTextField];
    
    //获取验证码
    reGetCodeBtn = [[Xzb_CountDownButton alloc] init];
    reGetCodeBtn.frame = CGRectMake(SCREEN_Width - 110, 5,100, 34);
    reGetCodeBtn.backgroundColor = [UIColor whiteColor];
    [reGetCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [reGetCodeBtn setTitleColor:AppGrayTextColor forState:UIControlStateNormal];
    reGetCodeBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [reGetCodeBtn addTarget:self action:@selector(reGetCodeBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    reGetCodeBtn.index = 60;
    reGetCodeBtn.layer.cornerRadius = 5;
    [phoneView addSubview:reGetCodeBtn];
    
    //短信验证码
    UIView *verifyCodeView = [[UIView alloc] init];
    verifyCodeView.backgroundColor = [UIColor whiteColor];
    verifyCodeView.frame = CGRectMake(0,CGRectGetMaxY(phoneView.frame)+10, SCREEN_Width, 44);
    [self.view addSubview:verifyCodeView];
    
    verifyCodeTextField = [[UITextField alloc] init];
    verifyCodeTextField.keyboardType = UIKeyboardTypePhonePad;
    verifyCodeTextField.delegate = self;
    verifyCodeTextField.tintColor = AppMainColor;
    verifyCodeTextField.placeholder = @"请输入验证码";
    verifyCodeTextField.frame = CGRectMake(10, 0, SCREEN_Width * 0.5, 44);
    verifyCodeTextField.backgroundColor = [UIColor whiteColor];
    [verifyCodeView addSubview:verifyCodeTextField];
    
    //新密码
    UIView *newPasswordView = [[UIView alloc] init];
    newPasswordView.backgroundColor = [UIColor whiteColor];
    newPasswordView.frame = CGRectMake(0,CGRectGetMaxY(verifyCodeView.frame)+10, SCREEN_Width, 44);
    [self.view addSubview:newPasswordView];
    
    newPasswordTextField = [[UITextField alloc] init];
    newPasswordTextField.delegate = self;
    newPasswordTextField.tintColor = AppMainColor;
    newPasswordTextField.placeholder = @"输入密码";
    newPasswordTextField.frame = CGRectMake(10, 0, SCREEN_Width * 0.5, 44);
    newPasswordTextField.secureTextEntry = YES;
    newPasswordTextField.backgroundColor = [UIColor whiteColor];
    [newPasswordView addSubview:newPasswordTextField];
    //新密码
    UIView *confirmPasswordView = [[UIView alloc] init];
    confirmPasswordView.backgroundColor = [UIColor whiteColor];
    confirmPasswordView.frame = CGRectMake(0,CGRectGetMaxY(newPasswordView.frame)+10, SCREEN_Width, 44);
    [self.view addSubview:confirmPasswordView];
    
    confirmPasswordTextField = [[UITextField alloc] init];
    confirmPasswordTextField.delegate = self;
    confirmPasswordTextField.tintColor = AppMainColor;
    confirmPasswordTextField.placeholder = @"确认密码";
    confirmPasswordTextField.frame = CGRectMake(10, 0, SCREEN_Width * 0.5, 44);
    confirmPasswordTextField.secureTextEntry = YES;
    confirmPasswordTextField.backgroundColor = [UIColor whiteColor];
    [newPasswordView addSubview:confirmPasswordTextField];
    //下一步按钮
    UIButton *commitBtn = [[UIButton alloc] init];
    commitBtn.backgroundColor = AppGrayTextColor;
    commitBtn.layer.cornerRadius = 25;
    [commitBtn setTitle:@"注册" forState:UIControlStateNormal];
    [commitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    commitBtn.frame = CGRectMake(30, CGRectGetMaxY(newPasswordView.frame) + 20, SCREEN_Width - 60, 50);
    [commitBtn addTarget:self action:@selector(commitBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:commitBtn];

}
/**
 *  提交
 */
- (void)commitBtnClicked:(UIButton *)button
{
//    if ([self.phoneTextField.text isEqualToString:@""]) {
//        [[Toast makeText:@"手机号不能为空"] show];
//        return;
//    }
//    if ([self.verifyCodeTextField.text isEqualToString:@""]) {
//        [[Toast makeText:@"短信验证码不能为空"] show];
//        return;
//    }
//    if ([self.newsPasswordTextField.text isEqualToString:@""]) {
//        [[Toast makeText:@"新密码不能为空"] show];
//        return;
//    }
//    if (self.newsPasswordTextField.text.length <6) {
//        [[Toast makeText:@"新密码不能为小于6位"] show];
//        return;
//    }
//    if (self.newsPasswordTextField.text.length >20) {
//        [[Toast makeText:@"新密码不能为大于20位"] show];
//        return;
//    }
}
/**
 *  重新获取验证码
 */
- (void)reGetCodeBtnClicked
{
//    if ([self.phoneTextField.text isEqualToString:@""]) {
//        [[Toast makeText:@"手机号不能为空"] show];
//        return;
//    }
//    if (self.phoneTextField.text.length != 11) {
//        [[Toast makeText:@"请输入正确的手机号码"] show];
//        return;
//    }
}
#pragma mark - uitextfielddelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    return [RTHttpTool validateNumber:string textField:textField limitString:kAlphaNum];
}
@end
