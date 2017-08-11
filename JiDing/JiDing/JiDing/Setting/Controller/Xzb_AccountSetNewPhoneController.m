//
//  Xzb_AccountSetNewPhoneController.m
//  xzb
//
//  Created by 张荣廷 on 16/9/13.
//  Copyright © 2016年 xuwk. All rights reserved.
//

#import "Xzb_AccountSetNewPhoneController.h"

@interface Xzb_AccountSetNewPhoneController ()<UITextFieldDelegate>
@property (nonatomic,weak)  UITextField *phoneTextField;
@property (nonatomic,weak)  UITextField *verifyCodeTextField;
@property (nonatomic,weak)  Xzb_CountDownButton *reGetCodeBtn;
@end

@implementation Xzb_AccountSetNewPhoneController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //输入手机号码
    UIView *phoneView = [[UIView alloc] init];
    phoneView.backgroundColor = [UIColor whiteColor];
    phoneView.frame = CGRectMake(0,10, SCREEN_Width, 44);
    [self.view addSubview:phoneView];
    
    UITextField *phoneTextField = [[UITextField alloc] init];
    phoneTextField.keyboardType = UIKeyboardTypePhonePad;
    phoneTextField.delegate = self;
    phoneTextField.tintColor = AppMainColor;
    phoneTextField.placeholder = @"请输入手机号";
    phoneTextField.frame = CGRectMake(10, 0, SCREEN_Width * 0.5, 44);
    phoneTextField.backgroundColor = [UIColor whiteColor];
//    phoneTextField.textAlignment = NSTextAlignmentCenter;
    [phoneView addSubview:phoneTextField];
    self.phoneTextField = phoneTextField;
    
    //获取验证码
    Xzb_CountDownButton *reGetCodeBtn = [[Xzb_CountDownButton alloc] init];
    reGetCodeBtn.frame = CGRectMake(SCREEN_Width - 110, 5,100, 34);
    reGetCodeBtn.backgroundColor = AppGreenBtnColor;
    [reGetCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [reGetCodeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    reGetCodeBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [reGetCodeBtn addTarget:self action:@selector(reGetCodeBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    reGetCodeBtn.index = 60;
    reGetCodeBtn.layer.cornerRadius = 5;
    [phoneView addSubview:reGetCodeBtn];
    self.reGetCodeBtn = reGetCodeBtn;
    
    //短信验证码
    UIView *verifyCodeView = [[UIView alloc] init];
    verifyCodeView.backgroundColor = [UIColor whiteColor];
    verifyCodeView.frame = CGRectMake(0,CGRectGetMaxY(phoneView.frame)+10, SCREEN_Width, 44);
    [self.view addSubview:verifyCodeView];
    
    UITextField *verifyCodeTextField = [[UITextField alloc] init];
    verifyCodeTextField.keyboardType = UIKeyboardTypePhonePad;
    verifyCodeTextField.delegate = self;
    verifyCodeTextField.tintColor = AppMainColor;
    verifyCodeTextField.placeholder = @"请输入验证码";
    verifyCodeTextField.frame = CGRectMake(10, 0, SCREEN_Width * 0.5, 44);
    verifyCodeTextField.backgroundColor = [UIColor whiteColor];
//    verifyCodeTextField.textAlignment = NSTextAlignmentCenter;
    [verifyCodeView addSubview:verifyCodeTextField];
    self.verifyCodeTextField = verifyCodeTextField;
    
    //下一步按钮
    UIButton *commitBtn = [[UIButton alloc] init];
    commitBtn.backgroundColor = AppGreenBtnColor;
    commitBtn.layer.cornerRadius = 5;
    [commitBtn setTitle:@"提交" forState:UIControlStateNormal];
    [commitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    commitBtn.frame = CGRectMake(10, CGRectGetMaxY(verifyCodeView.frame) + 20, SCREEN_Width - 20, 50);
    [commitBtn addTarget:self action:@selector(commitBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:commitBtn];

}
/**
 *  提交
 */
- (void)commitBtnClicked:(UIButton *)button
{
}
/**
 *  重新获取验证码
 */
- (void)reGetCodeBtnClicked
{
    [self.reGetCodeBtn attAction];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
