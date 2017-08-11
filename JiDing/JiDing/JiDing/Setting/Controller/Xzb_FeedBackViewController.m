//
//  Xzb_FeedBackViewController.m
//  xzb
//
//  Created by 张荣廷 on 16/5/29.
//  Copyright © 2016年 xuwk. All rights reserved.
//

#import "Xzb_FeedBackViewController.h"

@interface Xzb_FeedBackViewController ()<UITextViewDelegate>
@property (nonatomic,weak)  IWTextView *textView;
@end

@implementation Xzb_FeedBackViewController
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.textView becomeFirstResponder];
    });
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"意见反馈";
    
    UIButton *rightButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60, 40)];
    [rightButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(commitItemClicked) forControlEvents:UIControlEventTouchUpInside];
    rightButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [rightButton setTitle:@"提交" forState:UIControlStateNormal];
    UIBarButtonItem *commitItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = commitItem;
    
    IWTextView *textView = [[IWTextView alloc] initWithFrame:CGRectMake(10, 10, SCREEN_Width - 20, 200)];
    textView.placeholder = @"请描述你的问题/建议";
    textView.delegate = self;
    textView.font = [UIFont systemFontOfSize:15];
    textView.returnKeyType = UIReturnKeyDone;
    textView.placeholderColor = [UIColor lightGrayColor];
    textView.placeholderLabel.font = [UIFont systemFontOfSize:15];
    self.automaticallyAdjustsScrollViewInsets = NO;
    textView.tintColor = AppMainColor;
    [self.view addSubview:textView];
    self.textView = textView;
}
- (void)commitItemClicked//提交反馈
{
    if ([self.textView.text isEqualToString:@""]) {
        [[Toast makeText:@"请先输入您的宝贵意见~"] show];
        return;
    }
    
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[@"CFBundleShortVersionString"];
    
    UserAccount *account = [UserAccountTool account];
    [RTHttpTool post:ADVICE_INFO addHUD:YES param:@{@"appType":@"client",@"adverContent":self.textView.text,@"adverUserTel":account.mobile,@"adverUserName":account.username,@"version":currentVersion} success:^(id responseObj) {
        if ([responseObj[SUCCESS] intValue] == 1) {
            [[Toast makeText:responseObj[MESSAGE]] show];
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            
            [[Toast makeText:responseObj[MESSAGE]] show];
        }
    } failure:^(NSError *error) {
        
    }];
}
- (void)back_clicked
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@"\n"]){ //判断输入的字是否是回车，即按下return
        //在这里做你响应return键的代码
        [textView resignFirstResponder];
        return NO; //这里返回NO，就代表return键值失效，即页面上按下return，不会出现换行，如果为yes，则输入页面会换行
    }
    if ([[[UITextInputMode currentInputMode] primaryLanguage] isEqualToString:@"emoji"]) {
        return NO;
    }else
    {
        return YES;
    }
}
@end
