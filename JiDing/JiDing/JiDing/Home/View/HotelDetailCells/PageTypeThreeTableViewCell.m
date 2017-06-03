//
//  PageTypeThreeTableViewCell.m
//  xzb
//
//  Created by 张荣廷 on 16/7/20.
//  Copyright © 2016年 xuwk. All rights reserved.
//

#import "PageTypeThreeTableViewCell.h"

@interface PageTypeThreeTableViewCell ()
@property (nonatomic,weak)  RatingBar *gradeBar;
@property (nonatomic,weak)  UILabel *scoreLabel;
@end
@implementation PageTypeThreeTableViewCell
+ (NSString *)ID
{
    return @"PageTypeThreeTableViewCell";
}
+(PageTypeThreeTableViewCell *)cellWithTableView:(UITableView *)tableView
{
    PageTypeThreeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[PageTypeThreeTableViewCell ID]];
    if (cell == nil) {
        cell = [[PageTypeThreeTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[PageTypeThreeTableViewCell ID]];
    }
    return cell;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 50)];
        contentView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:contentView];
        
        //星级评分
        RatingBar *gradeBar = [[RatingBar alloc] initWithFrame:CGRectMake(13, 5, 120, 30)];
        gradeBar.backgroundColor = [UIColor clearColor];
        gradeBar.enable = NO;
        gradeBar.starNumber = 5;
        [contentView addSubview:gradeBar];
        self.gradeBar = gradeBar;
        
        UILabel *scoreLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(gradeBar.frame) - 10, 5,100, 30)];
        scoreLabel.textColor = [UIColor lightGrayColor];
        scoreLabel.text = @"0分";
        scoreLabel.textAlignment = NSTextAlignmentLeft;
        scoreLabel.font = [UIFont systemFontOfSize:15];
        [contentView addSubview:scoreLabel];
        self.scoreLabel = scoreLabel;
        
        UILabel *rateLabel = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth * 0.5 - 20, 5,ScreenWidth * 0.5, 30)];
        rateLabel.textColor = [UIColor lightGrayColor];
        rateLabel.text = @"好评率:0%";
        rateLabel.textAlignment = NSTextAlignmentRight;
        rateLabel.font = [UIFont systemFontOfSize:15];
        [contentView addSubview:rateLabel];
        self.rateLabel = rateLabel;
    }
    return self;
}
- (void)setModel:(Xzb_HotelDetailModel *)model
{
    _model = model;
    if (model == nil) {
        return;
    }
    //星星
    self.gradeBar.starNumber = [model.score integerValue];
    //评分
    self.scoreLabel.text = [NSString stringWithFormat:@"%@分",model.score];
}
@end
