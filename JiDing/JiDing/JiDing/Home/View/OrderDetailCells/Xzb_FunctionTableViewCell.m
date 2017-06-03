//
//  Xzb_FunctionTableViewCell.m
//  xzb
//
//  Created by 张荣廷 on 16/7/26.
//  Copyright © 2016年 xuwk. All rights reserved.
//

#import "Xzb_FunctionTableViewCell.h"

@implementation Xzb_FunctionTableViewCell

+(NSString *)ID
{
    return @"Xzb_FunctionTableViewCell";
}

+ (Xzb_FunctionTableViewCell *)cellWithTableView:(UITableView *)tableView
{
    Xzb_FunctionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[Xzb_FunctionTableViewCell ID]];
    if (cell == nil) {
        cell = [[Xzb_FunctionTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[Xzb_FunctionTableViewCell ID]];
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
    for (int i = 0; i<3; i++) {
        UIButton *functionBtn = [[UIButton alloc] init];
        functionBtn.frame = CGRectMake((ScreenWidth /3) * i, 5, (ScreenWidth /3), 60);
        functionBtn.tag = 10+i;
        [functionBtn setTitleColor:AppMainGrayTextColor forState:UIControlStateNormal];
        functionBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        functionBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [functionBtn addTarget:self action:@selector(functionBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:functionBtn];
        
        UIView *devider = [[UIView alloc] initWithFrame:CGRectMake((SCREEN_Width/3) * i, 20, 1, 30)];
        devider.backgroundColor = AppLineColor;
        [self.contentView addSubview:devider];
        
        if (i == 0) {
            [functionBtn setImage:[UIImage imageNamed:@"酒店图标"] forState:UIControlStateNormal];
            [functionBtn setTitle:@" 详情" forState:UIControlStateNormal];
        }else if (i == 1)
        {
            [functionBtn setImage:[UIImage imageNamed:@"联系电话"] forState:UIControlStateNormal];
            [functionBtn setTitle:@" 电话" forState:UIControlStateNormal];
        }else
        {
            [functionBtn setImage:[UIImage imageNamed:@"导航1"] forState:UIControlStateNormal];
            [functionBtn setTitle:@" 导航" forState:UIControlStateNormal];
        }
    }
}
- (void)functionBtnClicked:(UIButton *)button
{
    [[NSNotificationCenter defaultCenter] postNotificationName:OrderDetailCellFunctionClickedNotification object:nil userInfo:@{@"buttonTag":@(button.tag)}];
}
@end
