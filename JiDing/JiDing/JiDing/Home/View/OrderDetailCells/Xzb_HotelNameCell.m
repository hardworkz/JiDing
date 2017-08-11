//
//  Xzb_HotelNameCell.m
//  xzb
//
//  Created by 张荣廷 on 16/7/28.
//  Copyright © 2016年 xuwk. All rights reserved.
//

#import "Xzb_HotelNameCell.h"

@implementation Xzb_HotelNameCell

+(NSString *)ID
{
    return @"Xzb_HotelNameCell";
}

+ (Xzb_HotelNameCell *)cellWithTableView:(UITableView *)tableView
{
    Xzb_HotelNameCell *cell = [tableView dequeueReusableCellWithIdentifier:[Xzb_HotelNameCell ID]];
    if (cell == nil) {
        cell = [[Xzb_HotelNameCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[Xzb_HotelNameCell ID]];
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
//    UIImageView *iconImageView = [[UIImageView alloc] init];
//    iconImageView.image = [UIImage imageNamed:@"酒店图标"];
//    iconImageView.contentMode = UIViewContentModeCenter;
//    iconImageView.frame = CGRectMake(0, 0, 50, 49);
//    [self.contentView addSubview:iconImageView];
//    self.iconImageView = iconImageView;
    
    UILabel *hotelNameLabel = [[UILabel alloc] init];
    hotelNameLabel.font = [UIFont boldSystemFontOfSize:17.];
    hotelNameLabel.frame = CGRectMake(0, 0, ScreenWidth, 49);
    hotelNameLabel.textAlignment = NSTextAlignmentCenter;
    hotelNameLabel.textColor = AppMainGrayTextColor;
    [self.contentView addSubview:hotelNameLabel];
    self.hotelNameLabel = hotelNameLabel;
}
@end
