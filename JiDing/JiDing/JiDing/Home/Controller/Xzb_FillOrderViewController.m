//
//  Xzb_FillOrderViewController.m
//  xzb
//
//  Created by 张荣廷 on 16/6/6.
//  Copyright © 2016年 xuwk. All rights reserved.
//

#import "Xzb_FillOrderViewController.h"
// view
#import "Xzb_FillOrderFooterView.h"
#import "FillOrderHotelCell.h"
#import "Xzb_fillOrderPayTypeCell.h"
#import "Xzb_fillOrderTicketCell.h"
#import "Xzb_fillOrderPhoneCell.h"
#import "Xzb_fillOrderCheckManCell.h"
#import "Xzb_fillOrderAddCheckManCell.h"
#import "Xzb_fillOrderRemarkCell.h"

@interface Xzb_FillOrderViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) Xzb_FillOrderFooterView *footerView;
@property (nonatomic, strong) NSString *remarkStr;
@property (nonatomic, strong) UITextField *remarkField;
@property (nonatomic, strong) UserAccount *account;
@property (nonatomic, strong) NSString *couponMony; // 抵现券金额
@property (nonatomic, strong) NSString *couponId; // 抵现券id
@property (nonatomic, strong) UILabel *unitPriceLabel;
@property (nonatomic, strong) NSString *payType; // 支付类型
@property (nonatomic, strong) NSString *totalMony; // 总额
@property (nonatomic,weak)  UITextField *name;
@property (nonatomic, strong) UITextField *phone;
@property (nonatomic, strong) NSString *phoneStr;
@property (nonatomic, strong) NSArray *couponArray;
@property (nonatomic, assign) BOOL NoCoupon;

@end

@implementation Xzb_FillOrderViewController
- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [self.view endEditing:YES];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //设置导航栏背景色
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:AppMainColor] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage imageNamed:@"透明"]];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.name resignFirstResponder];
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}
- (void)back_clicked
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.keyboardDistanceFromTextField = 20;
    manager.enable = YES;
    manager.enableAutoToolbar = NO;
    manager.shouldResignOnTouchOutside = YES;
    
    _account = [UserAccountTool account];
    //设置导航栏标题
    self.title = @"填写订单";
    [self setupSubView];
    [self setupBottomView];
    [self setupData]; // 取返现券的数据
}

#pragma mark - 设置视图
- (void)setupSubView
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, SCREEN_Height - 49 - 64)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    _footerView = [[Xzb_FillOrderFooterView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, 60)];
    _tableView.tableFooterView = _footerView;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
}

