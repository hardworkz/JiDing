//
//  Xzb_AddPayPasswordWithPhoneController.m
//  xzb
//
//  Created by 张荣廷 on 16/9/7.
//  Copyright © 2016年 xuwk. All rights reserved.
//

#import "Xzb_AddPayPasswordWithPhoneController.h"

@interface Xzb_AddPayPasswordWithPhoneController ()<UITextFieldDelegate>
@property (nonatomic,weak)  UITextField *phoneTextField;
@property (nonatomic,weak)  UITextField *verifyCodeTextField;
@property (nonatomic,weak)  Xzb_CountDownButton *reGetCodeBtn;
@end

@implementation Xzb_AddPayPasswordWithPhoneController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = self.titleStr;
    
    //输入手机号码
    UIView *phoneView = [[UIView alloc] init];
    phoneView.backgroundColor = [UIColor whiteColor];
    phoneView.frame = CGRectMake(0,20, SCREEN_Width, 44);
    [self.view addSubview:phoneView];
    
    UIView *devider = [[UIView alloc] init];
    devider.backgroundColor = AppLineColor;
    devider.frame = CGRectMake(10, CGRectGetMaxY(phoneView.frame) - 0.5, SCREEN_Width, 0.5);
    [phoneView addSubview:devider];
    
    UILabel *phoneLabel = [[UILabel alloc] init];
    phoneLabel.text = @"手机号";
    phoneLabel.frame = CGRectMake(10, 0, 60, 44);
    [phoneView addSubview:phoneLabel];
    
    UserAccount *account = [UserAccountTool account];
    
    UITextField *phoneTextField = [[UITextField alloc] init];
    phoneTextField.keyboardType = UIKeyboardTypePhonePad;
    phoneTextField.delegate = self;
    phoneTextField.tintColor = AppMainColor;
    phoneTextField.text = account.mobile;
    phoneTextField.enabled = NO;
    phoneTextField.frame = CGRectMake(CGRectGetMaxX(phoneLabel.frame), 0, SCREEN_Width * 0.5, 44);
    phoneTextField.backgroundColor = [UIColor whiteColor];
    phoneTextField.textAlignment = NSTextAlignmentCenter;
    [phoneView addSubview:phoneTextField];
    self.phoneTextField = phoneTextField;
    
    //获取验证码
    Xzb_CountDownButton *reGetCodeBtn = [[Xzb_CountDownButton alloc] init];
    reGetCodeBtn.frame = CGRectMake(SCREEN_Width - 110, 0,100, 44);
    [reGetCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [reGetCodeBtn setTitleColor:AppGreenBtnColor forState:UIControlStateNormal];
    reGetCodeBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [reGetCodeBtn addTarget:self action:@selector(reGetCodeBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    reGetCodeBtn.index = 60;
    [phoneView addSubview:reGetCodeBtn];
    self.reGetCodeBtn = reGetCodeBtn;
    
    //短信验证码
    UIView *verifyCodeView = [[UIView alloc] init];
    verifyCodeView.backgroundColor = [UIColor whiteColor];
    verifyCodeView.frame = CGRectMake(0,CGRectGetMaxY(phoneView.frame), SCREEN_Width, 44);
    [self.view addSubview:verifyCodeView];
    
    UILabel *verifyCodeLabel = [[UILabel alloc] init];
    verifyCodeLabel.text = @"验证码";
    verifyCodeLabel.frame = CGRectMake(10, 0, 60, 44);
    [verifyCodeView addSubview:verifyCodeLabel];
    
    UITextField *verifyCodeTextField = [[UITextField alloc] init];
    verifyCodeTextField.keyboardType = UIKeyboardTypePhonePad;
    verifyCodeTextField.delegate = self;
    verifyCodeTextField.tintColor = AppMainColor;
    verifyCodeTextField.placeholder = @"请输入验证码";
    verifyCodeTextField.frame = CGRectMake(CGRectGetMaxX(verifyCodeLabel.frame), 0, SCREEN_Width * 0.5, 44);
    verifyCodeTextField.backgroundColor = [UIColor whiteColor];
    verifyCodeTextField.textAlignment = NSTextAlignmentCenter;
    [verifyCodeView addSubview:verifyCodeTextField];
    self.verifyCodeTextField = verifyCodeTextField;

    //下一步按钮
    UIButton *nextBtn = [[UIButton alloc] init];
    nextBtn.backgroundColor = AppGreenBtnColor;
    nextBtn.layer.cornerRadius = 5;
    [nextBtn setTitle:@"下一步" forState:UIControlStateNormal];
    [nextBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    nextBtn.frame = CGRectMake(10, CGRectGetMaxY(verifyCodeView.frame) + 30, SCREEN_Width - 20, 50);
    [nextBtn addTarget:self action:@selector(nextBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nextBtn];

}
/**
 *  下一步
 */
- (void)nextBtnClicked:(UIButton *)button
{
    if ([self.phoneTextField.text isEqualToString:@""]) {
        [[Toast makeText:@"请输入手机号"] show];
        return;
    }
    if ([self.verifyCodeTextField.text isEqualToString:@""]) {
        [[Toast makeText:@"请输入验证码"] show];
        return;
    }
    [RTHttpTool get:GET_CHECK_VERIFY_CODE addHUD:NO param:@{PHONE_CODE:self.phoneTextField.text,VERIFY_CODE:self.verifyCodeTextField.text} success:^(id responseObj) {
        if ([responseObj[SUCCESS] intValue] == 1) {
            Xzb_AddPayPasswordController *addPayPwdVC = [[Xzb_AddPayPasswordController alloc] init];
            addPayPwdVC.backVC = self.backVC;
            addPayPwdVC.view.backgroundColor = AppMainBgColor;
            [self.navigationController pushViewController:addPayPwdVC animated:YES];
        }else
        {
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
    if (self.phoneTextField.text.length != 11) {
        [[Toast makeText:@"请输入正确手机号"] show];
        return;
    }
    NSString *openUDID = @"";
    
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
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
