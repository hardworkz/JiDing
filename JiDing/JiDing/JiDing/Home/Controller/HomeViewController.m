//
//  HomeViewController.m
//  JiDing
//
//  Created by 泡果 on 2017/5/26.
//  Copyright © 2017年 zhangrongting. All rights reserved.
//

#import "HomeViewController.h"


#define RadioLineW sqrt(2*SCREEN_HEIGHT*SCREEN_HEIGHT)
#define Radius (3 * SCREEN_HEIGHT + RadioLineW/2)
@interface HomeViewController ()<Xzb_MapViewControllerDelegate,CLLocationManagerDelegate,UINavigationControllerDelegate>
{
    UIView *peopleNumberView;
    UIView *roomNumberView;
    UILabel *numberLabel;
    UIButton *addBtn;
    UIButton *subBtn;
    UIButton *roomAddBtn;
    UIButton *roomSubBtn;
    UILabel *roomNumberLabel;
    UILabel *addressContentLabel;
    UILabel *starDate;
    UILabel *endDate;
    UILabel *peopleTitleLabel;
    UILabel *roomTitleLabel;
}

@property (strong, nonatomic) UIButton *backBtn;
@property (strong, nonatomic) UIButton *nextBtn;
/*
 * 点击用户中心遮盖view
 */
@property (strong, nonatomic) CustomRadioView *bigRoundCoverView;
@property (strong, nonatomic) CustomRadioView *bigRoundCoverViewSetting;
/*
 * 加减动画控件
 */
@property (strong, nonatomic) UILabel *addAndSubLabel;
@property (strong, nonatomic) UILabel *addAndSubLabelTwo;
/*
 * 展开类型动画完成
 */
@property (assign, nonatomic) BOOL isCompleteTypeAnimation;

@property (strong, nonatomic) NSMutableArray *typeArray;
@property (strong, nonatomic) NSMutableArray *typeImageViewArray;
@property (strong, nonatomic) NSMutableArray *typeLabelArray;
@property (strong, nonatomic) NSMutableArray *roomTypeArray;

@property (strong, nonatomic) NSMutableArray *typeDataArray;
@property (strong, nonatomic) NSMutableArray *roomTypeDataArray;
@property (strong, nonatomic) NSMutableArray *ktvDataArray;
@property (strong, nonatomic) NSMutableArray *ktvTypeDataArray;
/*
 * 选中的类型
 */
@property (strong, nonatomic) UIView *selectedTypeV;
@property (strong, nonatomic) UIImageView *selectedImageViewV;
@property (strong, nonatomic) UILabel *selectedTypeLabelV;
@property (strong, nonatomic) UIView *devider;
/*
 * 选中类型frame保持全局
 */
@property (assign, nonatomic) CGRect selectedTypeVF;
@property (assign, nonatomic) CGRect selectedImageViewVF;
@property (assign, nonatomic) CGRect selectedTypeLabelVF;
#pragma mark - 定位属性
@property (nonatomic, strong) CLGeocoder *geocoder;
@property(nonatomic, strong) CLLocationManager *CLLocationManager;
/**
 *  定位获取经纬度
 */
@property (nonatomic,assign)  CLLocationDegrees lon;
@property (nonatomic,assign)  CLLocationDegrees lat;
/**
 入住日期和离店日期
 */
@property (nonatomic,strong)  NSString *startDateString;
@property (nonatomic,strong)  NSString *endDateString;
/**
 *  酒店类型图标名称
 */
/**
 *  KTV类型图标名称
 */
@end

static HomeViewController *_instance = nil;
@implementation HomeViewController

+ (instancetype)shareInstance {
    static dispatch_once_t onceToken ;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
    }) ;
    return _instance ;
}
- (void)dealloc
{
    RTLog(@"dealloc---HomeViewController");
}
#pragma mark - set方法
- (void)setHomeType:(SelectedHomeType)homeType
{
    switch (homeType) {
        case SelectedHomeTypeHotel:
            [self select_hotel];
            break;
            
        case SelectedHomeTypeKTV:
            [self select_ktv];
            break;
        default:
            break;
    }
}
#pragma mark - 懒加载定位
/**
 *  懒加载
 */
- (CLGeocoder *)geocoder
{
    if (!_geocoder) {
        self.geocoder = [[CLGeocoder alloc] init];
    }
    return _geocoder;
}
/**
 *  设置地理定位功能
 */
- (void)setupPositioning
{
    //打开定位功能
    if ([CLLocationManager locationServicesEnabled]) {
        self.CLLocationManager = [[CLLocationManager alloc]init];
        _CLLocationManager.delegate = self;
        _CLLocationManager.desiredAccuracy = kCLLocationAccuracyBest;
        _CLLocationManager.distanceFilter = 10;
        [_CLLocationManager requestWhenInUseAuthorization];//添加这句
        [_CLLocationManager startUpdatingLocation];
    }
    
}
#pragma mark - 懒加载
- (NSMutableArray *)typeArray
{
    if (_typeArray == nil) {
        _typeArray = [NSMutableArray array];
    }
    return _typeArray;
}
- (NSMutableArray *)typeImageViewArray
{
    if (_typeImageViewArray == nil) {
        _typeImageViewArray = [NSMutableArray array];
    }
    return _typeImageViewArray;
}
- (NSMutableArray *)typeLabelArray
{
    if (_typeLabelArray == nil) {
        _typeLabelArray = [NSMutableArray array];
    }
    return _typeLabelArray;
}
- (NSMutableArray *)roomTypeArray
{
    if (_roomTypeArray == nil) {
        _roomTypeArray = [NSMutableArray array];
    }
    return _roomTypeArray;
}
- (NSMutableArray *)typeDataArray
{
    if (_typeDataArray == nil) {
        _typeDataArray = [NSMutableArray array];
        _typeDataArray = (NSMutableArray *)@[@"风情民宿",@"快捷商务",@"星级酒店"];
    }
    return _typeDataArray;
}
- (NSMutableArray *)roomTypeDataArray
{
    if (_roomTypeDataArray == nil) {
        _roomTypeDataArray = [NSMutableArray array];
        _roomTypeDataArray = (NSMutableArray *)@[@"标准房",@"大床房",@"双人房"];
    }
    return _roomTypeDataArray;
}
- (NSMutableArray *)ktvDataArray
{
    if (_ktvDataArray == nil) {
        _ktvDataArray = [NSMutableArray array];
        _ktvDataArray = (NSMutableArray *)@[@"小包",@"中包",@"大包"];
    }
    return _ktvDataArray;
}
- (NSMutableArray *)ktvTypeDataArray
{
    if (_ktvTypeDataArray == nil) {
        _ktvTypeDataArray = [NSMutableArray array];
        _ktvTypeDataArray = (NSMutableArray *)@[@"小包厢",@"中包厢",@"大包厢"];
    }
    return _ktvTypeDataArray;
}


