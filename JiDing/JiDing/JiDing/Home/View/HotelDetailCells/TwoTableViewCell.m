//
//  TwoTableViewCell.m
//  xzb
//
//  Created by 张荣廷 on 16/7/19.
//  Copyright © 2016年 xuwk. All rights reserved.
//

#import "TwoTableViewCell.h"

@implementation TwoTableViewCell
+ (NSString *)ID
{
    return @"TwoTableViewCell";
}
+(TwoTableViewCell *)cellWithTableView:(UITableView *)tableView
{
    TwoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[TwoTableViewCell ID]];
    if (cell == nil) {
        cell = [[TwoTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[TwoTableViewCell ID]];
    }
    return cell;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = AppMainBgColor;
        UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 110 - 9)];
        contentView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:contentView];
        self.contentsView = contentView;
        
        for (int i = 0; i<3; i++) {
            UIButton *button = [[UIButton alloc] init];
            button.frame = CGRectMake(ScreenWidth/3 * i, 0, ScreenWidth/3, 80);
            button.tag = i + 10;
            button.imageView.contentMode = UIViewContentModeCenter;
            [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
            [contentView addSubview:button];
            
            UILabel *titleLabel = [[UILabel alloc] init];
            titleLabel.frame = CGRectMake(button.x, CGRectGetMaxY(button.frame) - 10, ScreenWidth/3, 30);
            titleLabel.textAlignment = NSTextAlignmentCenter;
            titleLabel.textColor = AppMainGrayTextColor;
            titleLabel.font = [UIFont systemFontOfSize:13];
            [contentView addSubview:titleLabel];
            
            if (i == 0) {
                titleLabel.text = @"酒店介绍";
                [button setImage:[UIImage imageNamed:@"酒店介绍"] forState:UIControlStateNormal];
            }else if (i == 1){
                titleLabel.text = @"地图导航";
                [button setImage:[UIImage imageNamed:@"地图导航"] forState:UIControlStateNormal];
            }else{
                titleLabel.text = @"在住好友";
                [button setImage:[UIImage imageNamed:@"在住好友"] forState:UIControlStateNormal];
            }
        }
    }
    return self;
}
- (void)buttonClicked:(UIButton *)button
{
    [[NSNotificationCenter defaultCenter] postNotificationName:HotelDetailTwoCellBtnClickedNotification object:nil userInfo:@{@"buttonTag":@(button.tag)}];
}
@end
