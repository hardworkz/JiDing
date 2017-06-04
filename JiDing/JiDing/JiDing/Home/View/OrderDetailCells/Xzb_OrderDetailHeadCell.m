//
//  Xzb_OrderDetailHeadCell.m
//  xzb
//
//  Created by rainze on 16/7/25.
//  Copyright © 2016年 xuwk. All rights reserved.
//

#import "Xzb_OrderDetailHeadCell.h"
#import <CoreImage/CoreImage.h>
//#import "HMScannerController.h"


@interface Xzb_OrderDetailHeadCell ()
@property (nonatomic,strong) UIImageView *qrCode;
@property (nonatomic,strong) UIImageView *statusImageView;
@property (nonatomic,strong) UIImageView *finishImageView;
@property (nonatomic, strong) UILabel *orderIdLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *orderTypeLabel;

@end

@implementation Xzb_OrderDetailHeadCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

+(NSString *)ID
{
    return @"Xzb_OrderDetailHeadCell";
}

+ (Xzb_OrderDetailHeadCell *)cellWithTableView:(UITableView *)tableView
{
    Xzb_OrderDetailHeadCell *cell = [tableView dequeueReusableCellWithIdentifier:[Xzb_OrderDetailHeadCell ID]];
    if (cell == nil) {
        cell = [[Xzb_OrderDetailHeadCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[Xzb_OrderDetailHeadCell ID]];
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

- (void)setupView {
    _qrCode = [[UIImageView alloc] initWithFrame:CGRectMake((SCREEN_Width*0.5)*0.5, 20, SCREEN_Width * 0.5, SCREEN_Width * 0.5)];
    [self.contentView addSubview:_qrCode];
    
    _orderIdLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(_qrCode.frame) + 20, SCREEN_Width - 20, 20)];
    _orderIdLabel.font = [UIFont systemFontOfSize:13];
    _orderIdLabel.textAlignment = NSTextAlignmentCenter;
    _orderIdLabel.textColor = AppMainGrayTextColor;
    [self.contentView addSubview:_orderIdLabel];
    
    _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(_orderIdLabel.frame), SCREEN_Width - 20, 20)];
    _timeLabel.textColor = [UIColor lightGrayColor];
    _timeLabel.textAlignment = NSTextAlignmentCenter;
    _timeLabel.font = [UIFont systemFontOfSize:13];
    [self.contentView addSubview:_timeLabel];
    
    
    self.cellHeight = CGRectGetMaxY(_timeLabel.frame) + 20;
    
    _statusImageView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_Width - 60, self.cellHeight - 60, 60, 60)];
    _statusImageView.contentMode = UIViewContentModeBottomRight;
    _statusImageView.hidden = YES;
    [self.contentView addSubview:_statusImageView];
    
    _finishImageView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_Width - 100 - 20, self.cellHeight - 100, 100, 100)];
    _finishImageView.contentMode = UIViewContentModeCenter;
    _finishImageView.hidden = YES;
    [self.contentView addSubview:_finishImageView];
    
    UIView *devider = [[UIView alloc] initWithFrame:CGRectMake(10, self.cellHeight - 1, SCREEN_Width, 1)];
    devider.backgroundColor = AppLineColor;
    [self.contentView addSubview:devider];
}
- (void)setModel:(Xzb_OrderDetailsModel *)model
{
    _model = model;
    if (!model) {
        return;
    }
    //二维码
    if (model.orderId && model.orderCode && model.businessId) {
        
//        NSString *str = [NSString stringWithFormat:@"{id:%@,orderCode:%@,businessId:%@}",model.orderId,model.orderCode,model.businessId];
//        @WeakObj(self)
//        [HMScannerController cardImageWithCardName:str avatar:nil scale:0.2 completion:^(UIImage *image) {
//            selfWeak.qrCode.image = image;
//        }];
        
        //        UIImage *img = [LBXScanWrapper createQRWithString:str size:_qrCode.frame.size];
        //        _qrCode.image = [LBXScanWrapper imageBlackToTransparent:img withRed:0.0f andGreen:0.0f andBlue:0.0f];
    }
    //订单号
    _orderIdLabel.text = [NSString stringWithFormat:@"订单号：%@",model.orderCode];
    //下单时间
    _timeLabel.text = [NSString stringWithFormat:@"下单时间：%@",model.orderDate];
    
    if ([model.checkinStatus intValue] == 2) {
        _statusImageView.image = [UIImage imageNamed:@"待入住"];
        _finishImageView.hidden = YES;
        _statusImageView.hidden = NO;
    }else if ([model.checkinStatus intValue] == 3) {
        _statusImageView.image = [UIImage imageNamed:@"已入住"];
        _finishImageView.hidden = YES;
        _statusImageView.hidden = NO;
    }else if ([model.checkinStatus intValue] == -1) {
        _statusImageView.image = [UIImage imageNamed:@"已取消"];
        _finishImageView.hidden = YES;
        _statusImageView.hidden = NO;
    }
    if ([model.orderStatus intValue] == 2) {
        _statusImageView.image = [UIImage imageNamed:@"已付款"];
        _finishImageView.hidden = YES;
        _statusImageView.hidden = NO;
    }else if ([model.orderStatus intValue] == 1) {
        _statusImageView.image = [UIImage imageNamed:@"待付款"];
        _finishImageView.hidden = YES;
        _statusImageView.hidden = NO;
    }else if ([model.orderStatus intValue] == -1) {
        _statusImageView.image = [UIImage imageNamed:@"已取消"];
        _finishImageView.hidden = YES;
        _statusImageView.hidden = NO;
    }else if ([model.orderStatus intValue] == 3) {
        _finishImageView.image = [UIImage imageNamed:@"已完成-0"];
        _finishImageView.hidden = NO;
        _statusImageView.hidden = YES;
    }else if ([model.orderStatus intValue] == -3) {
        _statusImageView.image = [UIImage imageNamed:@"已退款"];
        _finishImageView.hidden = YES;
        _statusImageView.hidden = NO;
    }else if ([model.orderStatus integerValue] == 6) {
        _statusImageView.image = [UIImage imageNamed:@"未入住"];
        _finishImageView.hidden = YES;
        _statusImageView.hidden = NO;
    }
    else{
        _finishImageView.hidden = YES;
        _statusImageView.hidden = YES;
    }
}
@end