- (UIView *)bigRoundCoverView
{
    if (_bigRoundCoverView == nil) {
        _bigRoundCoverView = [[CustomRadioView alloc] init];
        _bigRoundCoverView.backgroundColor = [UIColor clearColor];
        _bigRoundCoverView.frame = CGRectMake(SCREEN_WIDTH, SCREEN_HEIGHT, Radius * 2, Radius * 2);
        RTLog(@"x:%f-----y:%f --- width:%f ----height:%f",_bigRoundCoverView.x,_bigRoundCoverView.y,_bigRoundCoverView.width,_bigRoundCoverView.height);
    }
    return _bigRoundCoverView;
}
- (UIView *)bigRoundCoverViewSetting
{
    if (_bigRoundCoverViewSetting == nil) {
        _bigRoundCoverViewSetting = [[CustomRadioView alloc] init];
        _bigRoundCoverViewSetting.backgroundColor = [UIColor clearColor];
        _bigRoundCoverViewSetting.frame = CGRectMake(-(Radius * 2), SCREEN_HEIGHT, Radius * 2, Radius * 2);
        RTLog(@"x:%f-----y:%f --- width:%f ----height:%f",_bigRoundCoverViewSetting.x,_bigRoundCoverViewSetting.y,_bigRoundCoverViewSetting.width,_bigRoundCoverViewSetting.height);
    }
    return _bigRoundCoverViewSetting;
}
- (UILabel *)addAndSubLabel
{
    if (_addAndSubLabel == nil) {
        _addAndSubLabel = [[UILabel alloc] init];
        _addAndSubLabel.textColor = AppDeepGrayTextColor;
        _addAndSubLabel.textAlignment = NSTextAlignmentCenter;
        _addAndSubLabel.font = [UIFont systemFontOfSize:15];
    }
    return _addAndSubLabel;
}
- (UILabel *)addAndSubLabelTwo
{
    if (_addAndSubLabelTwo == nil) {
        _addAndSubLabelTwo = [[UILabel alloc] init];
        _addAndSubLabelTwo.textColor = AppDeepGrayTextColor;
        _addAndSubLabelTwo.textAlignment = NSTextAlignmentCenter;
        _addAndSubLabelTwo.font = [UIFont systemFontOfSize:15];
    }
    return _addAndSubLabelTwo;
}

#pragma mark - viewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.fd_interactivePopDisabled = YES;
    
    [AMapLocationServices sharedServices].apiKey = MaMapApiKey;
    
    //开始定位
    [self setupPositioning];
    
    //设置首页控件
    [self setupHomeView];
    self.isCompleteTypeAnimation = YES;
    
    //侧滑手势
    UISwipeGestureRecognizer *rightSwipe = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(actionAutoBack:)];
    [rightSwipe setDirection:UISwipeGestureRecognizerDirectionRight];
    [self.view addGestureRecognizer:rightSwipe];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}
- (void)actionAutoBack:(UIBarButtonItem *)barItem
{
    DefineWeakSelf
    [self.animationVC animationClose:^{
        [weakSelf.navigationController popViewControllerAnimated:NO];
        [weakSelf back];
    }];
}
/*
 * 选择条件完成，进入下一步
 */
