//
//  HomeViewController.m
//  JiDing
//
//  Created by 泡果 on 2017/5/26.
//  Copyright © 2017年 zhangrongting. All rights reserved.
//

#import "HomeViewController.h"

@interface HomeViewController ()
@property (strong, nonatomic) UIView *screenView;

@property (strong, nonatomic) UIView *topView;
@property (strong, nonatomic) UIView *bottomView;

@property (strong, nonatomic) UIButton *hotelBtn;
@property (strong, nonatomic) UIButton *KTVBtn;
/*
 * 开合动画完成
 */
@property (assign, nonatomic) BOOL isCompleteAnimation;
/*
 * 展开类型动画完成
 */
@property (assign, nonatomic) BOOL isCompleteTypeAnimation;

@property (strong, nonatomic) NSMutableArray *typeArray;
@property (strong, nonatomic) NSMutableArray *roomTypeArray;
/*
 * 选中类型frame保持全局
 */
@property (assign, nonatomic) CGRect selectedTypeVF;
@property (assign, nonatomic) CGRect selectedImageViewVF;
@property (assign, nonatomic) CGRect selectedTypeLabelVF;
@end

@implementation HomeViewController
#pragma mark - 懒加载
- (NSMutableArray *)typeArray
{
    if (_typeArray == nil) {
        _typeArray = [NSMutableArray array];
    }
    return _typeArray;
}
- (NSMutableArray *)roomTypeArray
{
    if (_roomTypeArray == nil) {
        _roomTypeArray = [NSMutableArray array];
    }
    return _roomTypeArray;
}
#pragma mark - 首页开合控件
- (UIView *)screenView
{
    if (_screenView == nil) {
        _screenView = [[UIView alloc] initWithFrame:[self windowView].bounds];
        _screenView.backgroundColor = [UIColor clearColor];
        
        [_screenView addSubview:self.topView];
        [_screenView addSubview:self.bottomView];
    }
    return _screenView;
}
- (UIView *)topView
{
    if (_topView == nil) {
        _topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, IPHONE_W, IPHONE_H * 0.5)];
        _topView.backgroundColor = [UIColor whiteColor];
        
        UIView *devider = [[UIView alloc] initWithFrame:CGRectMake(0, IPHONE_H *0.5 - 0.5, IPHONE_W, 0.5)];
        devider.backgroundColor = [UIColor grayColor];
        [_topView addSubview:devider];
        
        [_topView addSubview:self.hotelBtn];
    }
    return _topView;
}
- (UIView *)bottomView
{
    if (_bottomView == nil) {
        _bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, IPHONE_H *0.5, IPHONE_W, IPHONE_H * 0.5)];
        _bottomView.backgroundColor = [UIColor whiteColor];
        
        UIView *devider = [[UIView alloc] initWithFrame:CGRectMake(0, 0, IPHONE_W, 0.5)];
        devider.backgroundColor = [UIColor grayColor];
        [_bottomView addSubview:devider];
        
        UIButton *setting = [[UIButton alloc] initWithFrame:CGRectMake(15, SCREEN_HEIGHT * 0.5 - 70, 50, 50)];
        setting.backgroundColor = [UIColor yellowColor];
        [setting addTarget:self action:@selector(setting)];
        [_bottomView addSubview:setting];
        
        UIButton *userCenter = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 65, SCREEN_HEIGHT * 0.5 - 70, 50, 50)];
        userCenter.backgroundColor = [UIColor grayColor];
        [userCenter addTarget:self action:@selector(userCenter)];
        [_bottomView addSubview:userCenter];
        
        [_bottomView addSubview:self.KTVBtn];
    }
    return _bottomView;
}
- (UIButton *)hotelBtn
{
    if (_hotelBtn == nil) {
        _hotelBtn = [[UIButton alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 100) * 0.5, (SCREEN_HEIGHT *0.5 - 100) * 0.5 + 20, 100, 100)];
        _hotelBtn.backgroundColor = [UIColor blackColor];
        [_hotelBtn addTarget:self action:@selector(select_hotel)];
    }
    return _hotelBtn;
}
- (UIButton *)KTVBtn
{
    if (_KTVBtn == nil) {
        _KTVBtn = [[UIButton alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 100) * 0.5, (SCREEN_HEIGHT *0.5 - 100) * 0.5 - 20, 100, 100)];
        _KTVBtn.backgroundColor = [UIColor redColor];
        [_KTVBtn addTarget:self action:@selector(select_ktv)];
    }
    return _KTVBtn;
}
-(UIView *)windowView
{
    return [[[UIApplication sharedApplication] delegate] window];
}
#pragma mark - 首页开合动画
- (void)animationOpen
{
    self.isCompleteAnimation = NO;
    DefineWeakSelf;
    [UIView animateWithDuration:1.0 // 动画时长
                          delay:0.0 // 动画延迟
         usingSpringWithDamping:0.9 // 弹簧振动效果 0~1
          initialSpringVelocity:1.0 // 初始速度
                        options:UIViewAnimationOptionCurveEaseIn // 动画过渡效果
                     animations:^{
                         weakSelf.topView.frame = CGRectMake(0, -IPHONE_H * 0.5, IPHONE_W, IPHONE_H * 0.5);
                         weakSelf.bottomView.frame = CGRectMake(0, IPHONE_H, IPHONE_W, IPHONE_H * 0.5);
                     } completion:^(BOOL finished) {
                         [weakSelf.screenView removeFromSuperview];
                         self.isCompleteAnimation = YES;
                     }];
}
- (void)animationClose
{
    self.isCompleteAnimation = NO;
    [[self windowView] addSubview:self.screenView];
    DefineWeakSelf;
    [UIView animateWithDuration:1.0 // 动画时长
                          delay:0.0 // 动画延迟
         usingSpringWithDamping:1.0 // 弹簧振动效果 0~1
          initialSpringVelocity:1.0 // 初始速度
                        options:UIViewAnimationOptionCurveEaseIn // 动画过渡效果
                     animations:^{
                         weakSelf.topView.frame = CGRectMake(0, 0, IPHONE_W, IPHONE_H * 0.5);
                         weakSelf.bottomView.frame = CGRectMake(0, IPHONE_H *0.5, IPHONE_W, IPHONE_H * 0.5);
                     } completion:^(BOOL finished) {
                         // 动画完成后执行
                         // code...
                         self.isCompleteAnimation = YES;
                     }];
}
#pragma mark - viewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];
    [[self windowView] addSubview:self.screenView];
    
    //设置首页控件
    [self setupHomeView];
    self.isCompleteTypeAnimation = YES;
}
- (void)actionAutoBack:(UIBarButtonItem *)barItem
{
    if (self.isCompleteAnimation) {
        [self animationClose];
    }
}
#pragma mark - action
- (void)select_hotel
{
    self.title = @"酒店";
    [self animationOpen];
}
- (void)select_ktv
{
    self.title = @"KTV";
    [self animationOpen];
}
/*
 * 选择条件完成，进入下一步
 */
