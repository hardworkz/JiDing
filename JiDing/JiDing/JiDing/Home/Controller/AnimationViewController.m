//
//  AnimationViewController.m
//  JiDing
//
//  Created by 泡果 on 2017/7/17.
//  Copyright © 2017年 zhangrongting. All rights reserved.
//

#import "AnimationViewController.h"


@interface AnimationViewController ()<CAAnimationDelegate,UINavigationControllerDelegate>

/**
 *  当前选择的首页类型，默认为酒店
 */
@property (assign, nonatomic) SelectedHomeType homeType;
@property (strong, nonatomic) UIView *screenView;
@property (strong, nonatomic) UIView *screenView_window;

@property (strong, nonatomic) UIView *topView;
@property (strong, nonatomic) UIView *centerLineView;
@property (strong, nonatomic) UIView *bottomView;

@property (strong, nonatomic) UIButton *hotelBtn;
@property (strong, nonatomic) UIButton *KTVBtn;

@property (strong, nonatomic) UIView *topView_window;
@property (strong, nonatomic) UIView *centerLineView_window;
@property (strong, nonatomic) UIView *bottomView_window;

@property (strong, nonatomic) UIButton *hotelBtn_window;
@property (strong, nonatomic) UIButton *KTVBtn_window;
/*
 * 开合动画完成
 */
@property (assign, nonatomic) BOOL isCompleteAnimation;
@end

@implementation AnimationViewController
#pragma mark - 首页开合控件_window
- (UIView *)screenView_window
{
    if (_screenView_window == nil) {
        _screenView_window = [[UIView alloc] initWithFrame:[self windowView].bounds];
        _screenView_window.backgroundColor = [UIColor clearColor];
        
        [_screenView_window addSubview:self.topView_window];
        [_screenView_window addSubview:self.centerLineView_window];
        [_screenView_window addSubview:self.bottomView_window];
    }
    return _screenView_window;
}
- (UIView *)topView_window
{
    if (_topView_window == nil) {
        _topView_window = [[UIView alloc] initWithFrame:CGRectMake(0, 0, IPHONE_W, IPHONE_H * 0.5 - 0.5)];
        _topView_window.backgroundColor = [UIColor whiteColor];
        
        [_topView_window addSubview:self.hotelBtn_window];
        
        UILabel *hotelLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.hotelBtn_window.x, CGRectGetMaxY(self.hotelBtn_window.frame) - 10, self.hotelBtn_window.width, 20)];
        hotelLabel.text = @"酒店";
        hotelLabel.textAlignment = NSTextAlignmentCenter;
        hotelLabel.textColor = AppDeepGrayTextColor;
        [hotelLabel setAppFontWithSize:16.0f];
        [_topView_window addSubview:hotelLabel];
    }
    return _topView_window;
}
- (UIView *)centerLineView_window
{
    if (_centerLineView_window == nil) {
        _centerLineView_window = [[UIView alloc] initWithFrame:CGRectMake(30, SCREEN_HEIGHT * 0.5 - 0.5, SCREEN_WIDTH - 60, 1)];
        _centerLineView_window.backgroundColor = AppLineColor;
    }
    return _centerLineView_window;
}
- (UIView *)bottomView_window
{
    if (_bottomView_window == nil) {
        _bottomView_window = [[UIView alloc] initWithFrame:CGRectMake(0, IPHONE_H *0.5 + 0.5, IPHONE_W, IPHONE_H * 0.5 - 0.5)];
        _bottomView_window.backgroundColor = [UIColor whiteColor];
        
        UIButton *setting = [[UIButton alloc] initWithFrame:CGRectMake(15, SCREEN_HEIGHT * 0.5 - 70, 50, 50)];
        [setting addTarget:self action:@selector(setting)];
        [setting setImage:@"设置"];
        setting.accessibilityLabel = @"设置";
        [_bottomView_window addSubview:setting];
        
        UIButton *userCenter = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 65, SCREEN_HEIGHT * 0.5 - 70, 50, 50)];
        [userCenter addTarget:self action:@selector(userCenter)];
        [userCenter setImage:@"个人"];
        userCenter.accessibilityLabel = @"个人";
        [_bottomView_window addSubview:userCenter];
        
        [_bottomView_window addSubview:self.KTVBtn_window];
        
        UILabel *ktvLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.KTVBtn_window.x, CGRectGetMaxY(self.KTVBtn_window.frame) - 10, self.KTVBtn_window.width, 20)];
        ktvLabel.text = @"KTV";
        ktvLabel.textAlignment = NSTextAlignmentCenter;
        ktvLabel.textColor = AppDeepGrayTextColor;
        [ktvLabel setAppFontWithSize:16.0f];
        [_bottomView_window addSubview:ktvLabel];
    }
    return _bottomView_window;
}
- (UIButton *)hotelBtn_window
{
    if (_hotelBtn_window == nil) {
        _hotelBtn_window = [[UIButton alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 100) * 0.5, (SCREEN_HEIGHT *0.5 - 100) * 0.5 + 20, 100, 100)];
        [_hotelBtn_window setImage:@"首页"];
        [_hotelBtn_window addTarget:self action:@selector(select_hotel)];
    }
    return _hotelBtn_window;
}
- (UIButton *)KTVBtn_window
{
    if (_KTVBtn_window == nil) {
        _KTVBtn_window = [[UIButton alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 100) * 0.5, (SCREEN_HEIGHT *0.5 - 100) * 0.5 - 20, 100, 100)];
        [_KTVBtn_window setImage:@"KTV"];
        [_KTVBtn_window addTarget:self action:@selector(select_ktv)];
    }
    return _KTVBtn_window;
}