- (void)next
{
    UserAccount *account = [UserAccountTool account];
    Xzb_ApplicationData *data = [Xzb_ApplicationDataTool account];
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    if (self.lon == 0.0 || self.lat == 0.0) {
        [[Toast makeText:@"请重新定位"] show];
        return;
    }
    //设置经纬度和用户ID参数
    [param setObject:data.user_y?data.user_y:[NSString stringWithFormat:@"%.8f",self.lat] forKey:@"xLocation"];
    [param setObject:data.user_x?data.user_x:[NSString stringWithFormat:@"%.8f",self.lon] forKey:@"yLocation"];
    //设置用户ID
    [param setObject:account.userId forKey:@"userId"];
    //设置用户token
    [param setObject:account.loginToken forKey:@"token"];
    //渠道
    [param setObject:@"iOS" forKey:@"channelId"];
    //设置入住日期和离店日期
    [param setObject:self.startDateString forKey:@"checkinDate"];
    [param setObject:self.endDateString forKey:@"leaveDate"];
    //设置房间类型
    [param setObject:@"1" forKey:@"roomType"];
    //设置房间数量
    [param setObject:roomNumberLabel.text forKey:@"num"];
    //设置人数
    [param setObject:numberLabel.text forKey:@"userNum"];
    
    RTLog(@"%@",param);
    
    [RTHttpTool post:[NSString stringWithFormat:@"%@?userId=%@&token=%@",ADD_NEW_ORDER,account.userId,account.loginToken] addHUD:NO param:nil success:^(id responseObj) {
        RTLog(@"%@",responseObj);
        if ([responseObj[SUCCESS] intValue] == 1) {
            
            NSMutableArray *dataArray = [HotelOfferModel mj_objectArrayWithKeyValuesArray:responseObj[ENTITIES][LIST]];
            if (dataArray.count == 0) {
                [[Toast makeText:@"~暂无酒店报价，请重新更改需求~"] show];
                
                //恢复酒店订单状态
                UserAccount *account = [UserAccountTool account];
                [RTHttpTool post:CANCLE_ORDER addHUD:NO param:@{ID:responseObj[ENTITIES][ORDERID],USERID:account.userId,TOKEN:account.loginToken} success:^(id responseObj) {
                    if ([responseObj[SUCCESS] intValue] == 1) {
                        
                    }
                } failure:^(NSError *error) {
                    
                }];
                return;
            }
            //启动定时器
            for (HotelOfferModel *model in dataArray) {
                model.starAction = YES;
            }
            
            //跳转搜索结果列表控制器
            Xzb_SearchResultTableViewController *result = [[Xzb_SearchResultTableViewController alloc] init];
            result.dataArray = dataArray;
            [self.navigationController pushViewController:result animated:YES];
        }
    } failure:^(NSError *error) {
        RTLog(@"error :%@",error);
    }];

//
//
//    HotelOfferModel *model = [HotelOfferModel mj_objectWithKeyValues:@{@"ylocation":@"118.181564"
//                                                                       ,@"timePeriod":@0
//                                                                       ,@"orderType":@"1"
//                                                                       ,@"countDown":@5
//                                                                       ,@"image":@"user5-128x128.png"
//                                                                       ,@"roomId":@136
//                                                                       ,@"hotelId":@80
//                                                                       ,@"distance":@1.13
//                                                                       ,@"level":@"4"
//                                                                       ,@"price":@"0.02"
//                                                                       ,@"xlocation":@"24.488284"
//                                                                       ,@"roomType":@"2"
//                                                                       ,@"orderRelId":@28468
//                                                                       ,@"name":@"%E4%BD%B0%E7%BF%94%E8%BD%AF%E4%BB%B6%E5%9B%AD%E9%85%92%E5%BA%97"
//                                                                       ,@"payType":@"1"
//                                                                       ,@"appraise":@90
//                                                                       }];
//    NSMutableArray *array = [NSMutableArray array];
//    [array addObject:model];
}
- (void)select_hotel
{
    //更新为酒店数据
    self.title = @"酒店";
    for (int i = 0;i<self.typeImageViewArray.count;i++) {
        UIImageView *imageView = self.typeImageViewArray[i];
        imageView.image = [UIImage imageNamed:self.typeDataArray[i]];
        UILabel *typeLabel = self.typeLabelArray[i];
        typeLabel.text = self.typeDataArray[i];
        UIButton *roomBtn = self.roomTypeArray[i];
        [roomBtn setTitle:self.roomTypeDataArray[i]];
    }
    peopleTitleLabel.text = @"客官人数";
    roomTitleLabel.text = @"房间数量";
}
- (void)select_ktv
{
    //更新为KTV数据
    self.title = @"KTV";
    for (int i = 0;i<self.typeImageViewArray.count;i++) {
        UIImageView *imageView = self.typeImageViewArray[i];
        imageView.image = [UIImage imageNamed:self.ktvDataArray[i]];
        UILabel *typeLabel = self.typeLabelArray[i];
        typeLabel.text = self.ktvDataArray[i];
        UIButton *roomBtn = self.roomTypeArray[i];
        [roomBtn setTitle:self.ktvTypeDataArray[i]];
    }
    peopleTitleLabel.text = @"唱客人数";
    roomTitleLabel.text = @"包厢数量";
}

/*
 * 选中类型动画
 */
- (void)typeTap:(UIGestureRecognizer *)gestuer
{
    //判断是否可以展开动画
    if (self.isCompleteTypeAnimation) {
        
        UIView *typeV = (UIImageView *)gestuer.view;
        UIImageView *imageView;
        UILabel *typeLabel;
        for (UIView *view in typeV.subviews) {
            if ([view isKindOfClass:[UILabel class]]) {
                typeLabel = (UILabel *)view;
            }else if ([view isKindOfClass:[UIImageView class]]) {
                imageView = (UIImageView *)view;
            }
        }
        //设置选中类型
        self.selectedTypeV = typeV;
        self.selectedTypeV.layer.borderColor = HEXCOLOR(0x87D9FF).CGColor;
        self.selectedImageViewV = imageView;
        self.selectedTypeLabelV = typeLabel;
        //保存选中控件原来frame,方便之后返回动画
        self.selectedTypeVF = typeV.frame;
        self.selectedImageViewVF = imageView.frame;
        self.selectedTypeLabelVF = typeLabel.frame;
        
        
        [UIView animateWithDuration:0.35 animations:^{
            for (UIView *typeView in self.typeArray) {
                if ([typeView isEqual:typeV]) {//如果为当前选中uiview则不隐藏
                    typeView.alpha = 1.0;
                }else{
                    typeView.alpha = 0;
                }
            }
            self.devider.alpha = 1.0;
            for (UIButton *button in self.roomTypeArray) {
                button.alpha = 1.0;
            }
            _backBtn.alpha = 1.0;
            
            typeV.frame = CGRectMake(10, 0, SCREEN_WIDTH - 20, 200);
            imageView.frame = CGRectMake(imageView.x - 5, imageView.y + 30, 40, 40);
            typeLabel.frame = CGRectMake(CGRectGetMaxX(imageView.frame) - 15, imageView.y + 5, typeLabel.width, typeLabel.height);
            _nextBtn.frame = CGRectMake((SCREEN_WIDTH - 50) * 0.5  +100, SCREEN_HEIGHT - 50 - 10 - 64, 50, 50);
        } completion:^(BOOL finished) {
            self.isCompleteTypeAnimation = NO;
            typeV.userInteractionEnabled = NO;
            
        }];
    }
}
/*
 * 返回缩放动画
 */
