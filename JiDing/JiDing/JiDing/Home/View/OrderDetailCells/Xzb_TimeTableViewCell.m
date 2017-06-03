//
//  Xzb_TimeTableViewCell.m
//  xzb
//
//  Created by 张荣廷 on 16/7/26.
//  Copyright © 2016年 xuwk. All rights reserved.
//

#import "Xzb_TimeTableViewCell.h"

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
    for (int i = 0; i<2; i++) {
        UILabel *label = [[UILabel alloc] init];
        label.font = [UIFont systemFontOfSize:13];
        label.frame = CGRectMake((ScreenWidth/3 * 2) * i,10, ScreenWidth/3, 20);
        label.textColor = [UIColor lightGrayColor];
        label.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:label];
        
        UILabel *timeLabel = [[UILabel alloc] init];
        timeLabel.font = [UIFont systemFontOfSize:13];
        timeLabel.frame = CGRectMake((ScreenWidth/3 * 2) * i, CGRectGetMaxY(label.frame) + 5, ScreenWidth/3 , 20);
        timeLabel.textColor = AppMainGrayTextColor;
        timeLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:timeLabel];
        if (i == 0) {
            label.text = @"入住";
            timeLabel.textAlignment = NSTextAlignmentRight;
            timeLabel.text = @"2016年07月15日";
            self.starTimeLabel = timeLabel;
            
            //共几晚label
            UILabel *numOfDayLabel = [[UILabel alloc] init];
            numOfDayLabel.font = [UIFont systemFontOfSize:14];
            numOfDayLabel.frame = CGRectMake(0, CGRectGetMaxY(label.frame) + 5, ScreenWidth, 20);
            numOfDayLabel.textColor = AppMainColor;
            numOfDayLabel.textAlignment = NSTextAlignmentCenter;
            numOfDayLabel.text = @"共1间1晚";
            [self.contentView addSubview:numOfDayLabel];
            self.numOfDayLabel = numOfDayLabel;
            
            UIImageView *timeIconImageView = [[UIImageView alloc] initWithFrame:CGRectMake((ScreenWidth - 30) * 0.5, label.y - 5, 30, 30)];
            timeIconImageView.image = [UIImage imageNamed:@"时钟"];
            timeIconImageView.contentMode = UIViewContentModeCenter;
            [self.contentView addSubview:timeIconImageView];
        }else{
            label.text = @"离开";
            timeLabel.textAlignment = NSTextAlignmentLeft;
            timeLabel.text = @"2016年07月16日";
            self.endTimeLabel = timeLabel;
        }
    }
    UIView *devider = [[UIView alloc] initWithFrame:CGRectMake(0, 69, SCREEN_Width, 1)];
    devider.backgroundColor = AppLineColor;
    [self.contentView addSubview:devider];
}
- (void)setModel:(Xzb_OrderDetailsModel *)model
{
    _model = model;
    if (model == nil) {
        return;
    }
    //设置数据
    self.starTimeLabel.text = model.checkinDate;
    self.endTimeLabel.text = model.leaveDate;
    self.numOfDayLabel.text = [NSString stringWithFormat:@"共%@间%@晚",model.num,model.dateGap];
}
@end
