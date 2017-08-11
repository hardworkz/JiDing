//
//  FillOrderHotelCell.m
//  xzb
//
//  Created by rainze on 16/7/21.
//  Copyright © 2016年 xuwk. All rights reserved.
//

#import "FillOrderHotelCell.h"

#define NumDayW 100
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
    _hotel = [[UIButton alloc] initWithFrame:CGRectMake(10, 5, SCREEN_Width - 20, 35)];
    _hotel.titleLabel.font = [UIFont systemFontOfSize:18];
    [_hotel setTitle:@"碧海蓝湾酒店" forState:UIControlStateNormal];
    _hotel.userInteractionEnabled = NO;
    [_hotel setTitleColor:AppMainGrayTextColor forState:UIControlStateNormal];
    _hotel.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [self.contentView addSubview:_hotel];
    
    //入住日期
    UILabel *starTimeLabel = [[UILabel alloc] init];
    [starTimeLabel setAppFontWithSize:16.0];
    starTimeLabel.frame = CGRectMake(0, CGRectGetMaxY(_hotel.frame), (SCREEN_WIDTH - NumDayW - 25)* 0.5, 60);
    starTimeLabel.textColor = AppMainGrayTextColor;
    starTimeLabel.textAlignment = NSTextAlignmentCenter;
    starTimeLabel.numberOfLines = 0;
    [self.contentView addSubview:starTimeLabel];
    self.stayTime = starTimeLabel;
    //箭头和至
    UIImageView *rightArrow = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(starTimeLabel.frame), starTimeLabel.y + 3, 25, 25)];
    rightArrow.image = [UIImage imageNamed:@"入住箭头"];
    rightArrow.contentMode = UIViewContentModeCenter;
    [self.contentView addSubview:rightArrow];
    
    UILabel *zhi = [[UILabel alloc] init];
    zhi.font = [UIFont systemFontOfSize:16];
    zhi.frame = CGRectMake(rightArrow.x, CGRectGetMaxY(rightArrow.frame), 25, 25);
    zhi.text = @"至";
    zhi.textColor = AppMainGrayTextColor;
    zhi.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:zhi];
    //离店日期
    UILabel *endTimeLabel = [[UILabel alloc] init];
    [endTimeLabel setAppFontWithSize:16.0];
    endTimeLabel.frame = CGRectMake(SCREEN_WIDTH - NumDayW - (SCREEN_WIDTH - NumDayW - 25)* 0.5, starTimeLabel.y, (SCREEN_WIDTH - NumDayW - 25)* 0.5, 60);
    endTimeLabel.textColor = AppMainGrayTextColor;
    endTimeLabel.textAlignment = NSTextAlignmentCenter;
    endTimeLabel.numberOfLines = 0;
    [self.contentView addSubview:endTimeLabel];
    self.leaveTime = endTimeLabel;
    //时钟图标
    UIImageView *timeIconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - NumDayW, starTimeLabel.y, NumDayW, 30)];
    timeIconImageView.image = [UIImage imageNamed:@"入住时间"];
    timeIconImageView.contentMode = UIViewContentModeCenter;
    [self.contentView addSubview:timeIconImageView];
    //共几晚label
    UILabel *numOfDayLabel = [[UILabel alloc] init];
    numOfDayLabel.font = [UIFont systemFontOfSize:16];
    numOfDayLabel.frame = CGRectMake(SCREEN_WIDTH - NumDayW, CGRectGetMaxY(timeIconImageView.frame) + 2, NumDayW, 20);
    numOfDayLabel.textColor = AppGreenTextColor;
    numOfDayLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:numOfDayLabel];
    self.timeLabel = numOfDayLabel;
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(starTimeLabel.frame) - 0.5, SCREEN_Width, 0.5)];
    line.backgroundColor = AppLightLineColor;
    [self.contentView addSubview:line];
}

- (void)setHotelModel:(Xzb_HotelDetailModel *)hotelModel
{
    _hotelModel = hotelModel;
    
    [_hotel setTitle:[NSString stringWithFormat:@" %@",hotelModel.businessName] forState:UIControlStateNormal];
    _hotelModel = hotelModel;
    _timeLabel.text = hotelModel.roomDays;
    if (hotelModel.checkinDate.length >= 10) {
        _stayTime.text = [NSString stringWithFormat:@"入住\n%@",[hotelModel.checkinDate substringToIndex:10]];
    }else {
        _stayTime.text = [NSString stringWithFormat:@"入住\n%@",hotelModel.checkinDate];
    }
    if (hotelModel.leaveDate.length >= 10) {
        _leaveTime.text = [NSString stringWithFormat:@"离店\n%@",[hotelModel.leaveDate substringToIndex:10]];
    }else {
        _leaveTime.text = [NSString stringWithFormat:@"离店\n%@",hotelModel.leaveDate];
    }
}

@end
