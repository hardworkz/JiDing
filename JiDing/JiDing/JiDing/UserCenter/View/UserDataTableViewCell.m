//
//  UserDataTableViewCell.m
//  JiDing
//
//  Created by zhangrongting on 2017/5/28.
//  Copyright © 2017年 zhangrongting. All rights reserved.
//

#import "UserDataTableViewCell.h"

@interface UserDataTableViewCell()
{
    UIImageView *header;
    UILabel *name;
    UILabel *sign;
    UIView *deviderView;
}
@end
@implementation UserDataTableViewCell
+ (NSString *)ID
{
    return @"UserDataTableViewCell";
}
+(UserDataTableViewCell *)cellWithTableView:(UITableView *)tableView
{
    UserDataTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[UserDataTableViewCell ID]];
    if (cell == nil) {
        cell = [[UserDataTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[UserDataTableViewCell ID]];
    }
    return cell;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        //用户头像
        header = [[UIImageView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 80)*0.5, 30, 80, 80)];
        header.contentMode = UIViewContentModeScaleAspectFill;
        header.layer.cornerRadius = header.width*0.5;
        header.clipsToBounds = YES;
        header.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:header];
        //用户昵称
        name = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(header.frame), SCREEN_WIDTH, 30)];
        [name setAppFontWithSize:17];
        name.text = @"来生";
        name.textAlignment = NSTextAlignmentCenter;
        name.textColor = AppDeepGrayTextColor;
        [self.contentView addSubview:name];
        //用户签名
        sign = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(name.frame), SCREEN_WIDTH - 20, 20)];
        [sign setAppFontWithSize:14];
        sign.numberOfLines = 0;
        sign.text = @"这个人很懒，什么都没留下";
        sign.textAlignment = NSTextAlignmentCenter;
        sign.textColor = AppLightGrayTextColor;
        [self.contentView addSubview:sign];
        //分割view
        deviderView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(sign.frame)+10, SCREEN_WIDTH, 10)];
        deviderView.backgroundColor = AppLightLineColor;
        [self.contentView addSubview:deviderView];
    }
    return self;
}

@end