- (void)back
{
    if (!self.isCompleteTypeAnimation) {
        
        self.selectedTypeV.layer.borderColor = AppLightGrayLineColor.CGColor;
        [UIView animateWithDuration:0.35 animations:^{
            
            self.devider.alpha = 0;
            for (UIButton *button in self.roomTypeArray) {
                button.alpha = 0;
            }
            _backBtn.alpha = 0.0;
            
            for (UIView *typeV in self.typeArray) {
                typeV.alpha = 1.0;
            }
            self.selectedTypeV.frame = self.selectedTypeVF;
            self.selectedImageViewV.frame = self.selectedImageViewVF;
            self.selectedTypeLabelV.frame = self.selectedTypeLabelVF;
            _nextBtn.frame = CGRectMake((SCREEN_WIDTH - 50) * 0.5, SCREEN_HEIGHT - 50 - 10 - 64, 50, 50);
        } completion:^(BOOL finished) {
            self.isCompleteTypeAnimation = YES;
            self.selectedTypeV.userInteractionEnabled = YES;
            
            
        }];
    }
}
/*
 * 点击房间类型
 */
- (void)roomTypeSelected:(UIButton *)button
{
    for (UIButton *roomBtn in self.roomTypeArray) {
        roomBtn.selected = NO;
    }
    button.selected = YES;
}
/*
 * 点击跳转地图界面
 */
- (void)locationTap
{
    Xzb_MapViewController *map = [[Xzb_MapViewController alloc] init];
    map.delegate = self;
    [self.navigationController pushViewController:map animated:YES];
}
/*
 * 定位当前位置，不进行界面跳转
 */
- (void)myAddressTap
{
    addressContentLabel.text = @"定位中...";
    Xzb_ApplicationData *data = [Xzb_ApplicationDataTool account];
    data.user_x = nil;
    data.user_y = nil;
    data.userAddress = nil;
    [Xzb_ApplicationDataTool saveWithAccount:data];
    [_CLLocationManager startUpdatingLocation];
}
/*
 * 弹出开始日期选择器
 */
- (void)tapStarDate
{
    NSDate *date = [NSDate date];
    XHDatePickerView *datepicker = [[XHDatePickerView alloc] initWithCompleteBlock:^(NSDate *startDates,NSDate *endDates,XHDateType dateType) {
//        NSLog(@"\n开始时间： %@，结束时间：%@",startDates,endDates);入住\n2016年8月16日
        switch (dateType) {
            case DateTypeStartDate:
                starDate.text = [NSString stringWithFormat:@"入住\n%@",[startDates stringWithFormat:@"yyyy年MM月dd日"] == nil?@"未选择":[startDates stringWithFormat:@"yyyy年MM月dd日"]];
                self.startDateString = [startDates stringWithFormat:@"yyyy-MM-dd"];
                break;
            default:
                endDate.text = [NSString stringWithFormat:@"离店\n%@",[endDates stringWithFormat:@"yyyy年MM月dd日"] == nil?@"未选择":[endDates stringWithFormat:@"yyyy年MM月dd日"]];
                self.endDateString = [endDates stringWithFormat:@"yyyy-MM-dd"];
                break;
        }
    }];
//    NSDate *lastDay = [NSDate dateWithTimeInterval:-24*60*60 sinceDate:date];//前一天
    NSDate *nextDay = [NSDate dateWithTimeInterval:365*24*60*60 sinceDate:date];//后一年
    datepicker.datePickerStyle = DateStyleShowYearMonthDay;
    datepicker.dateType = DateTypeStartDate;
    datepicker.minLimitDate = [NSDate date];
    datepicker.maxLimitDate = nextDay;
    [datepicker show];
}
/*
 * 弹出开始日期选择器
 */
