//
//  StayInFriendsTableViewCell.m
//  xzb
//
//  Created by 张荣廷 on 16/7/22.
//  Copyright © 2016年 xuwk. All rights reserved.
//

#import "StayInFriendsTableViewCell.h"

@interface StayInFriendsTableViewCell ()
@property (nonatomic , weak) UIImageView *headView;
@property (nonatomic , weak) UILabel *nameLabel;
@property (nonatomic , weak) UILabel *timeLabel;
@property (nonatomic , weak) UILabel *nperLabel;
@property (nonatomic , weak) UIView *devider;
@property (nonatomic , weak) UILabel *contentLabel;
@end
@implementation StayInFriendsTableViewCell
+ (NSString *)ID
{
    return @"StayInFriendsTableViewCell";
}
+ (StayInFriendsTableViewCell *)cellWithTableView:(UITableView *)tableView
{
    StayInFriendsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[StayInFriendsTableViewCell ID]];
    if (cell == nil) {
        cell = [[StayInFriendsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[StayInFriendsTableViewCell ID]];
    }
    return cell;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        UITapGestureRecognizer *headTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(headTap)];
        UIImageView *headView = [[UIImageView alloc] init];
        headView.image = [UIImage imageNamed:@"头像－默认"];
        headView.clipsToBounds = YES;
        [self.contentView addSubview:headView];
        [headView addGestureRecognizer:headTap];
        self.headView = headView;
        
        UILabel *nameLabel = [[UILabel alloc] init];
        nameLabel.font = [UIFont systemFontOfSize:17];
        [self.contentView addSubview:nameLabel];
        self.nameLabel = nameLabel;
        
        UILabel *timeLabel = [[UILabel alloc] init];
        timeLabel.font = [UIFont systemFontOfSize:15];
        timeLabel.textColor = AppMainGrayTextColor;
        [self.contentView addSubview:timeLabel];
        self.timeLabel = timeLabel;
        
        UILabel *contentLabel = [[UILabel alloc] init];
        contentLabel.font = [UIFont systemFontOfSize:15];
        contentLabel.numberOfLines = 0;
        contentLabel.textColor = AppMainGrayTextColor;
        [self.contentView addSubview:contentLabel];
        self.contentLabel = contentLabel;
        
        UIView *devider = [[UIView alloc] init];
        devider.backgroundColor = AppLineColor;
        [self.contentView addSubview:devider];
        self.devider = devider;
    }
    return self;
}

#pragma mark - 按钮点击事件
- (void)headTap
{
    id object = [self nextResponder];
    
    while (![object isKindOfClass:[UIViewController class]] &&
           object != nil) {
        object = [object nextResponder];
    }
    
//    Xzb_OtherViewController *other = [[Xzb_OtherViewController alloc] init];
//    other.dynamicID = self.frameModel.model.dynamicID;
//    other.userID = self.frameModel.model.createrId;
//    other.view.backgroundColor = AppMainBgColor;
//    UINavigationController *vc = (UINavigationController *)object;
//    [vc.navigationController pushViewController:other animated:YES];
}
- (void)setModel:(StayInFriendsModel *)model
{
    _model = model;
    if (model == nil) {
        return;
    }
    //头像
    CGFloat headW;
    headW = 50;
    self.headView.frame = CGRectMake(8, 8, headW, headW);
    self.headView.layer.cornerRadius = headW * 0.5;
    [self.headView sd_setImageWithURL:[NSURL URLWithString:model.userPhoto] placeholderImage:[UIImage imageNamed:@"头像－默认"]];
    //名称 model.userName
    CGSize nameLabelSize = [model.nickName boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.nameLabel.font} context:nil].size;
    self.nameLabel.frame = CGRectMake(CGRectGetMaxX(self.headView.frame) + 15, 15,nameLabelSize.width, nameLabelSize.height);
    self.nameLabel.text = model.nickName;
    //时间 [NSDateFormatter stringFromDateString:model.createDate]
    CGSize timeLabelSize = [model.checkinDate boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.timeLabel.font} context:nil].size;
    self.timeLabel.frame = CGRectMake(ScreenWidth - timeLabelSize.width - 10, self.nameLabel.y, timeLabelSize.width, timeLabelSize.height);
    self.timeLabel.text = model.checkinDate;
    //晒单内容 model.content
    CGSize contentLabelSize = [model.remark boundingRectWithSize:CGSizeMake(ScreenWidth - CGRectGetMaxX(self.headView.frame) - 25, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.contentLabel.font} context:nil].size;
    self.contentLabel.frame = CGRectMake(self.nameLabel.x, CGRectGetMaxY(self.nameLabel.frame) + 5, contentLabelSize.width, contentLabelSize.height);
    self.contentLabel.text = model.remark;
    
    self.devider.frame = CGRectMake(10, model.cellHeight - 0.5, ScreenWidth, 0.5);
}
@end
