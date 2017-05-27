//
//  SettingCell.m
//  xzb
//
//  Created by 张荣廷 on 16/5/26.
//  Copyright © 2016年 xuwk. All rights reserved.
//

#import "SettingCell.h"

@implementation SettingCell
+ (NSString *)ID
{
    return @"SettingCell";
}
+(SettingCell *)cellWithTableView:(UITableView *)tableView
{
    SettingCell *cell = [tableView dequeueReusableCellWithIdentifier:[SettingCell ID]];
    if (cell == nil) {
        cell = [[SettingCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[SettingCell ID]];
    }
    return cell;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        UIImageView *iconView = [[UIImageView alloc] init];
        iconView.frame = CGRectMake(10, 10, 30, 30);
        iconView.contentMode = UIViewContentModeCenter;
        [self.contentView addSubview:iconView];
        self.iconView = iconView;
        
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.frame = CGRectMake(CGRectGetMaxX(iconView.frame) + 10, 10, 100, 30);
        titleLabel.text = @"标题";
        titleLabel.font = [UIFont systemFontOfSize:17];
        [self.contentView addSubview:titleLabel];
        self.titleLabel = titleLabel;
        
        UIView *devider = [[UIView alloc] init];
        devider.backgroundColor = AppLineColor;
        devider.frame = CGRectMake(10, 49.5, SCREEN_Width, 0.5);
        [self.contentView addSubview:devider];
        self.devider = devider;
    }
    return self;
}

@end
