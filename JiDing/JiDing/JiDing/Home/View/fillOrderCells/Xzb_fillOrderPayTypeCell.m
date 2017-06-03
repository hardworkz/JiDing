//
//  Xzb_fillOrderPayTypeCell.m
//  xzb
//
//  Created by rainze on 16/7/21.
//  Copyright © 2016年 xuwk. All rights reserved.
//

#import "Xzb_fillOrderPayTypeCell.h"

@interface Xzb_fillOrderPayTypeCell ()

@property (nonatomic, strong) UIButton *room;
@property (nonatomic, strong) UILabel *monyLabel;
@property (nonatomic, strong) UIButton *payType;
@property (nonatomic, strong) UIButton *prepaidButton; // 预付
@property (nonatomic, strong) UIButton *securedButton; // 担保

@end

@implementation Xzb_fillOrderPayTypeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (NSString *)ID
{
    return @"Xzb_fillOrderPayTypeCell";
}

+ (Xzb_fillOrderPayTypeCell *)cellWithTableView:(UITableView *)tableView
{
    Xzb_fillOrderPayTypeCell *cell = [tableView dequeueReusableCellWithIdentifier:[Xzb_fillOrderPayTypeCell ID]];
    if (cell == nil) {
        cell = [[Xzb_fillOrderPayTypeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[Xzb_fillOrderPayTypeCell ID]];
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
    _room = [[UIButton alloc] initWithFrame:CGRectMake(10, 0, (SCREEN_Width - 20) / 2, 45)];
    [_room setTitle:@"豪华大床房" forState:UIControlStateNormal];
    [_room setTitleColor:AppMainGrayTextColor forState:UIControlStateNormal];
    [_room setImage:[UIImage imageNamed:@"豪华大床房1"] forState:UIControlStateNormal];
    _room.titleLabel.font = [UIFont systemFontOfSize:14];
    _room.userInteractionEnabled = NO;
    _room.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [self.contentView addSubview:_room];
    
    _monyLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_room.frame), 0, (SCREEN_Width - 20) / 2, 45)];
    _monyLabel.font = [UIFont systemFontOfSize:14];
    _monyLabel.textColor = AppMainColor;
    _monyLabel.textAlignment = NSTextAlignmentRight;
    _monyLabel.text = @"¥200";
    [self.contentView addSubview:_monyLabel];
    
    _payType = [[UIButton alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(_room.frame), (SCREEN_Width - 20) / 2, 45)];
    [_payType setTitle:@" 付款方式" forState:UIControlStateNormal];
    [_payType setTitleColor:AppMainGrayTextColor forState:UIControlStateNormal];
    [_payType setImage:[UIImage imageNamed:@"付款方式"] forState:UIControlStateNormal];
    _payType.titleLabel.font = [UIFont systemFontOfSize:14];
    _payType.userInteractionEnabled = NO;
    _payType.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [self.contentView addSubview:_payType];
    
    _prepaidButton = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_payType.frame), CGRectGetMaxY(_monyLabel.frame), _payType.frame.size.width / 2 - 10, 45)];
    [_prepaidButton setTitle:@"预付" forState:UIControlStateNormal];
    [_prepaidButton setImage:[UIImage imageNamed:@"未选中支付类型"] forState:UIControlStateNormal];
    [_prepaidButton setImage:[UIImage imageNamed:@"选中支付类型"] forState:UIControlStateSelected];
    _prepaidButton.selected = YES;
    _prepaidButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [_prepaidButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    _prepaidButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [self.contentView addSubview:_prepaidButton];
    
    _securedButton = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_prepaidButton.frame), CGRectGetMaxY(_monyLabel.frame), _payType.frame.size.width / 2 + 10, 45)];
    [_securedButton setTitle:@"担保交易" forState:UIControlStateNormal];
    [_securedButton setImage:[UIImage imageNamed:@"选中支付类型"] forState:UIControlStateSelected];
    [_securedButton setImage:[UIImage imageNamed:@"未选中支付类型"] forState:UIControlStateNormal];
    _securedButton.titleLabel.font = [UIFont systemFontOfSize:14];
   [_securedButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    _securedButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [self.contentView addSubview:_securedButton];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(_securedButton.frame) - 0.5, SCREEN_Width - 10, 0.5)];
    line.backgroundColor = AppLineColor;
    [self.contentView addSubview:line];
}

