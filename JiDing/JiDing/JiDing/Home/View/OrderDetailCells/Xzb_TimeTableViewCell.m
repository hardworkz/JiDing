//
//  Xzb_TimeTableViewCell.m
//  xzb
//
//  Created by 张荣廷 on 16/7/26.
//  Copyright © 2016年 xuwk. All rights reserved.
//

#import "Xzb_TimeTableViewCell.h"

#define NumDayW 100
@interface Xzb_TimeTableViewCell ()
@property (nonatomic,weak)  UILabel *starTimeLabel;
@property (nonatomic,weak)  UILabel *endTimeLabel;
@property (nonatomic,weak)  UILabel *numOfDayLabel;
@end
@implementation Xzb_TimeTableViewCell


+(NSString *)ID
{
    return @"Xzb_TimeTableViewCell";
}

+ (Xzb_TimeTableViewCell *)cellWithTableView:(UITableView *)tableView
{
    Xzb_TimeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[Xzb_TimeTableViewCell ID]];
    if (cell == nil) {
        cell = [[Xzb_TimeTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[Xzb_TimeTableViewCell ID]];
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
- (void)setupView
{
    //入住日期
    UILabel *starTimeLabel = [[UILabel alloc] init];
    [starTimeLabel setAppFontWithSize:16.0];
    starTimeLabel.frame = CGRectMake(0, 10, (SCREEN_WIDTH - NumDayW - 25)* 0.5, 60);
    starTimeLabel.textColor = AppMainGrayTextColor;
    starTimeLabel.textAlignment = NSTextAlignmentCenter;
    starTimeLabel.numberOfLines = 0;
    [self.contentView addSubview:starTimeLabel];
    self.starTimeLabel = starTimeLabel;
    //箭头和至
    UIImageView *rightArrow = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(starTimeLabel.frame) + 3, starTimeLabel.y, 25, 25)];
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
    self.endTimeLabel = endTimeLabel;
    //时钟图标
    UIImageView *timeIconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - NumDayW, starTimeLabel.y - 5 -3, NumDayW, 30)];
    timeIconImageView.image = [UIImage imageNamed:@"入住时间"];
    timeIconImageView.contentMode = UIViewContentModeCenter;
    [self.contentView addSubview:timeIconImageView];
    //共几晚label
    UILabel *numOfDayLabel = [[UILabel alloc] init];
    numOfDayLabel.font = [UIFont systemFontOfSize:16];
    numOfDayLabel.frame = CGRectMake(SCREEN_WIDTH - NumDayW, starTimeLabel.y + 20, NumDayW, 20);
    numOfDayLabel.textColor = AppGreenTextColor;
    numOfDayLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:numOfDayLabel];
    self.numOfDayLabel = numOfDayLabel;

    UIView *devider = [[UIView alloc] initWithFrame:CGRectMake(0, 69, SCREEN_Width, 1)];
    devider.backgroundColor = AppLightLineColor;
    [self.contentView addSubview:devider];
}
- (void)setModel:(Xzb_OrderDetailsModel *)model
{
    _model = model;
    if (model == nil) {
        return;
    }
    //设置数据
    self.starTimeLabel.text = [NSString stringWithFormat:@"入住\n%@",model.checkinDate];
    self.endTimeLabel.text = [NSString stringWithFormat:@"离店\n%@",model.leaveDate];
    self.numOfDayLabel.text = [NSString stringWithFormat:@"共%@间%@晚",model.num,model.dateGap];
}
@end
