//
//  FillOrderHotelCell.m
//  xzb
//
//  Created by rainze on 16/7/21.
//  Copyright © 2016年 xuwk. All rights reserved.
//

#import "FillOrderHotelCell.h"

@interface FillOrderHotelCell ()

@property (nonatomic, strong) UIButton *hotel;
@property (nonatomic, strong) UILabel *stayLabel;
@property (nonatomic, strong) UILabel *stayTime;
@property (nonatomic, strong) UILabel *leaveLabel;
@property (nonatomic, strong) UILabel *leaveTime;
@property (nonatomic, strong) UIImageView *timeLogo;
@property (nonatomic, strong) UILabel *timeLabel;

@end

@implementation FillOrderHotelCell

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
    return @"FillOrderHotelCell";
}

+ (FillOrderHotelCell *)cellWithTableView:(UITableView *)tableView
{
    FillOrderHotelCell *cell = [tableView dequeueReusableCellWithIdentifier:[FillOrderHotelCell ID]];
    if (cell == nil) {
        cell = [[FillOrderHotelCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[FillOrderHotelCell ID]];
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

#pragma mark - 创建视图
- (void)setupView {
    _hotel = [[UIButton alloc] initWithFrame:CGRectMake(10, 10, SCREEN_Width - 20, 35)];
    _hotel.titleLabel.font = [UIFont systemFontOfSize:14];
    [_hotel setImage:[UIImage imageNamed:@"酒店图标"] forState:UIControlStateNormal];
    [_hotel setTitle:@"碧海蓝湾酒店" forState:UIControlStateNormal];
    _hotel.userInteractionEnabled = NO;
    [_hotel setTitleColor:AppMainGrayTextColor forState:UIControlStateNormal];
    _hotel.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [self.contentView addSubview:_hotel];
    
    _stayLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_hotel.frame), SCREEN_Width / 3, 30)];
    _stayLabel.text = @"入住";
    _stayLabel.textAlignment = NSTextAlignmentCenter;
    _stayLabel.textColor = [UIColor grayColor];
    _stayLabel.font = [UIFont systemFontOfSize:13];
    [self.contentView addSubview:_stayLabel];
    
    _timeLogo = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_Width / 3, CGRectGetMinY(_stayLabel.frame), SCREEN_Width / 3, 30)];
    _timeLogo.image = [UIImage imageNamed:@"时钟"];
    _timeLogo.contentMode = UIViewContentModeCenter;
    [self. contentView addSubview:_timeLogo];
    
    _leaveLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_Width * 2 / 3,CGRectGetMinY(_stayLabel.frame), SCREEN_Width / 3, 30)];
    _leaveLabel.textColor = [UIColor grayColor];
    _leaveLabel.textAlignment = NSTextAlignmentCenter;
    _leaveLabel.font = [UIFont systemFontOfSize:13];
    _leaveLabel.text = @"离开";
    [self.contentView addSubview:_leaveLabel];
    
    _stayTime = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_stayLabel.frame), SCREEN_Width / 3, 30)];
    _stayTime.textAlignment = NSTextAlignmentCenter;
    _stayTime.font = [UIFont systemFontOfSize:13];
    _stayTime.text = @"2016年7月15日";
    _stayTime.textColor = AppMainGrayTextColor;
    [self.contentView addSubview:_stayTime];
    
    _leaveTime = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_Width * 2 / 3, CGRectGetMaxY(_leaveLabel.frame), SCREEN_Width / 3, 30)];
    _leaveTime.textAlignment = NSTextAlignmentCenter;
    _leaveTime.font = [UIFont systemFontOfSize:13];
    _leaveTime.text = @"2016年7月16日";
    _leaveTime.textColor = AppMainGrayTextColor;
    [self.contentView addSubview:_leaveTime];
    
    _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_Width / 3, CGRectGetMaxY(_leaveLabel.frame), SCREEN_Width / 3, 30)];
    _timeLabel.textAlignment = NSTextAlignmentCenter;
    _timeLabel.font = [UIFont systemFontOfSize:13];
    _timeLabel.textColor = AppMainColor;
    _timeLabel.text = @"共 1 间 1 晚";
    [self.contentView addSubview:_timeLabel];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_timeLabel.frame) - 0.5, SCREEN_Width, 0.5)];
    line.backgroundColor = AppLineColor;
    [self.contentView addSubview:line];
    
}

- (void)setHotelModel:(Xzb_HotelDetailModel *)hotelModel
{
    [_hotel setTitle:[NSString stringWithFormat:@" %@",hotelModel.businessName] forState:UIControlStateNormal];
    _hotelModel = hotelModel;
    _timeLabel.text = hotelModel.roomDays;
    if (hotelModel.checkinDate.length >= 10) {
        _stayTime.text = [hotelModel.checkinDate substringToIndex:10];
    }else {
        _stayTime.text = hotelModel.checkinDate;
    }
    if (hotelModel.leaveDate.length >= 10) {
        _leaveTime.text = [hotelModel.leaveDate substringToIndex:10];
    }else {
        _leaveTime.text = hotelModel.leaveDate;
    }
}

@end