#pragma  - mark - 底部按钮视图
- (void)setupBottomView
{
    UIView *bottomBar = [[UIView alloc] init];
    bottomBar.backgroundColor = [UIColor whiteColor];
    bottomBar.frame = CGRectMake(0, SCREEN_Height - 49 - 64, SCREEN_Width, 49);
    [self.view addSubview:bottomBar];
    
    //区别全日房和钟点房
    NSString *hourTime = @"";
    if ([self.hotelModel.orderType intValue] == 1) {
        hourTime = @"晚";
    }else if ([self.hotelModel.orderType intValue] == 2)
    {
        //钟点房显示时间
        if ([self.hotelModel.timePeriod intValue] == 1) {
            hourTime = @"3小时";
        }else if ([self.hotelModel.timePeriod intValue] == 2){
            hourTime = @"4小时";
        }else if ([self.hotelModel.timePeriod intValue] == 3){
            hourTime = @"5小时";
        }
        
    }
    //酒店报价
    //    NSString *text = [NSString stringWithFormat:@"订单总额：¥%@",self.hotelModel.price];
    
    _unitPriceLabel = [[UILabel alloc] init];
    _unitPriceLabel.text = [NSString stringWithFormat:@"订单总额：¥%@",self.hotelModel.roomPrice];
    _unitPriceLabel.backgroundColor = [UIColor blackColor];
    _unitPriceLabel.textColor = [UIColor whiteColor];
    _unitPriceLabel.textAlignment = NSTextAlignmentCenter;
    _unitPriceLabel.font = [UIFont systemFontOfSize:17];
    _unitPriceLabel.frame = CGRectMake(0, 0, SCREEN_Width * 0.5, 49);
    [bottomBar addSubview:_unitPriceLabel];
    
    //预订按钮
    UIButton *submitButton = [[UIButton alloc] init];
    submitButton.frame = CGRectMake(SCREEN_Width * 0.5, 0, ScreenWidth * 0.5, 49);
    submitButton.backgroundColor = AppMainColor;
    [submitButton setTitle:@"提交订单" forState:UIControlStateNormal];
    [submitButton addTarget:self action:@selector(submitOrder:) forControlEvents:UIControlEventTouchUpInside];
    [bottomBar addSubview:submitButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDelegate && UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        FillOrderHotelCell *cell = [FillOrderHotelCell cellWithTableView:tableView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.hotelModel = _hotelModel;
        return cell;
    }else if (indexPath.row == 1) {
        Xzb_fillOrderPayTypeCell *cell = [Xzb_fillOrderPayTypeCell cellWithTableView:tableView];
        cell.hotelModel = _hotelModel;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        //        float totalPrice = [_hotelModel.roomNum integerValue] * [_hotelModel.nights integerValue] *[_offerModel.price doubleValue];
        @WeakObj(self);
        cell.payTypeClick = ^(NSString *payType){
            selfWeak.payType = payType;
            if ([selfWeak.payType integerValue] == 2 && [payType integerValue] != 6) {
                selfWeak.totalMony = [NSString stringWithFormat:@"%.2f",[_hotelModel.totalPrice floatValue] / 2];
                selfWeak.unitPriceLabel.text = [NSString stringWithFormat:@"订单总额：¥%.2f",[_hotelModel.totalPrice floatValue] / 2];
                selfWeak.hotelModel.totalPrice = [NSString stringWithFormat:@"订单总额：%.2f",[_hotelModel.totalPrice floatValue] / 2];
            }else {
                selfWeak.totalMony = [NSString stringWithFormat:@"%.2f",[_hotelModel.totalPrice floatValue]];
                selfWeak.unitPriceLabel.text = [NSString stringWithFormat:@"订单总额：¥%.2f",[_hotelModel.totalPrice floatValue]];
                selfWeak.hotelModel.totalPrice = [NSString stringWithFormat:@"订单总额：%.2f",[_hotelModel.totalPrice floatValue]];
            }
        };
        return cell;
    }else if (indexPath.row == 2) {
        Xzb_fillOrderTicketCell *cell = [Xzb_fillOrderTicketCell cellWithTableView:tableView];
        if (self.couponArray.count && !self.couponMony.length) {
//            VouchersListModel *model = self.couponArray.firstObject;
//            self.couponMony = model.coupon_money;
//            self.couponId = [NSString stringWithFormat:@"%@",model.voucherID];
        }
        if ([self.couponMony integerValue] == -1 ) {
            cell.couponMony = NULL;
        }else {
            cell.couponMony = self.couponMony;
        }
        return cell;
    }else if (indexPath.row == 3) {
        Xzb_fillOrderPhoneCell *cell = [Xzb_fillOrderPhoneCell cellWithTableView:tableView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.model = _hotelModel;
        return cell;
    }else if (indexPath.row == 4) {
        Xzb_fillOrderRemarkCell *cell = [Xzb_fillOrderRemarkCell cellWithTableView:tableView];
        //        _remarkStr = cell.remarkField.text;
        _remarkField = cell.remarkField;
        return cell;
    }else if (indexPath.row == 5) {
        Xzb_fillOrderCheckManCell *cell = [Xzb_fillOrderCheckManCell cellWithTableView:tableView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (self.phoneStr.length) {
            cell.phone.text = self.phoneStr;
        }else {
            cell.phone.text = _account.mobile;
        }
        self.name = cell.name;
        self.phone = cell.phone;
        self.phone.delegate = self;
        return cell;
    }else {
        UITableViewCell *cell = [[UITableViewCell alloc] init];
        return cell;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 105;
    }else if (indexPath.row == 1 || indexPath.row == 3) {
        return 90;
    }else if (indexPath.row >= 5 ) {
        return 90;
    }
    else if (indexPath.row == 2 || indexPath.row == 4) {
        return 54;
    }else {
        return 45;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 2) {
//        Xzb_VouchersTableViewController *vc = [[Xzb_VouchersTableViewController alloc] init];
//        vc.state = @"0";
//        vc.orderID = _hotelModel.orderId;
//        vc.orderRelId = _offerModel.orderRelId;
//        @WeakObj(self);
//        vc.ticket = ^(NSNumber *couponId, NSString *mony) {
//            selfWeak.couponMony = mony;
//            if (couponId) {
//                selfWeak.couponId = [NSString stringWithFormat:@"%@",couponId];
//            }else {
//                selfWeak.couponId = @"";
//            }
//            [selfWeak.tableView reloadData];
//        };
//        [self.navigationController pushViewController:vc animated:YES];
    }
}

#pragma mark - 提交订单
- (void)submitOrder:(UIButton *)button
{
    button.enabled = NO;
    if ([self.offerModel.seconds intValue] <= 0) {
        [[Toast makeText:@"该订单报价已经失效~"] show];
        button.enabled = YES;
        return;
    }
    
    if (_hotelModel.typeArray.count == 1 ) {
        _payType = _hotelModel.payType;
    }
    RTLog(@"用户信息为:%@",[self guestInfo]);
    if (self.NoCoupon) {
        [[Toast makeText:@"请求出错，还未使用返现券！请重试！"] show];
        [self setupData];
        button.enabled = YES;
        return;
    }
    //    [self getCouponData];
    if ([self guestInfo].length) {
        NSDictionary *dic = @{ORDERID:_hotelModel.orderId,
                              @"arriveTime":@"", // 默认20：00，当前3.0版本显示为整晚保留
                              @"payType":_payType?_payType:@"1",
                              @"pick":_hotelModel.pick,
                              @"breakfast":_hotelModel.breakfast,
                              @"cancelTime":_offerModel.countDown,
                              @"timePeriod":_offerModel.timePeriod,
                              @"price":self.hotelModel.price,
                              @"totalIncome":self.totalMony,
                              @"businessId":_offerModel.hotelId,
                              @"roomId":_offerModel.roomId,
                              @"guestInfo":[self guestInfo],
                              @"remark":_remarkField.text,
                              @"couponId":_couponId?_couponId:@"",
                              @"roomType":_offerModel.roomType,
                              USERID:_account.userId,
                              TOKEN:_account.loginToken,
                              @"roomName":_offerModel.roomName};
        
        NSLog(@"dict--%@",dic);
        [RTHttpTool post:CONFIRM_ORDER addHUD:YES param:dic success:^(id responseObj) {
            
            //        id json = [RTHttpTool jsonWithResponseObj:responseObj];
            RTLog(@"填写订单完成:%@",responseObj);
            if ([responseObj[SUCCESS] intValue] == 1) {
                Xzb_OrderDetailController *orderDetail = [[Xzb_OrderDetailController alloc] init];
                orderDetail.orderRelID = self.offerModel.orderRelId;
                orderDetail.orderID = _hotelModel.orderId;
                orderDetail.offerModel = self.offerModel;
                orderDetail.isPopRootVC = YES;
                [self.navigationController pushViewController:orderDetail animated:YES];
                button.enabled = YES;
            }
        } failure:^(NSError *error) {
            button.enabled = YES;
        }];
    }else {
        [[Toast makeText:@"请填写完整的信息~"] show];
        button.enabled = YES;
    }
}
- (NSString *)guestInfo {
    
    NSIndexPath *index = [NSIndexPath indexPathForRow:(5) inSection:0];
    Xzb_fillOrderCheckManCell *cell = [self.tableView cellForRowAtIndexPath:index];
    if (cell.name.text.length && cell.phone.text.length == 11) {
        if (self.phoneStr.length && self.phoneStr.length == 11) {
            return [NSString stringWithFormat:@"%@,%@",cell.name.text,self.phoneStr];
        }
        return [NSString stringWithFormat:@"%@,%@",cell.name.text,cell.phone.text];
    }else {
        return @"";
    }
    
}

- (void)setHotelModel:(Xzb_HotelDetailModel *)hotelModel
{
    _hotelModel = hotelModel;
    //    float totalPrice = [hotelModel.roomNum integerValue] * [hotelModel.nights integerValue] *[hotelModel.price doubleValue];
    _totalMony = [NSString stringWithFormat:@"%.2f",[hotelModel.totalPrice floatValue]];
    //    RTLog(@"入住的总额为:%@",_totalMony);
    _unitPriceLabel.text = [NSString stringWithFormat:@"订单总额：¥%@",hotelModel.totalPrice];
    //    if ([hotelModel.orderBusinessLevel integerValue] == 6) {
    //        _unitPriceLabel.text = @"订单总额：¥1.00";
    //        _hotelModel.price = @"1.00";
    //    }
    //    if (hotelModel.typeArray.count == 1) {
    //        if ([hotelModel.typeArray.firstObject integerValue] == 2) {
    //            _unitPriceLabel.text = [NSString stringWithFormat:@"订单总额：¥%.2f",totalPrice / 2];
    //            _hotelModel.price = [NSString stringWithFormat:@"%.2f",totalPrice / 2];
    //        }
    //    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.view endEditing:YES];
}

#pragma mark - UITextFieldDelegate
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    self.phoneStr = textField.text;
}

- (void)setupData
{
    UserAccount *account = [UserAccountTool account];
    NSDictionary *dic = @{USERID:account.userId,TOKEN:account.loginToken, @"state":@"0",@"orderId":self.hotelModel.orderId,@"orderRelId":_offerModel.orderRelId};
    [RTHttpTool get:GET_CUSOTEMER_COUPON addHUD:YES param:dic success:^(id responseObj) {
        id json = [RTHttpTool jsonWithResponseObj:responseObj];
        if ([json[SUCCESS] intValue] == 1) {
//            NSArray *vocherListArray = [VouchersListModel mj_objectArrayWithKeyValuesArray:json[ENTITIES][@"list"]];
//            self.couponArray = (NSMutableArray *)vocherListArray;
            [self.tableView reloadData];
        }
        if ([json[SUCCESS] intValue] == 0) {
            [[Toast makeText:json[MESSAGE]] show];
        }
        self.NoCoupon = NO;
    } failure:^(NSError *error) {
        self.NoCoupon = YES;
    }];
}

- (void)getCouponData {
    UserAccount *account = [UserAccountTool account];
    NSDictionary *dic = @{USERID:account.userId,TOKEN:account.loginToken, @"state":@"0",@"orderId":self.hotelModel.orderId,@"orderRelId":_offerModel.orderRelId};
    [RTHttpTool get:GET_CUSOTEMER_COUPON addHUD:YES param:dic success:^(id responseObj) {
        id json = [RTHttpTool jsonWithResponseObj:responseObj];
        NSLog(@"%@",json);
        if ([json[SUCCESS] intValue] == 1) {
//            NSArray *vocherListArray = [VouchersListModel mj_objectArrayWithKeyValuesArray:json[ENTITIES][@"list"]];
//            self.couponArray = (NSMutableArray *)vocherListArray;
            if (self.couponArray.count) {
                if (!self.couponId.length) {
                    [[Toast makeText:@"您未使用返现券！"] show];
                }
            }
        }
        if ([json[SUCCESS] intValue] == 0) {
            [[Toast makeText:json[MESSAGE]] show];
        }
    } failure:^(NSError *error) {
        
    }];
}

@end
