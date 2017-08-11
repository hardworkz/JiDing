//
//  Xzb_AccountSetNewPwdController.m
//  xzb
//
//  Created by 张荣廷 on 16/9/13.
//  Copyright © 2016年 xuwk. All rights reserved.
//

#import "Xzb_AccountSetNewPwdController.h"

@interface Xzb_AccountSetNewPwdController ()<UITextFieldDelegate>
@property (nonatomic,weak)  UITextField *phoneTextField;
@property (nonatomic,weak)  UITextField *verifyCodeTextField;
@property (nonatomic,weak)  Xzb_CountDownButton *reGetCodeBtn;
@property (nonatomic,weak)  UITextField *newsPasswordTextField;
@end

@implementation Xzb_AccountSetNewPwdController

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置导航栏标题
    self.title = @"修改登录密码";
    
    //自定义返回按钮
    UIImage * imgOn = [UIImage imageNamed:@"返回"];
    UIImage * imgOff = [UIImage imageNamed:@"返回"];
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    CGSize size = CGSizeMake(25, 25);
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    btn.contentEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
    btn.frame = rect;
    [btn setImage:imgOn forState:UIControlStateNormal];
    [btn setImage:imgOff forState:UIControlStateHighlighted];
    [btn addTarget:self action:@selector(back_clicked) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * barItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    barItem.accessibilityLabel = @"返回";
    self.navigationItem.leftBarButtonItem = barItem;

    //输入手机号码
    UIView *phoneView = [[UIView alloc] init];
    phoneView.backgroundColor = [UIColor whiteColor];
    phoneView.frame = CGRectMake(0,10, SCREEN_Width, 44);
    [self.view addSubview:phoneView];
    
    UserAccount *account = [UserAccountTool account];
    
    UITextField *phoneTextField = [[UITextField alloc] init];
    phoneTextField.keyboardType = UIKeyboardTypePhonePad;
    phoneTextField.delegate = self;
    phoneTextField.tintColor = AppMainColor;
    phoneTextField.text = account.mobile;
    phoneTextField.frame = CGRectMake(10, 0, SCREEN_Width * 0.5, 44);
    phoneTextField.enabled = NO;
    phoneTextField.backgroundColor = [UIColor whiteColor];
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
    [verifyCodeView addSubview:verifyCodeTextField];
    self.verifyCodeTextField = verifyCodeTextField;
    
    //新密码
    UIView *newPasswordView = [[UIView alloc] init];
    newPasswordView.backgroundColor = [UIColor whiteColor];
    newPasswordView.frame = CGRectMake(0,CGRectGetMaxY(verifyCodeView.frame)+10, SCREEN_Width, 44);
    [self.view addSubview:newPasswordView];
    
    UITextField *newPasswordTextField = [[UITextField alloc] init];
    newPasswordTextField.delegate = self;
    newPasswordTextField.tintColor = AppMainColor;
    newPasswordTextField.placeholder = @"请输入新密码";
    newPasswordTextField.frame = CGRectMake(10, 0, SCREEN_Width * 0.5, 44);
    newPasswordTextField.secureTextEntry = YES;
    newPasswordTextField.backgroundColor = [UIColor whiteColor];
    [newPasswordView addSubview:newPasswordTextField];
    self.newsPasswordTextField = newPasswordTextField;
    
    //下一步按钮
    UIButton *commitBtn = [[UIButton alloc] init];
    commitBtn.backgroundColor = AppGreenBtnColor;
    commitBtn.layer.cornerRadius = 5;
    [commitBtn setTitle:@"提交" forState:UIControlStateNormal];
    [commitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    commitBtn.frame = CGRectMake(10, CGRectGetMaxY(newPasswordView.frame) + 20, SCREEN_Width - 20, 50);
    [commitBtn addTarget:self action:@selector(commitBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:commitBtn];
    
}
- (void)back_clicked
{
    [self.navigationController popViewControllerAnimated:YES];
}
/**
 *  提交
 */
- (void)commitBtnClicked:(UIButton *)button
{
    if ([self.phoneTextField.text isEqualToString:@""]) {
        [[Toast makeText:@"手机号不能为空"] show];
        return;
    }
    if ([self.verifyCodeTextField.text isEqualToString:@""]) {
        [[Toast makeText:@"短信验证码不能为空"] show];
        return;
    }
    if ([self.newsPasswordTextField.text isEqualToString:@""]) {
        [[Toast makeText:@"新密码不能为空"] show];
        return;
    }
    if (self.newsPasswordTextField.text.length <6) {
        [[Toast makeText:@"新密码不能为小于6位"] show];
        return;
    }
    if (self.newsPasswordTextField.text.length >20) {
        [[Toast makeText:@"新密码不能为大于20位"] show];
        return;
    }
    
    UserAccount *account = [UserAccountTool account];
    [RTHttpTool post:POST_UPDATE_CUSTOMER_PASSWORD addHUD:NO param:@{USERID:account.userId,TOKEN:account.loginToken,PHONE_CODE:self.phoneTextField.text,VERIFY_CODE:self.verifyCodeTextField.text,@"password":self.newsPasswordTextField.text} success:^(id responseObj) {
        if ([responseObj[SUCCESS] intValue] == 1) {
            [[Toast makeText:@"密码修改成功"] show];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.navigationController popViewControllerAnimated:YES];
            });
        }else{
            [[Toast makeText:responseObj[MESSAGE]] show];
        }
    } failure:^(NSError *error) {
        
    }];
    
}
/**
 *  重新获取验证码
 */
- (void)reGetCodeBtnClicked
{
    if ([self.phoneTextField.text isEqualToString:@""]) {
        [[Toast makeText:@"手机号不能为空"] show];
        return;
    }
    if (self.phoneTextField.text.length != 11) {
        [[Toast makeText:@"请输入正确的手机号码"] show];
        return;
    }
    NSString *openUDID = [OpenUDID value];
    
    [RTHttpTool get:GET_VERIFY_PHONE addHUD:NO param:@{@"phoneCode":self.phoneTextField.text,@"equipmentCode":openUDID} success:^(id responseObj) {
        if ([responseObj[SUCCESS] intValue] == 1) {
            [self.reGetCodeBtn attAction];
        }else
        {
            [[Toast makeText:responseObj[MESSAGE]] show];
        }
    } failure:^(NSError *error) {
        
    }];
}
#pragma mark - uitextfielddelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    return [RTHttpTool validateNumber:string textField:textField limitString:kAlphaNum];
}
@end
