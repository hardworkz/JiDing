//
//  Xzb_OrderDetailCell.m
//  xzb
//
//  Created by 张荣廷 on 16/7/28.
//  Copyright © 2016年 xuwk. All rights reserved.
//

#import "Xzb_OrderDetailCell.h"

@implementation Xzb_OrderDetailCell

+(NSString *)ID
{
    return @"Xzb_OrderDetailCell";
}
+ (Xzb_OrderDetailCell *)cellWithTableView:(UITableView *)tableView
{
    Xzb_OrderDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:[Xzb_OrderDetailCell ID]];
    if (cell == nil) {
        cell = [[Xzb_OrderDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[Xzb_OrderDetailCell ID]];
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
    UIImageView *iconImageView = [[UIImageView alloc] init];
    iconImageView.contentMode = UIViewContentModeCenter;
    iconImageView.frame = CGRectMake(0, 0, 50, 50);
    [self.contentView addSubview:iconImageView];
    self.iconImageView = iconImageView;
    
    UILabel *contentLabel = [[UILabel alloc] init];
    contentLabel.frame = CGRectMake(CGRectGetMaxX(iconImageView.frame) - 10, 0, ScreenWidth * 0.6, 50);
    contentLabel.textColor = AppMainGrayTextColor;
    contentLabel.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:contentLabel];
    self.contentLabel = contentLabel;
    
    UILabel *accessoryLabel = [[UILabel alloc] init];
    accessoryLabel.frame = CGRectMake(ScreenWidth * 0.5 - 10, 0, ScreenWidth * 0.5, 50);
    accessoryLabel.textAlignment = NSTextAlignmentRight;
    accessoryLabel.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:accessoryLabel];
    self.accessoryLabel = accessoryLabel;
}
@end