- (void)tapEndDate
{
    NSDate *date = [NSDate date];
    
    XHDatePickerView *datepicker = [[XHDatePickerView alloc] initWithCompleteBlock:^(NSDate *startDates,NSDate *endDates,XHDateType dateType) {
        switch (dateType) {
            case DateTypeStartDate:
                starDate.text = [NSString stringWithFormat:@"入住\n%@",[startDates stringWithFormat:@"yyyy年MM月dd日"] == nil?@"未选择":[startDates stringWithFormat:@"yyyy年MM月dd日"]];
                self.startDateString = [startDates stringWithFormat:@"yyyy-MM-dd"];
                break;
                
            default:
                endDate.text = [NSString stringWithFormat:@"离店\n%@",[endDates stringWithFormat:@"yyyy年MM月dd日"] == nil?@"未选择":[endDates stringWithFormat:@"yyyy年MM月dd日"]];
                self.endDateString = [endDates stringWithFormat:@"yyyy-MM-dd"];
                break;
        }
    }];
    //    NSDate *lastDay = [NSDate dateWithTimeInterval:-24*60*60 sinceDate:date];//前一天
    NSDate *nextDay = [NSDate dateWithTimeInterval:24*60*60 sinceDate:date];//后一天
    NSDate *nextYear = [NSDate dateWithTimeInterval:365*24*60*60 sinceDate:date];//后一年
    datepicker.datePickerStyle = DateStyleShowYearMonthDay;
    datepicker.dateType = DateTypeEndDate;
    datepicker.minLimitDate = nextDay;
    datepicker.maxLimitDate = nextYear;
    [datepicker show];
}
#pragma mark - 人数，房间数加减action
- (void)addBtnClicked:(UIButton *)button
{
    //设置加动画
    if ([button isEqual:addBtn]) {//当前为客官人数
        button.enabled = NO;
        subBtn.enabled = NO;
        roomAddBtn.enabled = NO;
        roomSubBtn.enabled = NO;
        //设置加减动画
        self.addAndSubLabel.frame = numberLabel.frame;
        self.addAndSubLabel.text = numberLabel.text;
        self.addAndSubLabelTwo.frame = CGRectMake(numberLabel.x, numberLabel.y + 50, numberLabel.width, numberLabel.height);
        self.addAndSubLabelTwo.text = [NSString stringWithFormat:@"%d",[numberLabel.text intValue] + 1];
        self.addAndSubLabelTwo.alpha = 0.0;
        numberLabel.text = @"";
        [peopleNumberView addSubview:self.addAndSubLabel];
        [peopleNumberView addSubview:self.addAndSubLabelTwo];
        [UIView animateWithDuration:0.5 animations:^{
            self.addAndSubLabel.y -= 50;
            self.addAndSubLabel.alpha = 0.0;
            self.addAndSubLabelTwo.y -= 50;
            self.addAndSubLabelTwo.alpha = 1.0;
        } completion:^(BOOL finished) {
            numberLabel.text = self.addAndSubLabelTwo.text;
            [self.addAndSubLabel removeFromSuperview];
            [self.addAndSubLabelTwo removeFromSuperview];
            self.addAndSubLabel = nil;
            self.addAndSubLabelTwo = nil;
            button.enabled = YES;
            subBtn.enabled = YES;
            roomAddBtn.enabled = YES;
            roomSubBtn.enabled = YES;
        }];

    }else{//当前为房间人数
        button.enabled = NO;
        roomSubBtn.enabled = NO;
        addBtn.enabled = NO;
        subBtn.enabled = NO;
        self.addAndSubLabel.frame = roomNumberLabel.frame;
        self.addAndSubLabel.text = roomNumberLabel.text;
        self.addAndSubLabelTwo.frame = CGRectMake(roomNumberLabel.x, roomNumberLabel.y + 50, roomNumberLabel.width, roomNumberLabel.height);
        self.addAndSubLabelTwo.text = [NSString stringWithFormat:@"%d",[roomNumberLabel.text intValue] + 1];
        self.addAndSubLabelTwo.alpha = 0.0;
        roomNumberLabel.text = @"";
        [roomNumberView addSubview:self.addAndSubLabel];
        [roomNumberView addSubview:self.addAndSubLabelTwo];
        [UIView animateWithDuration:0.5 animations:^{
            self.addAndSubLabel.y -= 50;
            self.addAndSubLabel.alpha = 0.0;
            self.addAndSubLabelTwo.y -= 50;
            self.addAndSubLabelTwo.alpha = 1.0;
        } completion:^(BOOL finished) {
            roomNumberLabel.text = self.addAndSubLabelTwo.text;
            [self.addAndSubLabel removeFromSuperview];
            [self.addAndSubLabelTwo removeFromSuperview];
            self.addAndSubLabel = nil;
            self.addAndSubLabelTwo = nil;
            button.enabled = YES;
            roomSubBtn.enabled = YES;
            addBtn.enabled = YES;
            subBtn.enabled = YES;
        }];
    }
}
- (void)subBtnClicked:(UIButton *)button
{
    //设置减动画
    if ([button isEqual:subBtn]) {//当前为客官人数
        if ([numberLabel.text intValue] <= 1) {
            XWAlerLoginView *xw = [[XWAlerLoginView alloc]initWithTitle:@"不能再减了~"];
            [xw show];
            return;
        }
        button.enabled = NO;
        addBtn.enabled = NO;
        roomAddBtn.enabled = NO;
        roomSubBtn.enabled = NO;
        //设置加减动画
        self.addAndSubLabel.frame = numberLabel.frame;
        self.addAndSubLabel.text = numberLabel.text;
        self.addAndSubLabelTwo.frame = CGRectMake(numberLabel.x, numberLabel.y - 50, numberLabel.width, numberLabel.height);
        self.addAndSubLabelTwo.text = [NSString stringWithFormat:@"%d",[numberLabel.text intValue] - 1];
        self.addAndSubLabelTwo.alpha = 0.0;
        numberLabel.text = @"";
        [peopleNumberView addSubview:self.addAndSubLabel];
        [peopleNumberView addSubview:self.addAndSubLabelTwo];
        [UIView animateWithDuration:0.5 animations:^{
            self.addAndSubLabel.y
            += 50;
            self.addAndSubLabel.alpha = 0.0;
            self.addAndSubLabelTwo.y += 50;
            self.addAndSubLabelTwo.alpha = 1.0;
        } completion:^(BOOL finished) {
            numberLabel.text = self.addAndSubLabelTwo.text;
            [self.addAndSubLabel removeFromSuperview];
            [self.addAndSubLabelTwo removeFromSuperview];
            self.addAndSubLabel = nil;
            self.addAndSubLabelTwo = nil;
            button.enabled = YES;
            addBtn.enabled = YES;
            roomAddBtn.enabled = YES;
            roomSubBtn.enabled = YES;
        }];
        
    }else{//当前为房间人数
        if ([roomNumberLabel.text intValue] <= 1) {
            XWAlerLoginView *xw = [[XWAlerLoginView alloc]initWithTitle:@"不能再减了~"];
            [xw show];
            return;
        }
        button.enabled = NO;
        roomSubBtn.enabled = NO;
        addBtn.enabled = NO;
        subBtn.enabled = NO;
        self.addAndSubLabel.frame = roomNumberLabel.frame;
        self.addAndSubLabel.text = roomNumberLabel.text;
        self.addAndSubLabelTwo.frame = CGRectMake(roomNumberLabel.x, roomNumberLabel.y - 50, roomNumberLabel.width, roomNumberLabel.height);
        self.addAndSubLabelTwo.text = [NSString stringWithFormat:@"%d",[roomNumberLabel.text intValue] - 1];
        self.addAndSubLabelTwo.alpha = 0.0;
        roomNumberLabel.text = @"";
        [roomNumberView addSubview:self.addAndSubLabel];
        [roomNumberView addSubview:self.addAndSubLabelTwo];
        [UIView animateWithDuration:0.5 animations:^{
            self.addAndSubLabel.y += 50;
            self.addAndSubLabel.alpha = 0.0;
            self.addAndSubLabelTwo.y += 50;
            self.addAndSubLabelTwo.alpha = 1.0;
        } completion:^(BOOL finished) {
            roomNumberLabel.text = self.addAndSubLabelTwo.text;
            [self.addAndSubLabel removeFromSuperview];
            [self.addAndSubLabelTwo removeFromSuperview];
            self.addAndSubLabel = nil;
            self.addAndSubLabelTwo = nil;
            button.enabled = YES;
            roomSubBtn.enabled = YES;
            addBtn.enabled = YES;
            subBtn.enabled = YES;
        }];
    }
}
#pragma mark - 设置首页的控件
- (void)setupHomeView
{
    //TODO:模块
    UIView *locationView = [self setupLocationView];
    UIView *dateView = [self setupDateView:locationView];
    UIView *numberView = [self setupNumView:dateView];
    [self setupTypeView:numberView];
    
    _nextBtn = [[UIButton alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 50) * 0.5, SCREEN_HEIGHT - 50 - 10 - 64, 50, 50)];
    _nextBtn.alpha = 1.0;
    [_nextBtn setImage:@"下一步"];
    [_nextBtn addTarget:self action:@selector(next)];
    [self.view addSubview:_nextBtn];
    
    _backBtn = [[UIButton alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 50) * 0.5 - 100, SCREEN_HEIGHT - 50 - 10 - 64, 50, 50)];
    _backBtn.alpha = 0.0;
    [_backBtn setImage:@"上一步"];
    [_backBtn addTarget:self action:@selector(back)];
    [self.view addSubview:_backBtn];
}
/*
 * 定位模块
 */