- (void)next
{
    
}
/*
 * 定位当前位置，不进行界面跳转
 */
- (void)myAddressTap
{
//    self.addressContentLabel.text = @"定位中...";
//    Xzb_ApplicationData *data = [Xzb_ApplicationDataTool account];
//    data.user_x = nil;
//    data.user_y = nil;
//    data.userAddress = nil;
//    [Xzb_ApplicationDataTool saveWithAccount:data];
//    [[MyAlert make] showHUD];
//    [_CLLocationManager startUpdatingLocation];
}
/*
 * 跳转设置
 */
- (void)setting
{
    
}
/*
 * 跳转用户中心
 */
- (void)userCenter
{
    
}
/*
 * 选中类型
 */
- (void)typeTap:(UIGestureRecognizer *)gestuer
{
    UIImageView *imageView = (UIImageView *)gestuer.view;
    UIView *typeV;
    UILabel *typeLabel;
    if ([imageView.superview isKindOfClass:[UIView class]]) {
        typeV = imageView.superview;
        for (UIView *view in typeV.subviews) {
            if ([view isKindOfClass:[UILabel class]]) {
                typeLabel = (UILabel *)view;
            }
        }
    }
    if (self.isCompleteTypeAnimation) {
        self.selectedTypeVF = typeV.frame;
        self.selectedImageViewVF = imageView.frame;
        self.selectedTypeLabelVF = typeLabel.frame;
        [UIView animateWithDuration:0.75 animations:^{
            
            for (UIButton *button in self.roomTypeArray) {
                button.alpha = 1.0;
            }
            for (UIView *typeV in self.typeArray) {
                typeV.alpha = 0.0;
            }
            typeV.frame = CGRectMake(10, 0, SCREEN_WIDTH - 20, 200);
            imageView.frame = CGRectMake(imageView.x - 5, imageView.y + 30, 40, 40);
            typeLabel.frame = CGRectMake(CGRectGetMaxX(imageView.frame), imageView.y + 5, typeLabel.width, typeLabel.height);
        } completion:^(BOOL finished) {
            self.isCompleteTypeAnimation = NO;
            imageView.userInteractionEnabled = NO;
        }];
    }else{
        [UIView animateWithDuration:0.5 animations:^{
            
        } completion:^(BOOL finished) {
            
        }];
    }
    
}
#pragma mark - 人数，房间数加减action
- (void)addBtnClicked:(UIButton *)button
{
    
}
- (void)subBtnClicked:(UIButton *)button
{
    
}
#pragma mark - 设置首页的控件
- (void)setupHomeView
{
    //TODO:模块
    UIView *locationView = [self setupLocationView];
    UIView *dateView = [self setupDateView:locationView];
    UIView *numView = [self setupNumView:dateView];
    [self setupTypeView:numView];
    
    UIButton *nextBtn = [[UIButton alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 50/350*SCREEN_WIDTH) * 0.5, SCREEN_HEIGHT - 50/350*SCREEN_WIDTH - 10 - 64, 50/350*SCREEN_WIDTH, 50/350*SCREEN_WIDTH)];
    nextBtn.backgroundColor = [UIColor blueColor];
    [nextBtn setImage:@""];
    [nextBtn addTarget:self action:@selector(next)];
    [self.view addSubview:nextBtn];
}
/*
 * 定位模块
 */
