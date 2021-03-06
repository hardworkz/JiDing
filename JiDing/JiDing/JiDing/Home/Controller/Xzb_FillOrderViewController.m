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
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:AppMainColor] forBarMetrics:UIBarMetricsDefault];
//    [self.navigationController.navigationBar setShadowImage:[UIImage imageNamed:@"透明"]];
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
    _tableView.backgroundColor = AppLightLineColor;
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
    
    //分割线
    UIView *devider = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.5)];
    devider.backgroundColor = AppLightLineColor;

    //预订按钮
    UIButton *submitButton = [[UIButton alloc] init];
    submitButton.frame = CGRectMake(0, 0, ScreenWidth, 49);
    [submitButton setTitle:@"提交订单" forState:UIControlStateNormal];
    [submitButton setTitleColor:AppGreenTextColor forState:UIControlStateNormal];
    [submitButton addTarget:self action:@selector(submitOrder:) forControlEvents:UIControlEventTouchUpInside];
    [bottomBar addSubview:submitButton];
    [submitButton addSubview:devider];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDelegate && UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        FillOrderHotelCell *cell = [FillOrderHotelCell cellWithTableView:tableView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.hotelModel = _hotelModel;
        return cell;
    }else
        if (indexPath.row == 1) {
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
    }else
        if (indexPath.row == 2) {
        Xzb_fillOrderPhoneCell *cell = [Xzb_fillOrderPhoneCell cellWithTableView:tableView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.model = _hotelModel;
        return cell;
    }else if (indexPath.row == 3) {
        Xzb_fillOrderRemarkCell *cell = [Xzb_fillOrderRemarkCell cellWithTableView:tableView];
        //        _remarkStr = cell.remarkField.text;
        _remarkField = cell.remarkField;
        return cell;
    }else if (indexPath.row == 4) {
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
        return 115;
    }else if (indexPath.row == 1) {
        return 45;
    }else if (indexPath.row == 2) {
        return 90;
    }else if (indexPath.row == 3) {
        return 54;
    }else if (indexPath.row == 4) {
        return 90;
    }else{
        return 45;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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
    
    NSIndexPath *index = [NSIndexPath indexPathForRow:(4) inSection:0];
    Xzb_fillOrderCheckManCell *cell = [self.tableView cellForRowAtIndexPath:index];
    RTLog(@"%@---%@",cell.name.text,cell.phone.text);
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
    _unitPriceLabel.text = [NSString stringWithFormat:@"订单总额：¥%@",hotelModel.totalPrice];
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
        if ([responseObj[SUCCESS] intValue] == 1) {
            [self.tableView reloadData];
        }
        if ([responseObj[SUCCESS] intValue] == 0) {
            //弹窗提示信息
            [[Toast makeText:responseObj[MESSAGE]] show];
        }
        self.NoCoupon = NO;
    } failure:^(NSError *error) {
        self.NoCoupon = YES;
    }];
}

//- (void)getCouponData {
//    UserAccount *account = [UserAccountTool account];
//    NSDictionary *dic = @{USERID:account.userId,TOKEN:account.loginToken, @"state":@"0",@"orderId":self.hotelModel.orderId,@"orderRelId":_offerModel.orderRelId};
//    [RTHttpTool get:GET_CUSOTEMER_COUPON addHUD:YES param:dic success:^(id responseObj) {
////        id json = [RTHttpTool jsonWithResponseObj:responseObj];
//        NSLog(@"%@",responseObj);
//        if ([responseObj[SUCCESS] intValue] == 1) {
////            NSArray *vocherListArray = [VouchersListModel mj_objectArrayWithKeyValuesArray:json[ENTITIES][@"list"]];
////            self.couponArray = (NSMutableArray *)vocherListArray;
//            if (self.couponArray.count) {
//                if (!self.couponId.length) {
//                    [[Toast makeText:@"您未使用返现券！"] show];
//                }
//            }
//        }
//        if ([responseObj[SUCCESS] intValue] == 0) {
//            [[Toast makeText:responseObj[MESSAGE]] show];
//        }
//    } failure:^(NSError *error) {
//        
//    }];
//}

@end
