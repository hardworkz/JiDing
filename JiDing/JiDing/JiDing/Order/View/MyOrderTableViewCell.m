//
//  MyOrderTableViewCell.m
//  xzb
//
//  Created by 张荣廷 on 16/5/30.
//  Copyright © 2016年 xuwk. All rights reserved.
//

#import "MyOrderTableViewCell.h"

#define PHOTO_W 100
#define BTN_W 80

@interface MyOrderTableViewCell ()
@property (nonatomic,weak)  UIImageView *photoView;
//@property (nonatomic,weak)  UILabel *nameLabel;
//@property (nonatomic,weak)  UIButton *roomLabel;
//@property (nonatomic,weak)  UILabel *arriveTime;
//@property (nonatomic,weak)  UILabel *priceLabel;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) NSString *seconds;
@property (nonatomic, assign) NSInteger index;

@property (nonatomic, strong) UIView *customView;
@property (nonatomic, strong) UILabel *orderIdLabel;
@property (nonatomic, strong) UILabel *typeLabel;
@property (nonatomic, strong) UIButton *hotelName;
@property (nonatomic, strong) UILabel*roomLabel;
@property (nonatomic, strong) UILabel *arriveTime;
@property (nonatomic, strong) UILabel *orderTime;
@property (nonatomic, strong) UIButton *cancleButton;
@property (nonatomic, strong) UIButton *sureButton;
@property (nonatomic, strong) UILabel *priceLabel;
@property (nonatomic, strong) UIButton *countDownBtn;
@property (nonatomic, strong) UIView *firLine;
@property (nonatomic, strong) UIView *secLine;

@end
@implementation MyOrderTableViewCell

+ (NSString *)ID
{
    return @"MyOrderTableViewCell";
}

+(MyOrderTableViewCell *)cellWithTableView:(UITableView *)tableView
{
    MyOrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[MyOrderTableViewCell ID]];
    if (cell == nil) {
        cell = [[MyOrderTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[MyOrderTableViewCell ID]];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
                [self setupView];
    }
    return self;
}