- (UIView *)setupLocationView
{
    UIView *locationView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 60)];
    [self.view addSubview:locationView];
    
    UIView *devider = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.5)];
    devider.backgroundColor = AppLineColor;
    [locationView addSubview:devider];
    
    UIImageView *addressIconView = [[UIImageView alloc] init];
    addressIconView.image = [UIImage imageNamed:@"地理位置"];
    addressIconView.frame = CGRectMake(10, 15, 30, 30);
    addressIconView.contentMode = UIViewContentModeCenter;
    [locationView addSubview:addressIconView];
    
    UIView *deviderOne = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(addressIconView.frame) + 5, 15, 1, 30)];
    deviderOne.backgroundColor = AppLineColor;
    [locationView addSubview:deviderOne];
    
    UILabel *addressContentLabel = [[UILabel alloc] init];
    addressContentLabel.text = @"厦门市思明区，何厝下何300号";
    addressContentLabel.textColor = [UIColor blackColor];
    addressContentLabel.numberOfLines = 0;
    addressContentLabel.textColor = AppDeepGrayTextColor;
    [addressContentLabel setAppFontWithSize:15];
    addressContentLabel.frame = CGRectMake(CGRectGetMaxX(deviderOne.frame) + 5, 5, SCREEN_WIDTH - SCREEN_WIDTH * 0.2 - CGRectGetMaxX(addressIconView.frame) - 20 - 50, 50);
    [locationView addSubview:addressContentLabel];
    
    UIImageView *rightArrow = [[UIImageView alloc] init];
    rightArrow.image = [UIImage imageNamed:@"定位"];
    rightArrow.userInteractionEnabled = NO;
    rightArrow.frame = CGRectMake(CGRectGetMaxX(addressContentLabel.frame), 15, 30, 30);
    rightArrow.contentMode = UIViewContentModeCenter;
    [locationView addSubview:rightArrow];
    
    UIView *deviderTwo = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(rightArrow.frame) + 5, 15, 1, 30)];
    deviderTwo.backgroundColor = AppLineColor;
    [locationView addSubview:deviderTwo];
    
    UITapGestureRecognizer *myAddressTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(myAddressTap)];
    
    UITapGestureRecognizer *addressIconTwoViewTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(myAddressTap)];
    
    UILabel *myAddress = [[UILabel alloc] init];
    myAddress.text = @"我的位置";
    myAddress.textAlignment = NSTextAlignmentCenter;
    myAddress.userInteractionEnabled = YES;
    myAddress.textColor = AppDeepGrayTextColor;
    myAddress.font = [UIFont systemFontOfSize:13];
    myAddress.frame = CGRectMake(SCREEN_WIDTH - 80 - 15, 60 - 20 - 5, 80, 20);
    [locationView addSubview:myAddress];
    [myAddress addGestureRecognizer:myAddressTap];
    
    UIImageView *addressIconTwoView = [[UIImageView alloc] init];
    addressIconTwoView.image = [UIImage imageNamed:@"定位"];
    addressIconTwoView.userInteractionEnabled = YES;
    addressIconTwoView.frame = CGRectMake(myAddress.x, 0, 80, 40);
    addressIconTwoView.contentMode = UIViewContentModeCenter;
    [locationView addSubview:addressIconTwoView];
    [addressIconTwoView addGestureRecognizer:addressIconTwoViewTap];
    
    UIView *deviderThree = [[UIView alloc] initWithFrame:CGRectMake(20, 59, SCREEN_WIDTH - 40, 1)];
    deviderThree.backgroundColor = AppLineColor;
    [locationView addSubview:deviderThree];

    return locationView;
}
/*
 * 日期模块
 */
