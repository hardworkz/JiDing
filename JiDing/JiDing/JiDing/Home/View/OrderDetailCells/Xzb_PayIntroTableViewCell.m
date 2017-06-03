//
//  Xzb_PayIntroTableViewCell.m
//  xzb
//
//  Created by 张荣廷 on 16/7/26.
//  Copyright © 2016年 xuwk. All rights reserved.
//

#import "Xzb_PayIntroTableViewCell.h"

@implementation Xzb_PayIntroTableViewCell

+(NSString *)ID
{
    return @"Xzb_PayIntroTableViewCell";
}

+ (Xzb_PayIntroTableViewCell *)cellWithTableView:(UITableView *)tableView
{
    Xzb_PayIntroTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[Xzb_PayIntroTableViewCell ID]];
    if (cell == nil) {
        cell = [[Xzb_PayIntroTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[Xzb_PayIntroTableViewCell ID]];
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
    UILabel *labelA = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, SCREEN_Width - 10, 25)];
    labelA.text = @"•担保交易需支付房价的50%作为担保金, 退房离店后返还。";
    labelA.numberOfLines = 0;
    labelA.textColor = [UIColor lightGrayColor];
    labelA.font = [UIFont systemFontOfSize:11];
    [self.contentView addSubview:labelA];
    
    UILabel *labelB = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(labelA.frame), SCREEN_Width - 10, 25)];
    labelB.text = @"•返现金额将在你离店后直接返现到您的账户余额, 可直接提现。";
    labelB.font = [UIFont systemFontOfSize:11];
    labelB.numberOfLines = 0;
    labelB.textColor = [UIColor lightGrayColor];
    [self.contentView addSubview:labelB];
}
@end
