//
//  Xzb_FillOrderFooterView.m
//  xzb
//
//  Created by rainze on 16/7/21.
//  Copyright © 2016年 xuwk. All rights reserved.
//

#import "Xzb_FillOrderFooterView.h"

@implementation Xzb_FillOrderFooterView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setupView];
    }
    return self;
}

- (void)setupView {
    self.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    UILabel *labelA = [[UILabel alloc] initWithFrame:CGRectMake(5, 10, SCREEN_Width - 10, [self labelHeightWithText:@"•担保交易需支付房价的50%作为担保金, 退房离店后返还。"])];
    labelA.text = @"•担保交易需支付房价的50%作为担保金, 退房离店后返还。";
    labelA.numberOfLines = 0;
    labelA.textColor = [UIColor lightGrayColor];
    labelA.font = [UIFont systemFontOfSize:10];
    [self addSubview:labelA];
    
    UILabel *labelB = [[UILabel alloc] initWithFrame:CGRectMake(5, CGRectGetMaxY(labelA.frame), SCREEN_Width - 10, [self labelHeightWithText:@"•返现金额将在你离店后直接返现到您的账户余额, 可直接提现。"])];
    labelB.text = @"•返现金额将在你离店后直接返现到您的账户余额, 可直接提现。";
    labelB.font = [UIFont systemFontOfSize:10];
    labelB.numberOfLines = 0;
    labelB.textColor = [UIColor lightGrayColor];
    [self addSubview:labelB];
}

- (CGFloat )labelHeightWithText:(NSString *)text
{
    CGSize size = CGSizeMake(SCREEN_Width - 10, 45);
    CGSize labelSize = [text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:10]} context:nil].size;
    return labelSize.height;
}

@end
