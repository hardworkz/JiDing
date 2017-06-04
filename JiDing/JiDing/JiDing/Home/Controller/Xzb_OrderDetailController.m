//
//  Xzb_OrderDetailController.m
//  xzb
//
//  Created by 张荣廷 on 16/7/26.
//  Copyright © 2016年 xuwk. All rights reserved.
//

#import "Xzb_OrderDetailController.h"
#import "Xzb_PayInputPasswordView.h"
#import <MapKit/MapKit.h>
#import "AppDelegate.h"

#define CELL_NORMAL_H 48;
@interface Xzb_OrderDetailController ()<PayDelegate, UITableViewDelegate, UITableViewDataSource,DQAlertViewDelegate>
{
    CustomAlertView *alert;
}
@property (nonatomic,weak)  UIWebView *webView;
@property (nonatomic,weak)  Xzb_PayInputPasswordView *inputView;
@property (nonatomic,assign)  CGFloat headCellHeight;
@property (nonatomic,strong) Xzb_OrderDetailsModel *model;
@property (nonatomic,strong) OrderInfo *orderInfo;
/**
 *  地图导航
 */
@property (nonatomic, strong) CLGeocoder *geocoder;
@property (nonatomic, strong) MKPlacemark *sourceMKPm;
@property (nonatomic, strong) MKPlacemark *destinationMKPm;
@property (nonatomic, strong) CLLocation *sourcePm;
@property (nonatomic, strong) CLLocation *destinationPm;
/**
 *  支付管理类
 */
@property (nonatomic,strong)  PayUtils *pay;
@property (nonatomic,strong) WXApiManager *wxmanager;
@property (nonatomic,strong) NSString *payResultStr;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSString *balance;

@property (nonatomic,weak)  UIButton *refundButton;
@end

@implementation Xzb_OrderDetailController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    _pay.delegate = self;
    
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.pay.delegate = nil;
}
- (void)back_clicked
{
    if (self.isPopRootVC) {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}
#pragma mark - viewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];
    //关闭手势返回
    self.fd_interactivePopDisabled = YES;
    
    UIWebView *webView = [[UIWebView alloc] init];
    webView.frame = CGRectZero;
    [self.view addSubview:webView];
    self.webView = webView;
    
    //创建充值对象类
    PayUtils *pay = [PayUtils sharedUtils];
    self.pay = pay;
    //微信支付manager
    WXApiManager *manager = [WXApiManager sharedManager];
    manager.payDelegate = self;
    self.wxmanager = manager;
    
    //设置导航栏标题
    self.title = @"确认订单";
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, SCREEN_Height - 64)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = AppLightLineColor;
    [self.view addSubview:_tableView];
    
    //通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(functionClicked:) name:OrderDetailCellFunctionClickedNotification object:nil];
    
    [self setupDetailData];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setupDetailData) name:checkinNotification object:nil];
    
    [self listenKeyboard];
}
#pragma mark - 键盘
-(void)listenKeyboard{
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHiden:) name:UIKeyboardWillHideNotification object:nil];
    
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.enable = NO;
}

