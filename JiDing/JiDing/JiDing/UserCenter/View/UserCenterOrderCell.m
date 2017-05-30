//
//  UserCenterOrderCell.m
//  JiDing
//
//  Created by zhangrongting on 2017/5/28.
//  Copyright © 2017年 zhangrongting. All rights reserved.
//

#import "UserCenterOrderCell.h"

@interface UserCenterOrderCell ()
{
    UILabel *myOrder;
    UIButton *more;
    UIImageView *rightArrow;
    UILabel *orderNum;
    UIView *devider;
    UILabel *orderState;
    UIImageView *orderImage;
    UILabel *hotelName;
    UILabel *roomTypeName;
    UILabel *time;
    UILabel *orderPrice;
    UIView *deviderView;
}
@end
@implementation UserCenterOrderCell

+ (NSString *)ID
{
    return @"UserCenterOrderCell";
}
+(UserCenterOrderCell *)cellWithTableView:(UITableView *)tableView
{
    UserCenterOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:[UserCenterOrderCell ID]];
    if (cell == nil) {
        cell = [[UserCenterOrderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[UserCenterOrderCell ID]];
    }
    return cell;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        myOrder = [[UILabel alloc] initWithFrame:CGRectMake(5,10, SCREEN_WIDTH * 0.5, 20)];
        [myOrder setAppFontWithSize:16];
        myOrder.text = @"我的订单";
        myOrder.textColor = AppDeepGrayTextColor;
        [self.contentView addSubview:myOrder];
        
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
        
        //订单编号
        orderNum = [[UILabel alloc] initWithFrame:CGRectMake(5,CGRectGetMaxY(myOrder.frame) + 30, SCREEN_WIDTH - 60, 20)];
        [orderNum setAppFontWithSize:15];
        orderNum.text = @"订单号:15555666666645444";
        orderNum.textColor = AppGrayTextColor;
        [self.contentView addSubview:orderNum];
        //订单状态
        orderState = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 60,orderNum.y, 50, 20)];
        [orderState setAppFontWithSize:15];
        orderState.textAlignment = NSTextAlignmentRight;
        orderState.text = @"待付款";
        orderState.textColor = AppGreenTextColor;
        [self.contentView addSubview:orderState];
        //分割线
        devider = [[UIView alloc] initWithFrame:CGRectMake(5, CGRectGetMaxY(orderNum.frame) + 10, SCREEN_WIDTH - 10, 0.5)];
        devider.backgroundColor = AppLightLineColor;
        [self.contentView addSubview:devider];
        //酒店图标
        orderImage = [[UIImageView alloc] initWithFrame:CGRectMake(5, CGRectGetMaxY(devider.frame) + 10, 30, 90)];
        orderImage.image = [UIImage imageNamed:@"hotel"];
        orderImage.contentMode = UIViewContentModeCenter;
        [self.contentView addSubview:orderImage];
        //酒店名称
        hotelName = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(orderImage.frame) + 5,orderImage.y, SCREEN_WIDTH - 100 - 30 - 5, 30)];
        [hotelName setAppFontWithSize:15];
        hotelName.text = @"碧海蓝湾大酒店";
        hotelName.textColor = AppGrayTextColor;
        [self.contentView addSubview:hotelName];
        //酒店房间类型
        roomTypeName = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(orderImage.frame)+5,CGRectGetMaxY(hotelName.frame), SCREEN_WIDTH - 100 - 30 - 5, 30)];
        [roomTypeName setAppFontWithSize:14];
        roomTypeName.text = @"豪华大床房";
        roomTypeName.textColor = AppGrayTextColor;
        [self.contentView addSubview:roomTypeName];
        //入住时间
        time = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(orderImage.frame)+5,CGRectGetMaxY(roomTypeName.frame), SCREEN_WIDTH - 100 - 30 - 5, 30)];
        [time setAppFontWithSize:14];
        time.text = @"入住时间：06-20至06-22";
        time.textColor = AppGrayTextColor;
        [self.contentView addSubview:time];
        //订单价格
        orderPrice = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 100,orderImage.centerY - 10, 90, 20)];
        [orderPrice setAppFontWithSize:15];
        orderPrice.textAlignment = NSTextAlignmentRight;
        orderPrice.text = @"¥500";
        orderPrice.textColor = AppGreenTextColor;
        [self.contentView addSubview:orderPrice];
        //分割view
        deviderView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(orderImage.frame)+10, SCREEN_WIDTH, 10)];
        deviderView.backgroundColor = AppLightLineColor;
        [self.contentView addSubview:deviderView];
    }
    return self;
}
@end