- (void) setupView {
    self.contentView.backgroundColor = AppLineColor;
    
    _customView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, 190)];
    _customView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:_customView];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, 0.5)];
    line.backgroundColor = AppLineColor;
    [self.customView addSubview:line];
    
    _orderIdLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, ( SCREEN_Width - 20 ) / 2 + 100, 45)];
    _orderIdLabel.textColor = AppMainGrayTextColor;
    _orderIdLabel.font = [UIFont systemFontOfSize:14];
    _orderIdLabel.textAlignment = NSTextAlignmentLeft;
    [self.customView addSubview:_orderIdLabel];
    
    _typeLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_orderIdLabel.frame) - 100, 0, CGRectGetWidth(_orderIdLabel.frame) - 100, 45)];
    _typeLabel.textAlignment = NSTextAlignmentRight;
    _typeLabel.font = [UIFont systemFontOfSize:14];
    _typeLabel.textColor = AppGreenTextColor;
    [self.customView addSubview:_typeLabel];
    
    _firLine = [[UIView alloc] initWithFrame:CGRectMake(10, 45, SCREEN_Width - 10, 0.5)];
    _firLine.backgroundColor = AppLineColor;
    [self.customView addSubview:_firLine];
    
    _hotelName = [[UIButton alloc] initWithFrame:CGRectMake(10, 45, SCREEN_Width - 20, 30)];
    [_hotelName setTitleColor:AppMainGrayTextColor forState:UIControlStateNormal];
    [_hotelName setImage:[UIImage imageNamed:@"酒店图标"] forState:UIControlStateNormal];
    _hotelName.titleLabel.font = [UIFont systemFontOfSize:14];
    _hotelName.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [self.customView addSubview:_hotelName];
    
    _roomLabel = [[UILabel alloc] initWithFrame:CGRectMake(20 + 10, CGRectGetMaxY(_hotelName.frame), _hotelName.frame.size.width / 2 - 20, 30)];
    _roomLabel.textAlignment = NSTextAlignmentLeft;
    _roomLabel.font = [UIFont systemFontOfSize:13];
    _roomLabel.textColor = AppMainGrayTextColor;
    [self.customView addSubview:_roomLabel];
    
    _arriveTime = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(_roomLabel.frame), CGRectGetMaxY(_roomLabel.frame), _roomLabel.frame.size.width + 40, 30)];
    _arriveTime.font = [UIFont systemFontOfSize:13];
    _arriveTime.textColor = AppMainGrayTextColor;
    [self.customView addSubview:_arriveTime];
    
    _secLine = [[UIView alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(_arriveTime.frame), SCREEN_Width - 10, 0.5)];
    _secLine.backgroundColor = AppLineColor;
    [self.customView addSubview:_secLine];
    
    _orderTime = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(_arriveTime.frame), ( SCREEN_Width - 20 ) / 2, 50)];
    _orderTime.textColor = AppMainGrayTextColor;
    _orderTime.textAlignment = NSTextAlignmentLeft;
    _orderTime.font = [UIFont systemFontOfSize:13];
    [self.customView addSubview:_orderTime];
    
    _cancleButton = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_orderTime.frame), CGRectGetMaxY(_arriveTime.frame) + 10, (CGRectGetWidth(_orderTime.frame) - 10 )/ 2, 30)];
    _cancleButton.layer.borderColor = [AppMainGrayTextColor CGColor];
    _cancleButton.layer.borderWidth = .5f;
    [_cancleButton setTitle:@"取消订单" forState:UIControlStateNormal];
    [_cancleButton setTitleColor:AppMainGrayTextColor forState:UIControlStateNormal];
    _cancleButton.titleLabel.font = [UIFont systemFontOfSize:13];
    _cancleButton.layer.masksToBounds = YES;
    _cancleButton.layer.cornerRadius = 10.f;
    [_cancleButton addTarget:self action:@selector(Notification) forControlEvents:UIControlEventTouchUpInside];
    [self.customView addSubview:_cancleButton];
    
    _sureButton = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_cancleButton.frame) + 10, CGRectGetMaxY(_arriveTime.frame) + 10, CGRectGetWidth(_cancleButton.frame), 30)];
    [_sureButton setTitleColor:AppMainColor forState:UIControlStateNormal];
    [_sureButton setTitle:@"查看订单" forState:UIControlStateNormal];
    _sureButton.layer.borderColor = [AppMainColor CGColor];
    _sureButton.titleLabel.font = [UIFont systemFontOfSize:13];
    _sureButton.layer.borderWidth = .5f;
    _sureButton.layer.masksToBounds = YES;
    _sureButton.layer.cornerRadius = 10.f;
    [self.customView addSubview:_sureButton];
    
    
    _priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_roomLabel.frame), CGRectGetMaxY(_hotelName.frame) - 5, SCREEN_Width - CGRectGetWidth(_roomLabel.frame) - 10 - 30, 35)];
    _priceLabel.font = [UIFont systemFontOfSize:14];
    _priceLabel.textColor = AppMainColor;
    _priceLabel.textAlignment = NSTextAlignmentRight;
    [self.customView addSubview:_priceLabel];
    
    _countDownBtn = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_roomLabel.frame), CGRectGetMaxY(_priceLabel.frame), _priceLabel.frame.size.width, 20)];
    [_countDownBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    _countDownBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    _countDownBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [_countDownBtn setImage:[UIImage imageNamed:@"闹钟"] forState:UIControlStateNormal];
    [self.customView addSubview:_countDownBtn];
    
}

- (void)sureButtonClicked:(UIButton *)button
{
    if ([button.titleLabel.text isEqualToString:@"立即评价"]) {
        id object = [self nextResponder];
        
        while (![object isKindOfClass:[UIViewController class]] &&
               object != nil) {
            object = [object nextResponder];
        }
        Xzb_CommentViewController *comment = [[Xzb_CommentViewController alloc] init];
        UINavigationController *vc = (UINavigationController *)object;
        [vc.navigationController pushViewController:comment animated:YES];
    }
}
//- (void)setFrame:(CGRect)frame
//{
//    frame.origin.y += 9;
//    frame.size.height -= 9;
//    [super setFrame:frame];
//}

