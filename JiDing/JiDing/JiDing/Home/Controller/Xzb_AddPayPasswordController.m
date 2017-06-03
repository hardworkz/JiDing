//
//  Xzb_AddPayPasswordController.m
//  xzb
//
//  Created by 张荣廷 on 16/9/7.
//  Copyright © 2016年 xuwk. All rights reserved.
//

#import "Xzb_AddPayPasswordController.h"

@interface Xzb_AddPayPasswordController ()<UITextFieldDelegate>
@property (nonatomic,weak)  UITextField *passwordTextField;
@property (nonatomic,weak)  UITextField *repeatPasswordTextField;
@end

@implementation Xzb_AddPayPasswordController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"设置支付密码";
    
    //支付密码
    UIView *passwordView = [[UIView alloc] init];
    passwordView.backgroundColor = [UIColor whiteColor];
    passwordView.frame = CGRectMake(0,20, SCREEN_Width, 44);
    [self.view addSubview:passwordView];
    
    UILabel *passwordLabel = [[UILabel alloc] init];
    passwordLabel.text = @"新支付密码";
    passwordLabel.frame = CGRectMake(10, 0, 100, 44);
    [passwordView addSubview:passwordLabel];
    
    
    UITextField *passwordTextField = [[UITextField alloc] init];
    passwordTextField.delegate = self;
    passwordTextField.secureTextEntry = YES;
    passwordTextField.tintColor = AppMainColor;
    passwordTextField.placeholder = @"请输入新的密码";
    passwordTextField.frame = CGRectMake(CGRectGetMaxX(passwordLabel.frame), 0, SCREEN_Width * 0.5, 44);
    passwordTextField.backgroundColor = [UIColor whiteColor];
    passwordTextField.textAlignment = NSTextAlignmentCenter;
    passwordTextField.delegate = self;
    [passwordView addSubview:passwordTextField];
    self.passwordTextField = passwordTextField;
    
    //再次输入支付密码
    UIView *repeatPasswordView = [[UIView alloc] init];
    repeatPasswordView.backgroundColor = [UIColor whiteColor];
    repeatPasswordView.frame = CGRectMake(0,CGRectGetMaxY(passwordView.frame), SCREEN_Width, 44);
    [self.view addSubview:repeatPasswordView];
    
    UILabel *repeatPasswordLabel = [[UILabel alloc] init];
    repeatPasswordLabel.text = @"确认新密码";
    repeatPasswordLabel.frame = CGRectMake(10, 0, 100, 44);
    [repeatPasswordView addSubview:repeatPasswordLabel];
    
    UITextField *repeatPasswordTextField = [[UITextField alloc] init];
    repeatPasswordTextField.delegate = self;
    repeatPasswordTextField.secureTextEntry = YES;

    repeatPasswordTextField.tintColor = AppMainColor;
    repeatPasswordTextField.placeholder = @"请再输入新密码";
    repeatPasswordTextField.frame = CGRectMake(CGRectGetMaxX(passwordLabel.frame), 0, SCREEN_Width * 0.5, 44);
    repeatPasswordTextField.backgroundColor = [UIColor whiteColor];
    repeatPasswordTextField.textAlignment = NSTextAlignmentCenter;
    [repeatPasswordView addSubview:repeatPasswordTextField];
    self.repeatPasswordTextField = repeatPasswordTextField;
    
    UILabel *tipLabel = [[UILabel alloc] init];
    tipLabel.text = @"为了保证支付安全，请牢记您的支付密码";
    tipLabel.font = [UIFont systemFontOfSize:14];
    tipLabel.textColor = AppMainColor;
    tipLabel.frame = CGRectMake(10, CGRectGetMaxY(repeatPasswordView.frame)+5, SCREEN_Width, 20);
    [self.view addSubview:tipLabel];

    //确定按钮
    UIButton *sureBtn = [[UIButton alloc] init];
    sureBtn.backgroundColor = AppGreenBtnColor;
    sureBtn.layer.cornerRadius = 5;
    [sureBtn setTitle:@"确定" forState:UIControlStateNormal];
    [sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    sureBtn.frame = CGRectMake(10, CGRectGetMaxY(tipLabel.frame) + 10, SCREEN_Width - 20, 50);
    [sureBtn addTarget:self action:@selector(sureBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sureBtn];

}
- (void)sureBtnClicked:(UIButton *)button
{
    if ([self.passwordTextField.text isEqualToString:@""]) {
        [[Toast makeText:@"设置密码不能为空"] show];
        return;
    }
    if ([self.repeatPasswordTextField.text isEqualToString:@""]) {
        [[Toast makeText:@"确认密码不能为空"] show];
        return;
    }
    if (![self.passwordTextField.text isEqualToString:self.repeatPasswordTextField.text]) {
        [[Toast makeText:@"两次密码输入不一致"] show];
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
    
    UserAccount *account = [UserAccountTool account];
    [RTHttpTool post:POST_SET_CUSTOMER_PAY_PASSWORD addHUD:NO param:@{USERID:account.userId,TOKEN:account.loginToken,@"payPassword":self.repeatPasswordTextField.text} success:^(id responseObj) {
        if ([responseObj[SUCCESS] intValue] == 1) {
            
            UserAccount *account = [UserAccountTool account];
            account.payPassword = self.passwordTextField.text;
            [UserAccountTool saveWithAccount:account];
            
            [[Toast makeText:@"密码修改成功"] show];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.navigationController popToViewController:self.backVC animated:YES];
            });
        }else{
            [[Toast makeText:responseObj[MESSAGE]] show];
        }
    } failure:^(NSError *error) {
        
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - uitextfielddelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    return [RTHttpTool validateNumber:string textField:textField limitString:kAlphaNum];
}
@end