- (UIView *)setupLocationView
{
    UIView *locationView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 60)];
    [self.view addSubview:locationView];
    
    UIView *devider = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.5)];
    devider.backgroundColor = AppLightGrayLineColor;
    [locationView addSubview:devider];
    
    UIImageView *addressIconView = [[UIImageView alloc] init];
    addressIconView.image = [UIImage imageNamed:@"地标"];
    addressIconView.frame = CGRectMake(10, 15, 30, 30);
    addressIconView.contentMode = UIViewContentModeCenter;
    [locationView addSubview:addressIconView];
    
    UIView *deviderOne = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(addressIconView.frame) + 5, 20, 0.5, 20)];
    deviderOne.backgroundColor = AppLightGrayLineColor;
    [locationView addSubview:deviderOne];
    
    UITapGestureRecognizer *locationTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(locationTap)];
    [locationView addGestureRecognizer:locationTap];
    
    addressContentLabel = [[UILabel alloc] init];
    addressContentLabel.text = @"厦门市思明区，何厝下何300号";
    addressContentLabel.textColor = [UIColor blackColor];
    addressContentLabel.numberOfLines = 0;
    addressContentLabel.textColor = AppDeepGrayTextColor;
    [addressContentLabel setAppFontWithSize:15];
    addressContentLabel.userInteractionEnabled = YES;
    addressContentLabel.frame = CGRectMake(CGRectGetMaxX(deviderOne.frame) + 5, 5, SCREEN_WIDTH - SCREEN_WIDTH * 0.2 - CGRectGetMaxX(addressIconView.frame) - 20 - 50, 50);
    [locationView addSubview:addressContentLabel];
    [addressContentLabel addGestureRecognizer:locationTap];
    
    UIImageView *rightArrow = [[UIImageView alloc] init];
    rightArrow.image = [UIImage imageNamed:@"箭头"];
    rightArrow.userInteractionEnabled = NO;
    rightArrow.frame = CGRectMake(CGRectGetMaxX(addressContentLabel.frame), 15, 30, 30);
    rightArrow.contentMode = UIViewContentModeCenter;
    [locationView addSubview:rightArrow];
    
    UIView *deviderTwo = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(rightArrow.frame) + 5, 20, 0.5, 20)];
    deviderTwo.backgroundColor = AppLightGrayLineColor;
    [locationView addSubview:deviderTwo];
    
    UITapGestureRecognizer *myAddressTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(myAddressTap)];
    
//    UITapGestureRecognizer *addressIconTwoViewTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(myAddressTap)];
    
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
    addressIconTwoView.image = [UIImage imageNamed:@"我的位置"];
    addressIconTwoView.userInteractionEnabled = YES;
    addressIconTwoView.frame = CGRectMake(myAddress.x, 0, 80, 40);
    addressIconTwoView.contentMode = UIViewContentModeCenter;
    [locationView addSubview:addressIconTwoView];
    [addressIconTwoView addGestureRecognizer:myAddressTap];
    
    UIView *deviderThree = [[UIView alloc] initWithFrame:CGRectMake(20, 59.5, SCREEN_WIDTH - 40, 0.5)];
    deviderThree.backgroundColor = AppLightGrayLineColor;
    [locationView addSubview:deviderThree];

    return locationView;
}
/*
 * 日期模块
 */