- (void)setModel:(Xzb_MyOrderInfosModel *)model
{
    _model = model;
    if (model.checkinStatus) {
        int i = [model.checkinStatus intValue];
        switch (i) {
            case -1:
                self.typeLabel.text = @"已取消";
                self.typeLabel.textColor = AppMainGrayTextColor;
                self.cancleButton.hidden = YES;
                break;
            case 2:
                self.typeLabel.text = @"待入住";
                self.typeLabel.textColor = HEXCOLOR(0xff4500);
                [self.sureButton setTitle:@"查看详情" forState:UIControlStateNormal];
                [self.sureButton addTarget:self action:@selector(orderDetail:) forControlEvents:UIControlEventTouchUpInside];
                self.cancleButton.hidden = NO;
                break;
            case 3:
                self.typeLabel.text = @"已入住";
                self.typeLabel.textColor = AppMainGrayTextColor;
                self.cancleButton.hidden = YES;
                [self.sureButton setTitle:@"评价有奖" forState:UIControlStateNormal];
                [self.sureButton addTarget:self action:@selector(evaluation:) forControlEvents:UIControlEventTouchUpInside];
                break;
            case 4:
                self.typeLabel.text = @"已离店";
                self.typeLabel.textColor = AppMainGrayTextColor;
                self.cancleButton.hidden = YES;
                [self.sureButton setTitle:@"评价有奖" forState:UIControlStateNormal];
                [self.sureButton addTarget:self action:@selector(evaluation:) forControlEvents:UIControlEventTouchUpInside];
                break;
            case 6:
                self.typeLabel.text = @"预定未入住";
                self.typeLabel.textColor = AppMainGrayTextColor;
                self.cancleButton.hidden = YES;
                [self.sureButton setTitle:@"查看详情" forState:UIControlStateNormal];
                [self.sureButton addTarget:self action:@selector(orderDetail:) forControlEvents:UIControlEventTouchUpInside];
                break;
            default:
                break;
        }
    }
    int j = [model.orderStatus intValue];
    switch (j) {
        case -4:
            self.typeLabel.text = @"取消待商家确认";
            self.typeLabel.textColor = AppMainGrayTextColor;
            self.cancleButton.hidden = YES;
            break;
        case -3:
            self.typeLabel.text = @"已退款";
            self.typeLabel.textColor = AppMainGrayTextColor;
            self.cancleButton.hidden = YES;
            [self.sureButton setTitle:@"查看详情" forState:UIControlStateNormal];
            [self.sureButton addTarget:self action:@selector(orderDetail:) forControlEvents:UIControlEventTouchUpInside];
            break;
        case -2:
            self.typeLabel.text = @"退款中";
            self.typeLabel.textColor = AppMainGrayTextColor;
            self.cancleButton.hidden = YES;
            break;
        case -1:
            self.typeLabel.text = @"已取消";
            self.typeLabel.textColor = AppMainGrayTextColor;
            self.cancleButton.hidden = YES;
            [self.sureButton setTitle:@"查看详情" forState:UIControlStateNormal];
            [self.sureButton addTarget:self action:@selector(orderDetail:) forControlEvents:UIControlEventTouchUpInside];
            break;
        case 0:
            self.typeLabel.text = @"待接单";
            self.typeLabel.textColor = AppMainGrayTextColor;
            self.cancleButton.hidden = NO;
            break;
        case 1:
            self.typeLabel.text = @"待付款";
            self.typeLabel.textColor = AppGreenTextColor;
            self.cancleButton.hidden = NO;
            [self.sureButton setTitle:@"确认支付" forState:UIControlStateNormal];
            [self.sureButton addTarget:self action:@selector(pay:) forControlEvents:UIControlEventTouchUpInside];
            break;
//        case 2:
//            self.typeLabel.text = @"已付款";
//            break;
        case 3:
            self.typeLabel.text = @"已评价";
            self.typeLabel.textColor = AppMainGrayTextColor;
            self.cancleButton.hidden = YES;
            [self.sureButton setTitle:@"查看评价" forState:UIControlStateNormal];
            [self.sureButton addTarget:self action:@selector(myCommentClick:) forControlEvents:UIControlEventTouchUpInside];
            break;
            
        default:
            break;
    }
//    [_countDownBtn setTitle:model.orderDate forState:UIControlStateNormal];
    [self.hotelName setTitle:[NSString stringWithFormat:@" %@",model.businessName] forState:UIControlStateNormal];
    self.orderIdLabel.text = [NSString stringWithFormat:@"订单号：%@",model.orderCode];
    self.roomLabel.text = model.roomName;
    self.priceLabel.text = [NSString stringWithFormat:@"¥%@",model.totalIncome];
    NSString *checkinDate = [NSString new];
    NSString *leaveDate = [NSString new];
    if (model.checkinDate.length) {
        checkinDate = [_model.checkinDate substringWithRange:NSMakeRange(5, 5)];
    }
    if (model.leaveDate.length) {
        leaveDate = [_model.leaveDate substringWithRange:NSMakeRange(5, 5)];
    }
    
    
    self.arriveTime.text = [NSString stringWithFormat:@"入住：%@ 离开：%@",checkinDate,leaveDate];
    self.orderTime.text = model.orderDate;
    
    if (model.cancleEnable && [model.orderStatus intValue] != -4 ) {
        [_timer invalidate];
        _timer = nil;
        _index = model.seconds;
        _timer=[NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(changeTimeAtTimedisplay) userInfo:nil repeats:YES];
        [_timer fire];
        [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
        _cancleButton.hidden = NO;
        _countDownBtn.hidden = NO;
    }else {
        [_timer invalidate];
        _timer = nil;
        if ([model.orderStatus integerValue] == 1) {
            _cancleButton.hidden = NO;
        }else {
            _cancleButton.hidden = YES;
        }
        _countDownBtn.hidden = YES;
//        [_countDownBtn setTitle:model.orderDate forState:UIControlStateNormal];
    }
}

#pragma mark - 取消订单
- (void)Notification
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"" message:@"确认取消订单？" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:@"取消", nil];
    [alertView show];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {//确认取消订单
        [self cancleClick];
    }
}