- (UIView *)setupDateView:(UIView *)locationView
{
    UIView *dateView = [[UIView alloc] init];
    dateView.frame = CGRectMake(0, CGRectGetMaxY(locationView.frame), SCREEN_WIDTH, 70);
    [self.view addSubview:dateView];
    
    UIImageView *clockImage = [[UIImageView alloc] init];
    clockImage.image = [UIImage imageNamed:@"定位"];
    clockImage.frame = CGRectMake(10, 15, 40, 40);
    clockImage.contentMode = UIViewContentModeCenter;
    [dateView addSubview:clockImage];
    
    UILabel *starDate = [[UILabel alloc] init];
    starDate.text = @"入住\n2016年8月16日";
    starDate.textAlignment = NSTextAlignmentCenter;
    starDate.userInteractionEnabled = YES;
    starDate.numberOfLines = 0;
    starDate.textColor = AppDeepGrayTextColor;
    starDate.font = [UIFont systemFontOfSize:13];
    starDate.frame = CGRectMake(CGRectGetMaxX(clockImage.frame) + 5, 0, (SCREEN_WIDTH - 40 - 40 - 40 - 30 - 5 - 5) * 0.5, 60);
    [dateView addSubview:starDate];
    
    UIImageView *slash = [[UIImageView alloc] init];
    slash.image = [UIImage imageNamed:@"定位"];
    slash.frame = CGRectMake(CGRectGetMaxX(starDate.frame), 15, 40, 40);
    slash.contentMode = UIViewContentModeCenter;
    [dateView addSubview:slash];

    UILabel *endDate = [[UILabel alloc] init];
    endDate.text = @"入住\n2016年8月16日";
    endDate.textAlignment = NSTextAlignmentCenter;
    endDate.userInteractionEnabled = YES;
    endDate.numberOfLines = 0;
    endDate.textColor = AppDeepGrayTextColor;
    endDate.font = [UIFont systemFontOfSize:13];
    endDate.frame = CGRectMake(CGRectGetMaxX(slash.frame), 0, (SCREEN_WIDTH - 40 - 40 - 40 - 30 - 5 - 5) * 0.5, 60);
    [dateView addSubview:endDate];
    
    UIImageView *rightArrow = [[UIImageView alloc] init];
    rightArrow.image = [UIImage imageNamed:@"定位"];
    rightArrow.frame = CGRectMake(CGRectGetMaxX(endDate.frame) + 5, 20, 30, 30);
    rightArrow.contentMode = UIViewContentModeCenter;
    [dateView addSubview:rightArrow];
    
    UIView *devider = [[UIView alloc] initWithFrame:CGRectMake(20, 69, SCREEN_WIDTH - 40, 1)];
    devider.backgroundColor = AppLineColor;
    [dateView addSubview:devider];
    
    return dateView;
}
/*
 * 数量模块
 */