-(void)keyboardWillShow:(NSNotification*)noti{
    
    AppDelegate* delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    CGRect rect =[delegate.window convertRect:[noti.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue] toView:self.view];
    
    CGFloat height = self.view.bounds.size.height-rect.size.height;
    
    CGFloat time =[noti.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
    int curve =[noti.userInfo[UIKeyboardAnimationCurveUserInfoKey] floatValue];
    
    [UIView setAnimationCurve:curve];
    [UIView animateWithDuration:time animations:^{
        
        self.inputView.y = height - 190;
    }];
    
}
-(void)keyboardWillHiden:(NSNotification*)noti{
    
    CGFloat time =[noti.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
    int curve =[noti.userInfo[UIKeyboardAnimationCurveUserInfoKey] floatValue];
    
    [UIView setAnimationCurve:curve];
    [UIView animateWithDuration:time animations:^{
        
        self.inputView.y = SCREEN_Height;
        
    } completion:^(BOOL finished) {
        [self.inputView coverClick];
    }];
}
#pragma mark - 获取数据

- (void)functionClicked:(NSNotification *)note
{
    NSDictionary *dict = note.userInfo;
    if ([dict[@"buttonTag"] intValue] == 10) {//详情页面跳转
        if (!self.model.orderId) {
            return;
        }
        Xzb_HotelDetailController *hotelDetail = [[Xzb_HotelDetailController alloc] init];
        hotelDetail.orderID = self.model.orderId;
        hotelDetail.view.backgroundColor = AppMainBgColor;
        [self.navigationController pushViewController:hotelDetail animated:YES];
    }else if ([dict[@"buttonTag"] intValue] == 11){//电话
        [self hotelPhoneCall];
    }else{//导航
        [self navigationClick];
    }
}
/**
 *  拨打酒店客服电话
 */
- (void)hotelPhoneCall
{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",self.model.mainTel]];
    [self.webView loadRequest:[NSURLRequest requestWithURL:url]];
}

- (void)setupDetailData
{
    UserAccount *account = [UserAccountTool account];
    @WeakObj(self);
    [RTHttpTool get:GET_BY_ORDER_DETAIL_ID addHUD:YES param:@{ORDERID:self.orderID,USERID:account.userId,TOKEN:account.loginToken} success:^(id responseObj) {
        NSLog(@"%@",responseObj);
        if ([responseObj[SUCCESS] intValue] == 1) {
            Xzb_OrderDetailsModel *model = [Xzb_OrderDetailsModel mj_objectWithKeyValues:responseObj[ENTITIES][@"orderInfo"]];
            selfWeak.model = model;
            
            OrderInfo *orderInfo = [[OrderInfo alloc] init];
            orderInfo.orderCode = model.orderCode;
            orderInfo.orderDescription = model.descriptions;
            orderInfo.orderName = model.businessName;
            orderInfo.orderPrice = model.realPrice;
            
            selfWeak.orderInfo = orderInfo;
            
            [selfWeak setupdestinationPm];
            
            [selfWeak.tableView reloadData];
            
            int i = [model.orderStatus intValue];
            switch (i) {
                case 2:
                    if (model.cancleEnable) {
                        [selfWeak setupBottomBarWithRefund];
                    }
                    break;
                case 1:
                    [selfWeak setupBottomBarWithPayOrCancleOrder];
                    break;
                    
                default:
                    break;
            }
            int j = [model.checkinStatus intValue];
            switch (j) {
                case 3: case 4:
                {
                    RTLog(@"入住状态为：%zd",[model.orderStatus integerValue]);
                    if ([model.orderStatus integerValue] == 3 || [model.orderStatus integerValue] == -3) {
                        break;
                    }else {
                        [selfWeak setupBottomBarWithGoComment];
                    }
                    break;
                }
                default:
                    break;
            }
        }
    } failure:^(NSError *error) {
        RTLog(@"%@",error);
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 6;
    }else if (section == 1){
        return 1;
    }else{
        return 3;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    Xzb_OrderDetailCell *cell;
    cell =[Xzb_OrderDetailCell cellWithTableView:tableView];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (indexPath.section == 0) {
//        if (indexPath.row == 0) {
//            Xzb_OrderDetailHeadCell *cell = [Xzb_OrderDetailHeadCell cellWithTableView:tableView];
//            cell.selectionStyle = UITableViewCellSelectionStyleNone;
//            cell.model = self.model;
//            self.headCellHeight = cell.cellHeight;
//            return cell;
//        }else
            if (indexPath.row == 0){
            Xzb_HotelNameCell *cell = [Xzb_HotelNameCell cellWithTableView:tableView];
            cell.hotelNameLabel.text = self.model.businessName;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }else if (indexPath.row == 1){
            cell.contentLabel.text = @"付款方式";
            cell.iconImageView.image = [UIImage imageNamed:@"付款方式"];
            if ([self.model.payType intValue] == 1) {
                cell.accessoryLabel.text = @"预付";
            }else if ([self.model.payType intValue] == 2){
                cell.accessoryLabel.text = @"担保交易";
            }else if ([self.model.payType intValue] == 3){
                cell.accessoryLabel.text = @"到付";
            }
            cell.accessoryLabel.textColor = AppGreenBtnColor;
            return cell;
        }else if (indexPath.row == 2){
            cell.contentLabel.text = self.model.roomName;
            cell.iconImageView.image = [UIImage imageNamed:@"豪华大床房1"];
            cell.accessoryLabel.text = [NSString stringWithFormat:@"¥%@",self.model.price?self.model.price:@"0.00"];
            cell.accessoryLabel.textColor = AppMainColor;
            return cell;
        }else
            if(indexPath.row == 3){
            NSString *string;
//            if ([self.model.couponMoney isEqualToString:@""]||[self.model.couponMoney floatValue] == 0) {
                string = @"2017-05-08";
                cell.accessoryLabel.textColor = AppGrayTextColor;
//            }else {
//                string = [NSString stringWithFormat:@"-¥%@", self.model.couponMoney];
//                cell.accessoryLabel.textColor = AppMainColor;
//            }
            
            cell.contentLabel.text = @"订单号：6666666666666666666";
            cell.iconImageView.image = [UIImage imageNamed:@"返现券1"];
            cell.accessoryLabel.text = string;
            
            return cell;
        }else
//            if (indexPath.row == 3){
//            
//            cell.contentLabel.text = @"实付款";
//            cell.iconImageView.image = [UIImage imageNamed:@"实付款"];
//            cell.accessoryLabel.text = [NSString stringWithFormat:@"¥%@",self.model.realPrice?self.model.realPrice:@"0.00"];
//            cell.accessoryLabel.textColor = AppMainColor;
//            
//            return cell;
//        }else
//            if (indexPath.row == 6){
//            Xzb_PayIntroTableViewCell *cell = [Xzb_PayIntroTableViewCell cellWithTableView:tableView];
//            cell.selectionStyle = UITableViewCellSelectionStyleNone;
//            return cell;
//        }else
            if (indexPath.row == 4){
            Xzb_TimeTableViewCell *cell = [Xzb_TimeTableViewCell cellWithTableView:tableView];
            cell.model = self.model;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }else if (indexPath.row == 5){
            Xzb_FunctionTableViewCell *cell = [Xzb_FunctionTableViewCell cellWithTableView:tableView];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
    }else if (indexPath.section == 1){
        Xzb_fillOrderCheckManCell *cell = [Xzb_fillOrderCheckManCell cellWithTableView:tableView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.name.placeholder = @"";
        NSArray *userInfo = self.model.userInfoArray;
        //        Xzb_CheckInPeopleModel *guestModel =self.model.guestInfoList.firstObject;
        if (userInfo.count == 2) {
            cell.name.text = userInfo[0];
            cell.phone.text = userInfo[1];
        }
        cell.phone.userInteractionEnabled = NO;
        cell.name.userInteractionEnabled = NO;
        return cell;
    }else{
        if (indexPath.row == 0) {
            UserAccount *account = [UserAccountTool account];
            cell.contentLabel.text = @"联系电话";
            cell.iconImageView.image = [UIImage imageNamed:@"联系电话"];
            cell.accessoryLabel.text = account.mobile;
            cell.accessoryLabel.textColor = [UIColor lightGrayColor];
            return cell;
        }else if (indexPath.row == 1) {
            cell.contentLabel.text = @"到店时间";
            cell.iconImageView.image = [UIImage imageNamed:@"到店时间"];
            cell.accessoryLabel.text = [self.model.arriveTime isEqualToString:@"20:00:00之前"]?@"整晚保留":self.model.arriveTime;
            cell.accessoryLabel.textColor = [UIColor lightGrayColor];
            return cell;
        }else if (indexPath.row == 2) {
            cell.contentLabel.text = @"其他要求";
            cell.iconImageView.image = [UIImage imageNamed:@"其他要求"];
            if ([self.model.remark isEqualToString:@""]) {
                cell.accessoryLabel.text = @"无";
            }else{
                cell.accessoryLabel.text = self.model.remark;
            }
            cell.accessoryLabel.textColor = [UIColor lightGrayColor];
            return cell;
        }
    }
    
    return cell;
}
#pragma mark - table view delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            return self.headCellHeight;
        }else if (indexPath.row == 1){
            return CELL_NORMAL_H;
        }else if (indexPath.row == 2){
            return CELL_NORMAL_H;
        }else if (indexPath.row == 3){
            return CELL_NORMAL_H;
        }else if (indexPath.row == 4){
            return CELL_NORMAL_H;
        }else if (indexPath.row == 5){
            return CELL_NORMAL_H;
        }else if (indexPath.row == 6){
            return 70;
        }else if (indexPath.row == 7){
            return 60;
        }else if (indexPath.row == 8){
            return 60;
        }
        return CELL_NORMAL_H;
    }else if (indexPath.section == 1){
        return 90;
    }else{
        return CELL_NORMAL_H;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor clearColor];
    return view;
}
#pragma mark - 支付和取消的底部导航条
/**
 *  设置确认付款和取消订单的导航条(未付款状态)
 */
- (void)setupBottomBarWithPayOrCancleOrder
{
    //    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 49, 0);
    self.tableView.frame = CGRectMake(0, 0, SCREEN_Width, SCREEN_Height - 49 - 64);
    
    UIView *bottomBar = [[UIView alloc] init];
    bottomBar.backgroundColor = [UIColor redColor];
    bottomBar.frame = CGRectMake(0, SCREEN_Height - 49 - 64, SCREEN_Width, 49);
    [self.view addSubview:bottomBar];
    
    //取消订单
//    UIButton *cancleOrderButton = [[UIButton alloc] init];
//    cancleOrderButton.frame = CGRectMake(0, 0, ScreenWidth * 0.5, 49);
//    cancleOrderButton.backgroundColor = [UIColor blackColor];
//    [cancleOrderButton setTitle:@"取消订单" forState:UIControlStateNormal];
//    [cancleOrderButton addTarget:self action:@selector(cancleNotification) forControlEvents:UIControlEventTouchUpInside];
//    [bottomBar addSubview:cancleOrderButton];
    
    //分割线
    UIView *devider = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.5)];
    devider.backgroundColor = AppLightLineColor;
    
    //确认支付按钮
    UIButton *payButton = [[UIButton alloc] init];
    payButton.frame = CGRectMake(0, 0, ScreenWidth * 0.5, 49);
//    payButton.backgroundColor = AppMainColor;
    [payButton setTitle:@"立即付款" forState:UIControlStateNormal];
    [payButton setTitleColor:AppGreenTextColor forState:UIControlStateNormal];
    [payButton addTarget:self action:@selector(payButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [payButton addSubview:devider];
    [bottomBar addSubview:payButton];
}

#pragma mark - 支付弹窗
- (void)payButtonClicked
{
//    Xzb_PayTypeView *view = [[Xzb_PayTypeView alloc] init];
//    UserAccount *account = [UserAccountTool account];
//    view.buttonZero.hidden = NO;
//    [view.buttonZero setTitle:[NSString stringWithFormat:@"余额（¥%.2f）",[_balance floatValue]] forState:UIControlStateNormal];
//    [RTHttpTool get:GET_ACCOUNT_MONEY addHUD:NO param:@{USERID:account.userId,TOKEN:account.loginToken} success:^(id responseObj) {
//        id json = [RTHttpTool jsonWithResponseObj:responseObj];
//        if ([json[SUCCESS] intValue] == 1) {
//            _balance = json[ENTITIES][@"map"][@"available_money"];
//            
//            if ([_balance doubleValue] >= [_model.realPrice doubleValue]) {
//                [view.buttonZero setTitle:[NSString stringWithFormat:@"余额（¥%.2f）",[_balance floatValue]] forState:UIControlStateNormal];
//                [view.buttonZero setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//                view.buttonZero.userInteractionEnabled = YES;
//            }else {
//                [view.buttonZero setTitle:[NSString stringWithFormat:@"余额（¥%.2f）",[_balance floatValue]] forState:UIControlStateNormal];
//                [view.buttonZero setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
//                view.buttonZero.userInteractionEnabled = NO;
//            }
//        }
//    } failure:^(NSError *error) {
//        
//    }];
//    
//    [view.buttonZero setTitleColor:Color(68, 68, 68) forState:UIControlStateNormal];
//    [view.buttonOne setTitle:@"支付宝支付" forState:UIControlStateNormal];
//    [view.buttonOne setTitleColor:Color(68, 68, 68) forState:UIControlStateNormal];
//    [view.buttonTwo setTitle:@"微信支付" forState:UIControlStateNormal];
//    [view.buttonTwo setTitleColor:Color(68, 68, 68) forState:UIControlStateNormal];
//    [view.cancle setTitleColor:Color(68, 68, 68) forState:UIControlStateNormal];
//    __weak typeof(view) weakView = view;
//    @WeakObj(self)
//    view.balancePay = ^{ // 余额支付
//        [weakView coverClick];
//        if (selfWeak.orderInfo) {
//            [selfWeak Notification];
//        }
//        
//    };
//    
//    view.PhotoOption = ^{//支付宝
//        [weakView coverClick];
//        if (selfWeak.orderInfo) {
//            [selfWeak setupAlipayWithOrderInfo:self.orderInfo];
//        }
//    };
//    view.LibraryOption = ^{//微信
//        [weakView coverClick];
//        if ([WXApi isWXAppInstalled]) {
//            if (selfWeak.orderInfo) {
//                [selfWeak setupWXpayWithOrderInfo:self.orderInfo];
//            }
//        }else{
//            //弹窗提示
//            [self setupWXGoToDownload];
//        }
//        
//    };
//    
//    [view show];
    
    alert = [[CustomAlertView alloc] initWithCustomView:[self payAlertView]];
    alert.height = 200;
    alert.alertDuration = 0.5;
    alert.coverAlpha = 0.5;
    [alert show];
}
- (UIView *)payAlertView
{
    UIView *payView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 200)];
    payView.backgroundColor = [UIColor whiteColor];
    
    //取消按钮
    UIButton *cancel = [[UIButton alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 50)*0.5, 0, 50, 30)];
    [cancel addTarget:self action:@selector(cancelClicked)];
    [cancel setImage:@"向下箭头"];
    cancel.imageView.contentMode = UIViewContentModeCenter;
    [payView addSubview:cancel];
    
    //文字说明
    UILabel *tip = [[UILabel alloc] initWithFrame:CGRectMake(0, 30, SCREEN_WIDTH, 20)];
    tip.text = @"选择付款方式";
    tip.textAlignment = NSTextAlignmentCenter;
    [tip setAppFontWithSize:15.0];
    [payView addSubview:tip];
    
    for (int i = 0; i<3; i++) {
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/3 * i, (150 - SCREEN_WIDTH/3) * 0.5, SCREEN_WIDTH/3, SCREEN_WIDTH/3 - 20)];
        [button addTarget:self action:@selector(payClicked)];
        button.imageView.contentMode = UIViewContentModeCenter;
        [payView addSubview:button];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(button.frame), CGRectGetMaxY(button.frame), SCREEN_WIDTH/3, 20)];
        label.textAlignment = NSTextAlignmentCenter;
        [tip setAppFontWithSize:16.0];
        if (i == 0) {
            [button setImage:@"银联支付"];
            label.text = @"银联支付";
            //分割线
            UIView *devider = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/3 - 1, 0, 1, SCREEN_WIDTH/3)];
            devider.backgroundColor = AppLightLineColor;
            [button addSubview:devider];
        }else if (i == 1) {
            [button setImage:@"微信支付"];
            label.text = @"微信";
        }else if (i == 2) {
            [button setImage:@"支付宝支付"];
            label.text = @"支付宝";
        }
    }
    
    return payView;
}
//取消支付弹窗
- (void)cancelClicked
{
    [alert coverClick];
}
//选择支付方式调用
- (void)payClicked
{
}
- (void)setupWXGoToDownload
{
    //弹窗提示
    DQAlertView * alertView = [[DQAlertView alloc] initWithTitle:@"提示" message:@"您还没有安装微信，请先下载微信客户端" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"去下载", nil];
    [alertView.cancelButton setTitleColor:AppMainGrayTextColor forState:UIControlStateNormal];
    [alertView.otherButton setTitleColor:AppMainColor forState:UIControlStateNormal];
    [alertView show];
}
#pragma mark - 取消订单
- (void)cancleNotification
{
    DQAlertView * alertView = [[DQAlertView alloc] initWithTitle:@"确认取消订单？" message:@"" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alertView.cancelButton setTitleColor:AppMainColor forState:UIControlStateNormal];
    [alertView.otherButton setTitleColor:AppMainGrayTextColor forState:UIControlStateNormal];
    [alertView show];
}