- (void)setHotelModel:(Xzb_HotelDetailModel *)hotelModel
{
    _hotelModel = hotelModel;
    [_room setTitle:[NSString stringWithFormat:@" %@", hotelModel.roomName ] forState:UIControlStateNormal];
    _monyLabel.text = [NSString stringWithFormat:@"¥%@",_hotelModel.price];
    if (hotelModel.typeArray.count == 2) {// 123,对应预付，担保交易，到付
        _prepaidButton.hidden = NO;
        for (NSString *type in hotelModel.typeArray) {
            if ([type integerValue] == 1) {
                [_prepaidButton setTitle:@"预付" forState:UIControlStateNormal];
                _prepaidButton.tag = 1000 + [type integerValue];
                [_prepaidButton addTarget:self action:@selector(prepaid:) forControlEvents:UIControlEventTouchUpInside];
            }else if ([type integerValue] == 2) {
                [_securedButton setTitle:@"担保交易" forState:UIControlStateNormal];
                _securedButton.tag = 1000 + [type integerValue];
                [_securedButton addTarget:self action:@selector(secured:) forControlEvents:UIControlEventTouchUpInside];
            }else {
                [_securedButton setTitle:@"到付" forState:UIControlStateNormal];
                _securedButton.tag = 1000 + [type integerValue];
                [_securedButton addTarget:self action:@selector(toPay:) forControlEvents:UIControlEventTouchUpInside];
            }
        }
    }else if (hotelModel.typeArray.count == 1) {
        _securedButton.selected = YES;
        _securedButton.tag = 1000 + [hotelModel.payType intValue];
        if ([hotelModel.payType integerValue]== 1) {
            _prepaidButton.hidden = YES;
            [_securedButton setTitle:@"预付" forState:UIControlStateNormal];
            [_securedButton addTarget:self action:@selector(prepaid:) forControlEvents:UIControlEventTouchUpInside];
        }else if ([hotelModel.payType integerValue]== 2) {
            _prepaidButton.hidden = YES;
            [_securedButton setTitle:@"担保交易" forState:UIControlStateNormal];
            [_securedButton addTarget:self action:@selector(secured:) forControlEvents:UIControlEventTouchUpInside];
            _securedButton.userInteractionEnabled = NO;
        }else {
            _prepaidButton.hidden = YES;
            [_securedButton setTitle:@"到付" forState:UIControlStateNormal];
            [_securedButton addTarget:self action:@selector(toPay:) forControlEvents:UIControlEventTouchUpInside];
        }
    }
}

#pragma mark - 预付
- (void)prepaid:(UIButton *)button {
    button.selected = YES;
    if (self.hotelModel.typeArray.count == 1) {
        _securedButton = button;
    }else {
        if (button != _securedButton) {
            _securedButton.selected = NO;
        }else {
            _securedButton.selected = NO;
            _prepaidButton = button;
            
        }
    }
    
    if (self.payTypeClick) {
        self.payTypeClick([NSString stringWithFormat:@"%zd",button.tag - 1000]);
    }
}

#pragma mark - 担保交易
- (void)secured:(UIButton *)button {
    button.selected = YES;
    if (button != _prepaidButton) {
        _prepaidButton.selected = NO;
    }else {
        _prepaidButton = button;
    }
    if (self.payTypeClick) {
        RTLog(@"担保交易的tag是：%zd",button.tag);
        self.payTypeClick([NSString stringWithFormat:@"%zd",button.tag - 1000]);
    }
}

#pragma mark - 到付
- (void)toPay:(UIButton *)button {
    button.selected = YES;
    if (button != _prepaidButton) {
        _prepaidButton.selected = NO;
    }else {
        _prepaidButton = button;
    }
    if (self.payTypeClick) {
        self.payTypeClick([NSString stringWithFormat:@"%zd",button.tag - 1000]);
    }
}

@end