#pragma mark - 首页动画控制器控件
- (UIView *)screenView
{
    if (_screenView == nil) {
        _screenView = [[UIView alloc] initWithFrame:[self windowView].bounds];
        _screenView.backgroundColor = [UIColor whiteColor];
        
        [_screenView addSubview:self.topView];
        [_screenView addSubview:self.centerLineView];
        [_screenView addSubview:self.bottomView];
    }
    return _screenView;
}
- (UIView *)topView
{
    if (_topView == nil) {
        _topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, IPHONE_W, IPHONE_H * 0.5 - 0.5)];
        _topView.backgroundColor = [UIColor clearColor];
        
        [_topView addSubview:self.hotelBtn];
        
        UILabel *hotelLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.hotelBtn.x, CGRectGetMaxY(self.hotelBtn.frame) - 10, self.hotelBtn.width, 20)];
        hotelLabel.text = @"酒店";
        hotelLabel.textAlignment = NSTextAlignmentCenter;
        hotelLabel.textColor = AppDeepGrayTextColor;
        [hotelLabel setAppFontWithSize:16.0f];
        [_topView addSubview:hotelLabel];
    }
    return _topView;
}

- (UIView *)centerLineView
{
    if (_centerLineView == nil) {
        _centerLineView = [[UIView alloc] initWithFrame:CGRectMake(30, SCREEN_HEIGHT * 0.5 - 0.5, SCREEN_WIDTH - 60, 1)];
        _centerLineView.backgroundColor = AppLineColor;
    }
    return _centerLineView;
}
- (UIView *)bottomView
{
    if (_bottomView == nil) {
        _bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, IPHONE_H *0.5 + 0.5, IPHONE_W, IPHONE_H * 0.5 - 0.5)];
        _bottomView.backgroundColor = [UIColor clearColor];
        
        UIButton *setting = [[UIButton alloc] initWithFrame:CGRectMake(15, SCREEN_HEIGHT * 0.5 - 70, 50, 50)];
        [setting addTarget:self action:@selector(setting)];
        [setting setImage:@"设置"];
        setting.accessibilityLabel = @"设置";
        [_bottomView addSubview:setting];
        
        UIButton *userCenter = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 65, SCREEN_HEIGHT * 0.5 - 70, 50, 50)];
        [userCenter addTarget:self action:@selector(userCenter)];
        [userCenter setImage:@"个人"];
        userCenter.accessibilityLabel = @"个人";
        [_bottomView addSubview:userCenter];
        
        [_bottomView addSubview:self.KTVBtn];
        
        UILabel *ktvLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.KTVBtn.x, CGRectGetMaxY(self.KTVBtn.frame) - 10, self.KTVBtn.width, 20)];
        ktvLabel.text = @"KTV";
        ktvLabel.textAlignment = NSTextAlignmentCenter;
        ktvLabel.textColor = AppDeepGrayTextColor;
        [ktvLabel setAppFontWithSize:16.0f];
        [_bottomView addSubview:ktvLabel];
    }
    return _bottomView;
}
- (UIButton *)hotelBtn
{
    if (_hotelBtn == nil) {
        _hotelBtn = [[UIButton alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 100) * 0.5, (SCREEN_HEIGHT *0.5 - 100) * 0.5 + 20, 100, 100)];
        [_hotelBtn setImage:@"首页"];
        [_hotelBtn addTarget:self action:@selector(select_hotel)];
    }
    return _hotelBtn;
}
- (UIButton *)KTVBtn
{
    if (_KTVBtn == nil) {
        _KTVBtn = [[UIButton alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 100) * 0.5, (SCREEN_HEIGHT *0.5 - 100) * 0.5 - 20, 100, 100)];
        [_KTVBtn setImage:@"KTV"];
        [_KTVBtn addTarget:self action:@selector(select_ktv)];
    }
    return _KTVBtn;
}
#pragma mark - viewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.screenView];
    
    self.homeType = SelectedHomeTypeHotel;
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}
-(UIView *)windowView
{
    return [[[UIApplication sharedApplication] delegate] window];
}
#pragma mark - 首页开合动画
- (void)animationOpen:(void(^)())completionAnimation
{
    self.isCompleteAnimation = NO;
    DefineWeakSelf;
    weakSelf.centerLineView_window.hidden = YES;
    [UIView animateWithDuration:1.25 // 动画时长
                          delay:0.0 // 动画延迟
         usingSpringWithDamping:0.9 // 弹簧振动效果 0~1
          initialSpringVelocity:1.0 // 初始速度
                        options:UIViewAnimationOptionCurveEaseIn // 动画过渡效果
                     animations:^{
                         weakSelf.topView_window.frame = CGRectMake(0, -IPHONE_H * 0.5, IPHONE_W, IPHONE_H * 0.5 - 0.5);
                         weakSelf.bottomView_window.frame = CGRectMake(0, IPHONE_H, IPHONE_W, IPHONE_H * 0.5 - 0.5);
                     } completion:^(BOOL finished) {
                         
                         [weakSelf.screenView_window removeFromSuperview];
                         
                         self.isCompleteAnimation = YES;
                         if (completionAnimation) {
                             completionAnimation();
                         }
                     }];
}
- (void)animationClose:(void(^)())completionAnimation
{
    
    [[self windowView] addSubview:self.screenView_window];
    
    self.isCompleteAnimation = NO;
    DefineWeakSelf;
    [UIView animateWithDuration:1.25 // 动画时长
                          delay:0.0 // 动画延迟
         usingSpringWithDamping:1.0 // 弹簧振动效果 0~1
          initialSpringVelocity:1.0 // 初始速度
                        options:UIViewAnimationOptionCurveEaseIn // 动画过渡效果
                     animations:^{
                         weakSelf.topView_window.frame = CGRectMake(0, 0, IPHONE_W, IPHONE_H * 0.5 - 0.5);
                         weakSelf.bottomView_window.frame = CGRectMake(0, IPHONE_H *0.5 + 0.5, IPHONE_W, IPHONE_H * 0.5 - 0.5);
                     } completion:^(BOOL finished) {
                         // 动画完成后执行
                         [weakSelf.screenView_window removeFromSuperview];
                         weakSelf.centerLineView_window.hidden = NO;
                         weakSelf.isCompleteAnimation = YES;
                         if (completionAnimation) {
                             completionAnimation();
                         }
                     }];
}
#pragma mark - action
- (void)select_hotel
{
    [[self windowView] addSubview:self.screenView_window];
    
    HomeViewController *homeVC = [[HomeViewController alloc] init];
    homeVC.animationVC = self;
    homeVC.homeType = SelectedHomeTypeHotel;
    [self.navigationController pushViewController:homeVC animated:NO];
    [self animationOpen:nil];
}
- (void)select_ktv
{
    [[self windowView] addSubview:self.screenView_window];
    
    HomeViewController *homeVC = [[HomeViewController alloc] init];
    homeVC.animationVC = self;
    homeVC.homeType = SelectedHomeTypeHotel;
    [self.navigationController pushViewController:homeVC animated:NO];
    [self animationOpen:nil];
}
/*
 * 跳转设置动画
 */
- (void)setting
{
    SettingViewController *settingVC = [[SettingViewController alloc] init];
    RootNavigationController *navVC = [[RootNavigationController alloc] initWithRootViewController:settingVC];
    [self presentViewController:navVC animated:YES completion:nil];
}
/*
 * 跳转用户中心动画
 */
- (void)userCenter
{
    UserCenterViewController *userCenterVC = [[UserCenterViewController alloc] init];
    RootNavigationController *navVC = [[RootNavigationController alloc] initWithRootViewController:userCenterVC];
    [self presentViewController:navVC animated:YES completion:nil];
}
@end
