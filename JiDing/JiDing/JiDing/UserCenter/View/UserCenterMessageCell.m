//
//  UserCenterMessageCell.m
//  JiDing
//
//  Created by zhangrongting on 2017/5/28.
//  Copyright © 2017年 zhangrongting. All rights reserved.
//

#import "UserCenterMessageCell.h"

@interface UserCenterMessageCell ()
{
    UILabel *myMessage;
    UIButton *more;
    UIImageView *rightArrow;
    UILabel *noMessageTip;
}
@end
@implementation UserCenterMessageCell

+ (NSString *)ID
{
    return @"UserCenterMessageCell";
}
+(UserCenterMessageCell *)cellWithTableView:(UITableView *)tableView
{
    UserCenterMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:[UserCenterMessageCell ID]];
    if (cell == nil) {
        cell = [[UserCenterMessageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[UserCenterMessageCell ID]];
    }
    return cell;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        myMessage = [[UILabel alloc] initWithFrame:CGRectMake(5,10, SCREEN_WIDTH * 0.5, 20)];
        [myMessage setAppFontWithSize:16];
        myMessage.text = @"我的消息";
        myMessage.textColor = AppDeepGrayTextColor;
        [self.contentView addSubview:myMessage];
        
        more = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 15 - 50,10, 50, 20)];
        [more.titleLabel setAppFontWithSize:16];
        more.titleLabel.textAlignment = NSTextAlignmentRight;
        [more setTitle:@"more"];
        [more setTitleColor:AppLightGrayTextColor];
        [self.contentView addSubview:more];
        
        rightArrow = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 20, 10, 10, 20)];
        rightArrow.image = [UIImage imageNamed:@"入住箭头"];
        rightArrow.contentMode = UIViewContentModeCenter;
        [self.contentView addSubview:rightArrow];
        
        noMessageTip = [[UILabel alloc] initWithFrame:CGRectMake(0,90, SCREEN_WIDTH, 20)];
        [noMessageTip setAppFontWithSize:14];
        noMessageTip.text = @"暂无最新消息";
        noMessageTip.textAlignment = NSTextAlignmentCenter;
        noMessageTip.textColor = AppLightGrayTextColor;
        [self.contentView addSubview:noMessageTip];
    }
    return self;
}

@end
