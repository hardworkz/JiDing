//
//  AreaTableViewCell.m
//  xzb
//
//  Created by 张荣廷 on 16/6/1.
//  Copyright © 2016年 xuwk. All rights reserved.
//

#import "AreaTableViewCell.h"

@implementation AreaTableViewCell

+ (NSString *)ID
{
    return @"AreaTableViewCell";
}
+(AreaTableViewCell *)cellWithTableView:(UITableView *)tableView
{
    AreaTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[AreaTableViewCell ID]];
    if (cell == nil) {
        cell = [[AreaTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[AreaTableViewCell ID]];
    }
    return cell;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.frame = CGRectMake(0, 0, SCREEN_Width * 0.3, 50);
        titleLabel.text = @"地区";
        titleLabel.textColor = AppMainGrayTextColor;
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:titleLabel];
        self.titleLabel = titleLabel;
        
        UIView *devider = [[UIView alloc] init];
        devider.backgroundColor = AppLineColor;
        devider.frame = CGRectMake(0, 49, SCREEN_Width * 0.3, 1);
        [self.contentView addSubview:devider];
    }
    return self;
}


@end