- (UIView *)setupDateView:(UIView *)locationView
{
    UITapGestureRecognizer *tapStarDate = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapStarDate)];
    UITapGestureRecognizer *tapEndDate = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapEndDate)];
    UIView *dateView = [[UIView alloc] init];
    dateView.frame = CGRectMake(0, CGRectGetMaxY(locationView.frame), SCREEN_WIDTH, 70);
    [self.view addSubview:dateView];
    
    UIImageView *clockImage = [[UIImageView alloc] init];
    clockImage.image = [UIImage imageNamed:@"时间"];
    clockImage.frame = CGRectMake(10, 12.5, 45, 45);
    clockImage.contentMode = UIViewContentModeCenter;
    [dateView addSubview:clockImage];
    
    NSDate *date = [NSDate date];
    NSDate *nextDay = [NSDate dateWithTimeInterval:24*60*60 sinceDate:date];//下一天
    self.startDateString = [RTHttpTool GetTodayDay:[NSDate date] formatType:FormatTypeRung];
    self.endDateString = [RTHttpTool GetTomorrowDay:[NSDate date] formatType:FormatTypeRung];
    
    starDate = [[UILabel alloc] init];
    starDate.userInteractionEnabled = YES;
    [starDate addGestureRecognizer:tapStarDate];
    starDate.text = [NSString stringWithFormat:@"入住\n%@",[date stringWithFormat:@"yyy年MM月dd日"]];
    starDate.textAlignment = NSTextAlignmentCenter;
    starDate.userInteractionEnabled = YES;
    starDate.numberOfLines = 0;
    starDate.textColor = AppDeepGrayTextColor;
    starDate.font = [UIFont systemFontOfSize:13];
    starDate.frame = CGRectMake(CGRectGetMaxX(clockImage.frame) + 5, 0, (SCREEN_WIDTH - 40 - 40 - 40 - 30 - 5 - 5) * 0.5, 60);
    [dateView addSubview:starDate];
    
    UIImageView *slash = [[UIImageView alloc] init];
    slash.image = [UIImage imageNamed:@"斜线"];
    slash.frame = CGRectMake(CGRectGetMaxX(starDate.frame), 0, 40, 70);
    slash.contentMode = UIViewContentModeCenter;
    [dateView addSubview:slash];

    endDate = [[UILabel alloc] init];
    endDate.userInteractionEnabled = YES;
    [endDate addGestureRecognizer:tapEndDate];
    endDate.text = [NSString stringWithFormat:@"离店\n%@",[nextDay stringWithFormat:@"yyy年MM月dd日"]];
    endDate.textAlignment = NSTextAlignmentCenter;
    endDate.userInteractionEnabled = YES;
    endDate.numberOfLines = 0;
    endDate.textColor = AppDeepGrayTextColor;
    endDate.font = [UIFont systemFontOfSize:13];
    endDate.frame = CGRectMake(CGRectGetMaxX(slash.frame), 0, (SCREEN_WIDTH - 40 - 40 - 40 - 30 - 5 - 5) * 0.5, 60);
    [dateView addSubview:endDate];
    
    UIImageView *rightArrow = [[UIImageView alloc] init];
    rightArrow.image = [UIImage imageNamed:@"箭头"];
    rightArrow.frame = CGRectMake(SCREEN_WIDTH - 20 - 30, 20, 30, 30);
    rightArrow.contentMode = UIViewContentModeCenter;
    [dateView addSubview:rightArrow];
    
    UIView *devider = [[UIView alloc] initWithFrame:CGRectMake(20, 69.5, SCREEN_WIDTH - 40, 0.5)];
    devider.backgroundColor = AppLightGrayLineColor;
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
    peopleNumberView = [[UIView alloc] init];
    peopleNumberView.backgroundColor = [UIColor clearColor];
    peopleNumberView.frame = CGRectMake(0, 0, SCREEN_WIDTH * 0.5, 100);
    [numView addSubview:peopleNumberView];
    
    peopleTitleLabel = [[UILabel alloc] init];
    peopleTitleLabel.textAlignment = NSTextAlignmentCenter;
    peopleTitleLabel.textColor = HEXCOLOR(0x323232);
    peopleTitleLabel.font = [UIFont systemFontOfSize:16];
    peopleTitleLabel.frame = CGRectMake(0, 5, SCREEN_WIDTH * 0.5, 30);
    [peopleNumberView addSubview:peopleTitleLabel];
    
    addBtn = [[UIButton alloc] init];
    addBtn.frame = CGRectMake((SCREEN_WIDTH*0.5 - 20 - 60 - 50)*0.5, 35, 30, 30);
    [addBtn setBackgroundImage:[UIImage imageNamed:@"＋"] forState:UIControlStateNormal];
    [addBtn setBackgroundImage:[UIImage imageNamed:@"＋点击状态"] forState:UIControlStateHighlighted];
    [addBtn addTarget:self action:@selector(addBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [peopleNumberView addSubview:addBtn];
    
    numberLabel = [[UILabel alloc] init];
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
    
    subBtn = [[UIButton alloc] init];
    subBtn.frame = CGRectMake(CGRectGetMaxX(numberLabel.frame)+10, 35, 30, 30);
    [subBtn setBackgroundImage:[UIImage imageNamed:@"－"] forState:UIControlStateNormal];
    [subBtn setBackgroundImage:[UIImage imageNamed:@"－点击状态"] forState:UIControlStateHighlighted];
    [subBtn addTarget:self action:@selector(subBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [peopleNumberView addSubview:subBtn];

    //分割线
    UIView *devider = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH * 0.5 - 0.5, 0, 0.5, 80)];
    devider.backgroundColor = AppLightGrayLineColor;
    [numView addSubview:devider];
    
    //房间数量
    roomNumberView = [[UIView alloc] init];
    roomNumberView.backgroundColor = [UIColor clearColor];
    roomNumberView.frame = CGRectMake(SCREEN_WIDTH * 0.5, 0, SCREEN_WIDTH * 0.5, 100);
    [numView addSubview:roomNumberView];
    
    roomTitleLabel = [[UILabel alloc] init];
    roomTitleLabel.textAlignment = NSTextAlignmentCenter;
    roomTitleLabel.textColor = HEXCOLOR(0x323232);
    roomTitleLabel.font = [UIFont systemFontOfSize:16];
    roomTitleLabel.frame = CGRectMake(0, 5, SCREEN_WIDTH * 0.5, 30);
    [roomNumberView addSubview:roomTitleLabel];
    
    roomAddBtn = [[UIButton alloc] init];
    roomAddBtn.frame = CGRectMake((SCREEN_WIDTH*0.5 - 20 - 60 - 50)*0.5, 35, 30, 30);
    [roomAddBtn setBackgroundImage:[UIImage imageNamed:@"＋"] forState:UIControlStateNormal];
    [roomAddBtn setBackgroundImage:[UIImage imageNamed:@"＋点击状态"] forState:UIControlStateHighlighted];
    [roomAddBtn addTarget:self action:@selector(addBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [roomNumberView addSubview:roomAddBtn];
    
    roomNumberLabel = [[UILabel alloc] init];
    roomNumberLabel.text = @"1";
    roomNumberLabel.textColor = AppDeepGrayTextColor;
    roomNumberLabel.layer.cornerRadius = 5;
    roomNumberLabel.layer.masksToBounds = YES;
    roomNumberLabel.textAlignment = NSTextAlignmentCenter;
    roomNumberLabel.font = [UIFont systemFontOfSize:15];
    roomNumberLabel.frame = CGRectMake(CGRectGetMaxX(roomAddBtn.frame)+10, 35, 50, 30);
    roomNumberLabel.layer.borderWidth = 1;
    roomNumberLabel.layer.borderColor = AppLightGrayLineColor.CGColor;
    [roomNumberView addSubview:roomNumberLabel];
    
    roomSubBtn = [[UIButton alloc] init];
    roomSubBtn.frame = CGRectMake(CGRectGetMaxX(roomNumberLabel.frame)+10, 35, 30, 30);
    [roomSubBtn setBackgroundImage:[UIImage imageNamed:@"－"] forState:UIControlStateNormal];
    [roomSubBtn setBackgroundImage:[UIImage imageNamed:@"－点击状态"] forState:UIControlStateHighlighted];
    [roomSubBtn addTarget:self action:@selector(subBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [roomNumberView addSubview:roomSubBtn];
    
    if (_homeType == SelectedHomeTypeHotel) {
        peopleTitleLabel.text = @"客官人数";
        roomTitleLabel.text = @"房间数量";
    }else{
        peopleTitleLabel.text = @"唱客人数";
        roomTitleLabel.text = @"包厢数量";
    }
    
    return numView;
}
/*
 * 类型模块
 */
- (UIView *)setupTypeView:(UIView *)numberView
{
    UIView *typeView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(numberView.frame) + 20, SCREEN_WIDTH, 200)];
    [self.view addSubview:typeView];
    
    for (int i = 0; i<3; i++) {
        UITapGestureRecognizer *typeTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(typeTap:)];
        
        UIView *typeV = [[UIButton alloc] initWithFrame:CGRectMake(10 + i*((SCREEN_WIDTH - 40)/3 + 10), 0, (SCREEN_WIDTH - 40)/3, 90)];
        typeV.layer.cornerRadius = 5;
        typeV.layer.borderWidth = 0.5;
        typeV.layer.borderColor = AppLightGrayLineColor.CGColor;
        [typeView addSubview:typeV];
        typeV.userInteractionEnabled = YES;
        [typeV addGestureRecognizer:typeTap];
        [self.typeArray addObject:typeV];
        
        UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(((SCREEN_WIDTH - 40)/3 - 40)*0.5, 10, 40, 40)];
        imageView.contentMode = UIViewContentModeCenter;
        imageView.image = [UIImage imageNamed:self.typeDataArray[i]];
        [typeV addSubview:imageView];
        [self.typeImageViewArray addObject:imageView];
        
        UILabel *typeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 45, (SCREEN_WIDTH - 40)/3, 30)];
        typeLabel.textAlignment = NSTextAlignmentCenter;
        typeLabel.text = self.typeDataArray[i];
        typeLabel.tag = i;
        typeLabel.textColor = AppDeepGrayTextColor;
        [typeLabel setAppFontWithSize:16];
        [typeV addSubview:typeLabel];
        [self.typeLabelArray addObject:typeLabel];
        
    }
    
    UIView *devider = [[UIView alloc] initWithFrame:CGRectMake(20, 90, SCREEN_WIDTH - 60, 0.5)];
    devider.alpha = 0.0;
    devider.backgroundColor = AppLightGrayLineColor;
    [typeView addSubview:devider];
    self.devider = devider;
    
    for (int i = 0; i<3; i++) {
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(i*((SCREEN_WIDTH)/3), 40 + 90, (SCREEN_WIDTH - 20)/3, 30)];
        [button setTitle:self.roomTypeDataArray[i] forState:UIControlStateNormal];
        [button setTitleColor:AppLightGrayTextColor forState:UIControlStateNormal];
        [button addTarget:self action:@selector(roomTypeSelected:)];
        [button.titleLabel setAppFontWithSize:15];
        [button setTitleColor:AppDeepGrayTextColor forState:UIControlStateSelected];
        button.alpha = 0.0;
        if (i == 0) {
            button.selected = YES;
        }
        [typeView addSubview:button];
        [self.roomTypeArray addObject:button];
        if (i < 2) {
            UIView *deviderButton = [[UIView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 20)/3 - 0.5, 5, 0.5, 20)];
            deviderButton.backgroundColor = AppDeepGrayTextColor;
            [button addSubview:deviderButton];
        }
    }
    return typeView;
}
#pragma mark -- CLLocationDelegate
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    RTLog(@"%@",locations.firstObject);
    // 数组里面存放的是CLLocation对象， 一个CLLocation就代表一个位置
    CLLocation *location = [locations lastObject];
    
    RTLog(@"location---%@",location);
    
    //存储用户坐标
    if (locations) {
        //获取对应经纬度
        self.lon = location.coordinate.longitude;
        self.lat = location.coordinate.latitude;
        
        [self.geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
            //获取地理位置信息字符串
            CLPlacemark *firstPlacemark = [placemarks firstObject];
            Xzb_ApplicationData *data = [Xzb_ApplicationDataTool account];
            if (data.userAddress.length) {
                addressContentLabel.text = data.userAddress;
            }else{
                addressContentLabel.text = [NSString stringWithFormat:@"%@",firstPlacemark.name];
            }
            
//            self.cityName = firstPlacemark.locality;
//            [[MyAlert make] hideHUD];
            if (firstPlacemark.name == nil) {
                addressContentLabel.text = @"您当前网络不好，请点击“我的位置”重新定位，获取酒店类型";
                [[Toast makeText:@"请点击“我的位置”重新定位"] show];
            }
            
        }];
        
    }
    
    // 停止更新位置(不用定位服务，应当马上停止定位，非常耗电)
    [manager stopUpdatingLocation];
}
#pragma mark - mapVC delegate
- (void)chooseLocationWithString:(NSString *)locationString
{
    addressContentLabel.text = locationString;
}


@end
