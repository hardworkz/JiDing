//
//  Xzb_fillOrderTicketCell.m
//  xzb
//
//  Created by rainze on 16/7/22.
//  Copyright © 2016年 xuwk. All rights reserved.
//

#import "Xzb_fillOrderTicketCell.h"

@interface Xzb_fillOrderTicketCell ()

@property (nonatomic, strong) UIView *customView;
@property (nonatomic, strong) UIButton *ticketButton;
@property (nonatomic, strong) UIImageView *plusImg;
@property (nonatomic, strong) UILabel *monyLabel; // 返现金额

@end

@implementation Xzb_fillOrderTicketCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (NSString *)ID
{
    return @"Xzb_fillOrderTicketCell";
}

+ (Xzb_fillOrderTicketCell *)cellWithTableView:(UITableView *)tableView
{
    Xzb_fillOrderTicketCell *cell = [tableView dequeueReusableCellWithIdentifier:[Xzb_fillOrderTicketCell ID]];
    if (cell == nil) {
        cell = [[Xzb_fillOrderTicketCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[Xzb_fillOrderTicketCell ID]];
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

- (void)setupView {
    
    _customView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, 45)];
    _customView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:_customView];
    
    _ticketButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 0, (SCREEN_Width - 20)/ 2, 45)];
    [_ticketButton setTitleColor:AppMainGrayTextColor forState:UIControlStateNormal];
    [_ticketButton setTitle:@" 返现券" forState:UIControlStateNormal];
    [_ticketButton setImage:[UIImage imageNamed:@"返现券1"] forState:UIControlStateNormal];
    _ticketButton.titleLabel.font = [UIFont systemFontOfSize:14];
    _ticketButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [_customView addSubview:_ticketButton];
    
    _plusImg = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_Width - 25, 15, 15, 15)];
    _plusImg.image = [UIImage imageNamed:@"+号"];
    _plusImg.contentMode = UIViewContentModeRight;
    _plusImg.contentMode = UIViewContentModeScaleAspectFit;
    _plusImg.hidden = NO;
    [_customView addSubview:_plusImg];
    
    _monyLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_ticketButton.frame), 0, _ticketButton.frame.size.width, 45)];
    _monyLabel.textColor = AppMainColor;
    _monyLabel.textAlignment = NSTextAlignmentRight;
    _monyLabel.font = [UIFont systemFontOfSize:14];
    _monyLabel.hidden = YES;
    [_customView addSubview:_monyLabel];

}

- (void)setCouponMony:(NSString *)couponMony
{
    _couponMony = couponMony;
    if (couponMony.length) {
        _plusImg.hidden = YES;
        _monyLabel.hidden = NO;
        _monyLabel.text = [NSString stringWithFormat:@"¥%@",couponMony];
    }else {
        
        _plusImg.hidden = NO;
        _monyLabel.hidden = YES;
        _monyLabel.text = @"";
    }
}

@end
