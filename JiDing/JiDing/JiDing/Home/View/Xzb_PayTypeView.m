//
//  Xzb_PayTypeView.m
//  xzb
//
//  Created by 张荣廷 on 16/8/10.
//  Copyright © 2016年 xuwk. All rights reserved.
//

#import "Xzb_PayTypeView.h"

#define SELF_HEIGHT 213
#define BTN_HEIGHT 50
//#define MARGIN 2
@implementation Xzb_PayTypeView
-(UIView*)topView{
    
    return [[[UIApplication sharedApplication] delegate] window];
}
- (void)show
{
    self.frame = CGRectMake(0, SCREEN_Height, SCREEN_Width, SELF_HEIGHT);
    [[self topView] addSubview:self];
    //添加遮盖
    UIButton *cover = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, SCREEN_Height)];
    
    cover.backgroundColor = [UIColor blackColor];
    cover.alpha = 0;
    [cover addTarget:self action:@selector(coverClick) forControlEvents:UIControlEventTouchUpInside];
    self.cover = cover;
    
    [[self topView] insertSubview:cover belowSubview:self];
    [UIView animateWithDuration:0.25 animations:^{
        cover.alpha = 0.6;
        self.frame = CGRectMake(0, SCREEN_Height - SELF_HEIGHT, SCREEN_Width, SELF_HEIGHT);
    }];
}
- (void)coverClick
{
    [UIView animateWithDuration:0.25 animations:^{
        self.frame = CGRectMake(0, SCREEN_Height, SCREEN_Width, SELF_HEIGHT);
        self.cover.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        [self.cover removeFromSuperview];
    }];
    
}
- (instancetype)init
{
    if (self = [super init]) {
        self.backgroundColor = Color(246, 241, 240);
        
        UIButton *payButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, BTN_HEIGHT)];
        [payButton setTitle:@"余额支付" forState:UIControlStateNormal];
        payButton.backgroundColor = [UIColor whiteColor];
        [payButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [payButton setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
        payButton.frame = CGRectMake(0, 0, SCREEN_Width, BTN_HEIGHT);
        [payButton addTarget:self action:@selector(balanceClick) forControlEvents:UIControlEventTouchUpInside];
        payButton.hidden = YES;
        [self addSubview:payButton];
        self.buttonZero = payButton;
        
        UIButton *weixin = [[UIButton alloc] init];
        [weixin setTitle:@"拍照" forState:UIControlStateNormal];
        weixin.backgroundColor = [UIColor whiteColor];
        [weixin setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [weixin setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
        weixin.frame = CGRectMake(0, BTN_HEIGHT + 2, SCREEN_Width, BTN_HEIGHT);
        [weixin addTarget:self action:@selector(weixinBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:weixin];
        self.buttonOne = weixin;
        
        
        UIButton *zhifubao = [[UIButton alloc] init];
        zhifubao.backgroundColor = [UIColor whiteColor];
        [zhifubao setTitle:@"相册" forState:UIControlStateNormal];
        [zhifubao setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [zhifubao setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
        zhifubao.frame = CGRectMake(0, 2 * (BTN_HEIGHT + 2), SCREEN_Width, BTN_HEIGHT);
        [zhifubao addTarget:self action:@selector(zhifubaoBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:zhifubao];
        self.buttonTwo = zhifubao;
        
        UIButton *cancle = [[UIButton alloc] init];
        cancle.backgroundColor = [UIColor whiteColor];
        [cancle setTitle:@"取消" forState:UIControlStateNormal];
        [cancle setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        cancle.frame = CGRectMake(0, SELF_HEIGHT - BTN_HEIGHT, SCREEN_Width, BTN_HEIGHT);
        [cancle addTarget:self action:@selector(cancleBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:cancle];
        self.cancle = cancle;
    }
    return self;
}
- (void)weixinBtnClick
{
    if (self.PhotoOption) {
        self.PhotoOption();
    }
}
- (void)zhifubaoBtnClick
{
    if (self.LibraryOption) {
        self.LibraryOption();
    }
}
- (void)cancleBtnClick
{
    [self coverClick];
}

- (void)balanceClick {
    if (self.balancePay) {
        self.balancePay();
    }
}
@end