- (void)cancleClick {
    if (self.cancleOrder) {
        self.cancleOrder();
    }
}

#pragma mark - 支付
- (void)pay:(UIButton *)button {
    if ([button.titleLabel.text isEqualToString:@"确认支付"]) {
        if (self.payClick) {
            self.payClick();
        }
    }
}

#pragma mark - 订单详情
- (void)orderDetail:(UIButton *)button {
    if ([button.titleLabel.text isEqualToString:@"查看详情"]) {
        if (self.detailClick) {
            self.detailClick();
        }
    }
}

#pragma mark - 评价订单
- (void)evaluation:(UIButton *)button {
    if ([button.titleLabel.text isEqualToString:@"评价有奖"]) {
        if (self.evaluationClick) {
            self.evaluationClick();
        }
    }
}

#pragma mark - 改变时间
- (void)changeTimeAtTimedisplay {
    _index--;
    if (_index <= 0) {
        //invalidate  终止定时器
        [_timer invalidate];
        _timer = nil;
        _index = 0;
    }else{
        _seconds = [NSString stringWithFormat:@"%zd:%.2zd",_index/60,_index%60];
        [_countDownBtn setTitle:_seconds forState:UIControlStateNormal];
        _countDownBtn.titleLabel.text = _seconds;
    }
}

#pragma mark -查看评论
- (void)myCommentClick:(UIButton *)button {
    if ([button.title isEqualToString:@"查看评价"]) {
        if (self.myComment) {
            self.myComment();
        }
    }
}
@end