- (UIView *)setupNumView:(UIView *)dateView
{
    UIView *numView = [[UIView alloc] init];
    numView.frame = CGRectMake(0, CGRectGetMaxY(dateView.frame), SCREEN_WIDTH, 100);
    [self.view addSubview:numView];
    //订房人数
    UIView *peopleNumberView = [[UIView alloc] init];
    peopleNumberView.backgroundColor = [UIColor clearColor];
    peopleNumberView.frame = CGRectMake(0, 0, SCREEN_WIDTH * 0.5, 100);
    [numView addSubview:peopleNumberView];
    
    UILabel *peopleTitleLabel = [[UILabel alloc] init];
    peopleTitleLabel.text = @"客官人数";
    peopleTitleLabel.textAlignment = NSTextAlignmentCenter;
    peopleTitleLabel.textColor = [UIColor blackColor];
    peopleTitleLabel.font = [UIFont systemFontOfSize:15];
    peopleTitleLabel.frame = CGRectMake(0, 5, SCREEN_WIDTH * 0.5, 30);
    [peopleNumberView addSubview:peopleTitleLabel];
    
    UIButton *addBtn = [[UIButton alloc] init];
    addBtn.frame = CGRectMake((SCREEN_WIDTH*0.5 - 20 - 60 - 50)*0.5, 35, 30, 30);
    [addBtn setBackgroundImage:[UIImage imageNamed:@"＋"] forState:UIControlStateNormal];
    [addBtn setBackgroundImage:[UIImage imageNamed:@"＋点击状态"] forState:UIControlStateHighlighted];
    [addBtn addTarget:self action:@selector(addBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [peopleNumberView addSubview:addBtn];
    
    UILabel *numberLabel = [[UILabel alloc] init];
    numberLabel.text = @"1";
    numberLabel.textColor = AppDeepGrayTextColor;
    numberLabel.layer.cornerRadius = 5;
    numberLabel.layer.masksToBounds = YES;
    numberLabel.textAlignment = NSTextAlignmentCenter;
    numberLabel.font = [UIFont systemFontOfSize:15];
    numberLabel.frame = CGRectMake(CGRectGetMaxX(addBtn.frame)+10, 35, 50, 30);
    numberLabel.layer.borderWidth = 1;
    numberLabel.layer.borderColor = AppLightGrayLineColor.CGColor;
    [peopleNumberView addSubview:numberLabel];
    
    UIButton *subBtn = [[UIButton alloc] init];
    subBtn.frame = CGRectMake(CGRectGetMaxX(numberLabel.frame)+10, 35, 30, 30);
    [subBtn setBackgroundImage:[UIImage imageNamed:@"－"] forState:UIControlStateNormal];
    [subBtn setBackgroundImage:[UIImage imageNamed:@"－点击状态"] forState:UIControlStateHighlighted];
    [subBtn addTarget:self action:@selector(subBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [peopleNumberView addSubview:subBtn];

    //分割线
    UIView *devider = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH * 0.5 - 0.5, 0, 1, 80)];
    devider.backgroundColor = AppLineColor;
    [numView addSubview:devider];
    
    //房间数量
    UIView *roomNumberView = [[UIView alloc] init];
    roomNumberView.backgroundColor = [UIColor clearColor];
    roomNumberView.frame = CGRectMake(SCREEN_WIDTH * 0.5, 0, SCREEN_WIDTH * 0.5, 100);
    [numView addSubview:roomNumberView];
    
    UILabel *roomTitleLabel = [[UILabel alloc] init];
    roomTitleLabel.text = @"房间数量";
    roomTitleLabel.textAlignment = NSTextAlignmentCenter;
    roomTitleLabel.textColor = [UIColor blackColor];
    roomTitleLabel.font = [UIFont systemFontOfSize:15];
    roomTitleLabel.frame = CGRectMake(0, 5, SCREEN_WIDTH * 0.5, 30);
    [roomNumberView addSubview:roomTitleLabel];
    
    UIButton *roomAddBtn = [[UIButton alloc] init];
    roomAddBtn.frame = CGRectMake((SCREEN_WIDTH*0.5 - 20 - 60 - 50)*0.5, 35, 30, 30);
    [roomAddBtn setBackgroundImage:[UIImage imageNamed:@"＋"] forState:UIControlStateNormal];
    [roomAddBtn setBackgroundImage:[UIImage imageNamed:@"＋点击状态"] forState:UIControlStateHighlighted];
    [roomAddBtn addTarget:self action:@selector(addBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [roomNumberView addSubview:roomAddBtn];
    
    UILabel *roomNumberLabel = [[UILabel alloc] init];
    roomNumberLabel.text = @"1";
    roomNumberLabel.textColor = AppDeepGrayTextColor;
    roomNumberLabel.layer.cornerRadius = 5;
    roomNumberLabel.layer.masksToBounds = YES;
    roomNumberLabel.textAlignment = NSTextAlignmentCenter;
    roomNumberLabel.font = [UIFont systemFontOfSize:15];
    roomNumberLabel.frame = CGRectMake(CGRectGetMaxX(addBtn.frame)+10, 35, 50, 30);
    roomNumberLabel.layer.borderWidth = 1;
    roomNumberLabel.layer.borderColor = AppLightGrayLineColor.CGColor;
    [roomNumberView addSubview:roomNumberLabel];
    
    UIButton *roomSubBtn = [[UIButton alloc] init];
    roomSubBtn.frame = CGRectMake(CGRectGetMaxX(numberLabel.frame)+10, 35, 30, 30);
    [roomSubBtn setBackgroundImage:[UIImage imageNamed:@"－"] forState:UIControlStateNormal];
    [roomSubBtn setBackgroundImage:[UIImage imageNamed:@"－点击状态"] forState:UIControlStateHighlighted];
    [roomSubBtn addTarget:self action:@selector(subBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [roomNumberView addSubview:roomSubBtn];
    
    return numView;
}
/*
 * 类型模块
 */
- (UIView *)setupTypeView:(UIView *)numView
{
    UIView *typeView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(numView.frame) + 20, SCREEN_WIDTH, 200)];
    [self.view addSubview:typeView];
    
    for (int i = 0; i<3; i++) {
        UITapGestureRecognizer *typeTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(typeTap:)];
        
        UIView *typeV = [[UIButton alloc] initWithFrame:CGRectMake(10 + i*((SCREEN_WIDTH - 40)/3 + 10), 0, (SCREEN_WIDTH - 40)/3, 90)];
        typeV.alpha = 1.0;
        typeV.layer.cornerRadius = 5;
        typeV.layer.borderWidth = 1;
        typeV.layer.borderColor = AppLightGrayLineColor.CGColor;
        [typeView addSubview:typeV];
        [self.typeArray addObject:typeV];
        
        UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(((SCREEN_WIDTH - 40)/3 - 30)*0.5, 10, 30, 30)];
        imageView.contentMode = UIViewContentModeCenter;
        imageView.backgroundColor = [UIColor redColor];
        imageView.userInteractionEnabled = YES;
        [imageView addGestureRecognizer:typeTap];
        [typeV addSubview:imageView];
        
        UILabel *typeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 45, (SCREEN_WIDTH - 40)/3, 30)];
        typeLabel.textAlignment = NSTextAlignmentCenter;
        typeLabel.text = @"风情酒店";
        typeLabel.tag = i;
        typeLabel.textColor = AppDeepGrayTextColor;
        [typeLabel setAppFontWithSize:16];
        [typeV addSubview:typeLabel];
        
        UIView *devider = [[UIView alloc] initWithFrame:CGRectMake(20, 90, SCREEN_WIDTH - 60, 1)];
        devider.backgroundColor = AppLightGrayLineColor;
        [typeV addSubview:devider];
        
    }
    for (int i = 0; i<3; i++) {
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(10 + i*((SCREEN_WIDTH - 20)/3 + 10), 40 + 90, (SCREEN_WIDTH - 20)/3, 30)];
        [button setTitle:@"标准房" forState:UIControlStateNormal];
        [button setTitleColor:AppLightGrayTextColor forState:UIControlStateNormal];
        [button setTitleColor:AppDeepGrayTextColor forState:UIControlStateSelected];
        button.alpha = 0.0;
        if (i == 0) {
            button.selected = YES;
        }
        [typeView addSubview:button];
        [self.roomTypeArray addObject:button];
        if (i < 2) {
            UIView *deviderButton = [[UIView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 20)/3 - 1, 0, 1, 30)];
            deviderButton.backgroundColor = AppDeepGrayTextColor;
            [button addSubview:deviderButton];
        }
    }
    return typeView;
}
@end