- (void)cancleOrderButtonClicked
{
    UserAccount *account = [UserAccountTool account];
    NSDictionary *dic = @{ID:self.orderID,USERID:account.userId,TOKEN:account.loginToken};
    @WeakObj(self);
    [RTHttpTool post:CANCLE_ORDER addHUD:NO param:dic success:^(id responseObj) {
        NSLog(@"%@",responseObj);
        if ([responseObj[SUCCESS] intValue] == 1) {
            [[Toast makeText:responseObj[MESSAGE]] show];
            if (selfWeak.cancleOrder) {
                selfWeak.cancleOrder();
                [self.navigationController popViewControllerAnimated:YES];
            }else {
                [self.navigationController popToRootViewControllerAnimated:YES];
            }
            
        }else {
            [[Toast makeText:responseObj[MESSAGE]] show];
        }
    } failure:^(NSError *error) {
        
    }];
}
#pragma mark - 申请退款底部导航条
- (void)setupBottomBarWithRefund
{
    self.tableView.frame = CGRectMake(0, 0, SCREEN_Width, SCREEN_Height - 49 - 64);
    
    UIView *bottomBar = [[UIView alloc] init];
    bottomBar.backgroundColor = [UIColor whiteColor];
    bottomBar.frame = CGRectMake(0, SCREEN_Height - 49 - 64, SCREEN_Width, 49);
    [self.view addSubview:bottomBar];
    
    //去评论按钮
    UIButton *refundButton = [[UIButton alloc] init];
    refundButton.frame = CGRectMake(0, 0, ScreenWidth, 49);
    refundButton.backgroundColor = AppMainColor;
    [refundButton setTitle:@"申请退款" forState:UIControlStateNormal];
    [refundButton addTarget:self action:@selector(refundButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [bottomBar addSubview:refundButton];
    self.refundButton = refundButton;
}
/**
 *  点击申请退款
 */
- (void)refundButtonClicked:(UIButton *)button
{
    //弹窗提示
    DQAlertView * alertView = [[DQAlertView alloc] initWithTitle:@"退款提醒" message:@"是否确认申请退款？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alertView.cancelButton setTitleColor:AppMainGrayTextColor forState:UIControlStateNormal];
    [alertView.otherButton setTitleColor:AppMainColor forState:UIControlStateNormal];
    [alertView show];
    
}
#pragma mark - 评论底部导航条
- (void)setupBottomBarWithGoComment
{
    self.tableView.frame = CGRectMake(0, 0, SCREEN_Width, SCREEN_Height - 49 - 64);
    
    UIView *bottomBar = [[UIView alloc] init];
    bottomBar.backgroundColor = [UIColor whiteColor];
    bottomBar.frame = CGRectMake(0, SCREEN_Height - 49 - 64, SCREEN_Width, 49);
    [self.view addSubview:bottomBar];
    
    //去评论按钮
    UIButton *commentButton = [[UIButton alloc] init];
    commentButton.frame = CGRectMake(0, 0, ScreenWidth, 49);
    commentButton.backgroundColor = AppMainColor;
    [commentButton setTitle:@"评价有奖" forState:UIControlStateNormal];
    [commentButton addTarget:self action:@selector(commentButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [bottomBar addSubview:commentButton];
}
/**
 *  去评论按钮点击
 */
- (void)commentButtonClicked
{
    Xzb_CommentViewController *comment = [[Xzb_CommentViewController alloc] init];
    comment.orderID = self.orderID;
    comment.view.backgroundColor = AppMainBgColor;
    [self changed];
    [self.navigationController pushViewController:comment animated:YES];
    
}
#pragma mark - 支付功能模块
/**
 *  支付接口参数
 */
- (NSDictionary *)param:(OrderInfo *)orderInfo
{
    UserAccount *account = [UserAccountTool account];
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setObject:orderInfo.orderName forKey:@"subject"];
    [param setObject:orderInfo.orderDescription forKey:@"body"];
    [param setObject:orderInfo.orderPrice forKey:@"price"];
    [param setObject:orderInfo.orderCode forKey:@"outTradeNo"];
    [param setObject:account.userId forKey:USERID];
    [param setObject:account.loginToken forKey:TOKEN];
    
    NSLog(@"param:%@",param);
    return param;
}
- (void)setupAlipayWithOrderInfo:(OrderInfo *)orderInfo
{
    NSDictionary *param = [self param:orderInfo];
    [self.pay alipayfor:orderInfo param:param payType:PayTypePay];
}

- (void)setupWXpayWithOrderInfo:(OrderInfo *)orderInfo
{
    NSDictionary *param = [self param:orderInfo];
    [RTHttpTool get:WEICHAT_PRE_PAY addHUD:YES param:param success:^(id responseObj) {
        NSLog(@"weixin:%@",responseObj);
        if ([responseObj[SUCCESS] intValue] == 1) {
            NSDictionary *dict = responseObj[ENTITIES][MAP][RESULT];
            NSMutableString *stamp  = [dict objectForKey:@"timestamp"];
            
            //调起微信支付
            PayReq* req             = [[PayReq alloc] init];
            req.partnerId           = [dict objectForKey:@"partnerid"];
            req.prepayId            = [dict objectForKey:@"prepayid"];
            req.nonceStr            = [dict objectForKey:@"noncestr"];
            req.timeStamp           = stamp.intValue;
            req.package             = [dict objectForKey:@"package"];
            req.sign                = [dict objectForKey:@"sign"];
            [WXApi sendReq:req];
        }else
        {
            [[Toast makeText:responseObj[MESSAGE]] show];
        }
    } failure:^(NSError *error) {
        
    }];
}
#pragma mark - 支付宝，微信支付回调
//支付宝,微信支付回调
- (void)payCallback:(NSDictionary *)response
{
    [self alertWithStr:response[@"message"]];
}
- (void)alertWithStr:(NSString *)string
{
    NSString *alertViewCtr_str = string;
    self.payResultStr = string;
    //弹窗提示
    DQAlertView * alertView = [[DQAlertView alloc] initWithTitle:@"支付结果" message:alertViewCtr_str delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
    [alertView.cancelButton setTitleColor:AppMainGrayTextColor forState:UIControlStateNormal];
    [alertView.otherButton setTitleColor:AppMainColor forState:UIControlStateNormal];
    [alertView show];
}
#pragma mark - 获取余额
- (void)getAccountMoney
{
    UserAccount *account = [UserAccountTool account];
    [RTHttpTool get:GET_ACCOUNT_MONEY addHUD:NO param:@{USERID:account.userId,TOKEN:account.loginToken} success:^(id responseObj) {
        id json = [RTHttpTool jsonWithResponseObj:responseObj];
        if ([json[SUCCESS] intValue] == 1) {
            _balance = json[ENTITIES][@"map"][@"available_money"];
        }
    } failure:^(NSError *error) {
        
    }];
}

- (void)Notification
{
    if (!self.model) {
        [[Toast makeText:@"订单数据获取失败"] show];
        return;
    }
    if (!self.orderID) {
        [[Toast makeText:@"订单号获取失败"] show];
        return;
    }
    if (!self.model.realPrice) {
        [[Toast makeText:@"订单价格获取失败"] show];
        return;
    }
    UserAccount *account = [UserAccountTool account];
    if ([account.payPassword isEqualToString:@""]) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"设置支付密码" message:@"您还未设置支付密码，是否前往设置？" delegate:self cancelButtonTitle:@"前往" otherButtonTitles:@"取消", nil];
        [alertView show];
        return;
    }
    
    @WeakObj(self)
    Xzb_PayInputPasswordView *inputView = [[Xzb_PayInputPasswordView alloc] init];
    inputView.payMoney = self.model.realPrice;
    inputView.orderID = self.orderID;
    inputView.payBlock = ^(NSString *message){
        if ([message isEqualToString:@"支付成功"]) {
            [selfWeak.navigationController popToRootViewControllerAnimated:YES];
        }
    };
    inputView.forgetPwdBlock = ^{
        [selfWeak.inputView coverClick];
        [selfWeak.inputView.passwordTextField resignFirstResponder];
        
        Xzb_AddPayPasswordWithPhoneController *forgetVC = [[Xzb_AddPayPasswordWithPhoneController alloc] init];
        forgetVC.titleStr = @"忘记支付密码";
        forgetVC.backVC = (UIViewController *)self;
        forgetVC.view.backgroundColor = AppMainBgColor;
        [selfWeak.navigationController pushViewController:forgetVC animated:YES];
    };
    [inputView show];
    self.inputView = inputView;
    [inputView.passwordTextField becomeFirstResponder];
    
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {//设置支付密码
        
        Xzb_AddPayPasswordWithPhoneController *phoneVC = [[Xzb_AddPayPasswordWithPhoneController alloc] init];
        phoneVC.backVC = self;
        phoneVC.titleStr = @"设置支付密码";
        phoneVC.view.backgroundColor = AppMainBgColor;
        [self.navigationController pushViewController:phoneVC animated:YES];
    }
}
#pragma mark - 余额支付
//- (void)balancePayClick {
//    if (!self.model) {
//        return;
//    }
//
//    UserAccount *account = [UserAccountTool account];
//    NSDictionary *dic = @{ORDERID:self.orderID,
//                          USERID:account.userId,
//                          TOKEN:account.loginToken,
//                          @"totalIncome":@""};
//    [RTHttpTool get:BALANCE_PAY addHUD:NO param:dic success:^(id responseObj) {
//        id json = [RTHttpTool jsonWithResponseObj:responseObj];
//        if ([json[SUCCESS] integerValue] == 1) {
//            [[Toast makeText:json[MESSAGE]] show];
//            [self.navigationController popToRootViewControllerAnimated:YES];
//        }else {
//            [[Toast makeText:json[MESSAGE]] show];
//        }
//    } failure:^(NSError *error) {
//
//    }];
//}

#pragma mark - 地图导航功能模块
- (CLGeocoder *)geocoder
{
    if (!_geocoder) {
        self.geocoder = [[CLGeocoder alloc] init];
    }
    return _geocoder;
}
/**
 *  获取传进来的用户的CLLocation
 */
- (void)setupdestinationPm
{
    // 这里获得店铺经纬度
    float longtitudeText = [self.model.yLocation floatValue];
    float latitudeText = [self.model.xLocation floatValue];
    if (longtitudeText == 0 || latitudeText == 0) return;
    
    CLLocationDegrees latitude = latitudeText;
    CLLocationDegrees longtitude = longtitudeText;
    //开始反向编码
    CLLocation *destinationPm = [[CLLocation alloc] initWithLatitude:latitude longitude:longtitude];
    self.destinationPm = destinationPm;
    
    [self.geocoder reverseGeocodeLocation:destinationPm completionHandler:^(NSArray *placemarks, NSError *error) {
        CLPlacemark *destinationCLPm = [placemarks firstObject];
        if (destinationCLPm == nil) return;
        // 设置终点
        MKPlacemark *destinationMKPm = [[MKPlacemark alloc] initWithPlacemark:destinationCLPm];
        self.destinationMKPm = destinationMKPm;
    }];
}

/**
 *  导航按钮点击
 */
- (void)navigationClick
{
    if (self.destinationMKPm == nil){
        [[Toast makeText:@"无法获取酒店位置，请重新刷新页面"] show];
        return;
    }
    
    MKMapItem *sourceItem=[MKMapItem mapItemForCurrentLocation];//当前位置
    
    // 终点
    MKMapItem *destinationItem = [[MKMapItem alloc] initWithPlacemark:self.destinationMKPm];
    
    // 存放起点和终点
    NSArray *items = @[sourceItem,destinationItem];
    
    // 参数
    NSMutableDictionary *options = [NSMutableDictionary dictionary];
    // 导航模式：驾驶导航
    options[MKLaunchOptionsDirectionsModeKey] = MKLaunchOptionsDirectionsModeDriving;
    // 是否要显示路况
    options[MKLaunchOptionsShowsTrafficKey] = @YES;
    
    // 打开苹果官方的导航应用
    [MKMapItem openMapsWithItems:items launchOptions:options];
    
}
#pragma mark - DQAlertViewDelegate
- (void)otherButtonClickedOnAlertView:(DQAlertView *)alertView {
    
    if ([self.payResultStr isEqualToString:@"支付成功"]) {
        [self.navigationController popToRootViewControllerAnimated:YES];
        [self changed];
    }
    if ([alertView.otherButton.titleLabel.text isEqualToString:@"去下载"]) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[WXApi getWXAppInstallUrl]]];
    }
    if ([alertView.titleLabel.text isEqualToString:@"退款提醒"]) {
        UserAccount *account = [UserAccountTool account];
        NSDictionary *dic = @{ID:self.orderID,USERID:account.userId,TOKEN:account.loginToken};
        [RTHttpTool post:CANCLE_ORDER addHUD:NO param:dic success:^(id responseObj) {
            NSLog(@"%@",responseObj);
            if ([responseObj[SUCCESS] intValue] == 1) {
                //                [self.refundButton setTitle:@"取消待商家确认" forState:UIControlStateNormal];
                [self setupDetailData];
                //                self.refundButton.userInteractionEnabled = NO;
                [self changed];
            }else {
                [[Toast makeText:responseObj[MESSAGE]] show];
            }
        } failure:^(NSError *error) {
            
        }];
        
    }
    if ([alertView.titleLabel.text isEqualToString:@"确认取消订单？"]) {
        [self setupDetailData];
        if ([self.model.orderStatus integerValue] == 3 || [self.model.orderStatus integerValue] == 4) {
            [Toast makeText:@"您已经入住！无法退款！"];
        }else {
            [self cancleOrderButtonClicked];
            //            [self changed];
        }
        
    }
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    NSLog(@"dealloc---Xzb_OrderDetailController");
}

#pragma mark - 进行了某种操作导致类型改变
- (void)changed {
    if (self.didChange) {
        self.didChange();
    }
}

@end
