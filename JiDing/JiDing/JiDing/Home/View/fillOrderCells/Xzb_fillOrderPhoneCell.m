//
//  Xzb_fillOrderPhoneCell.m
//  xzb
//
//  Created by rainze on 16/7/22.
//  Copyright © 2016年 xuwk. All rights reserved.
//

#import "Xzb_fillOrderPhoneCell.h"

@interface Xzb_fillOrderPhoneCell ()

@property (nonatomic, strong) UIButton *phoneButton;
@property (nonatomic, strong) UIButton *arriveButton;
@property (nonatomic, strong) UILabel *arriveLabel;


@end

@implementation Xzb_fillOrderPhoneCell

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
    return @"Xzb_fillOrderPhoneCell";
}

+ (Xzb_fillOrderPhoneCell *)cellWithTableView:(UITableView *)tableView
{
    Xzb_fillOrderPhoneCell *cell = [tableView dequeueReusableCellWithIdentifier:[Xzb_fillOrderPhoneCell ID]];
    if (cell == nil) {
        cell = [[Xzb_fillOrderPhoneCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[Xzb_fillOrderPhoneCell ID]];
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
    
    _phoneButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 0, (SCREEN_Width - 20)/ 2, 45)];
    [_phoneButton setTitleColor:AppMainGrayTextColor forState:UIControlStateNormal];
    [_phoneButton setTitle:@" 联系电话" forState:UIControlStateNormal];
    [_phoneButton setImage:[UIImage imageNamed:@"联系电话"] forState:UIControlStateNormal];
    _phoneButton.titleLabel.font = [UIFont systemFontOfSize:14];
    _phoneButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [self.contentView addSubview:_phoneButton];
    
    _phoneLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_phoneButton.frame), 0, _phoneButton.frame.size.width, 45)];
    _phoneLabel.textColor = AppMainGrayTextColor;
    _phoneLabel.textAlignment = NSTextAlignmentRight;
    _phoneLabel.font = [UIFont systemFontOfSize:14];
//    _phoneLabel.text = account.mobile;
    [self.contentView addSubview:_phoneLabel];
    
    UIView *midLine = [[UIView alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(_phoneLabel.frame) - 0.5, SCREEN_Width - 10, 0.5)];
    midLine.backgroundColor = AppLineColor;
    [self.contentView addSubview:midLine];
    
    _arriveButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 45, (SCREEN_Width - 20)/ 2, 45)];
    [_arriveButton setTitleColor:AppMainGrayTextColor forState:UIControlStateNormal];
    [_arriveButton setTitle:@" 到店时间" forState:UIControlStateNormal];
    [_arriveButton setImage:[UIImage imageNamed:@"到店时间"] forState:UIControlStateNormal];
    _arriveButton.titleLabel.font = [UIFont systemFontOfSize:14];
    _arriveButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [self.contentView addSubview:_arriveButton];
    
    _arriveLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_arriveButton.frame), 45, _arriveButton.frame.size.width, 45)];
    _arriveLabel.textColor = AppMainGrayTextColor;
    _arriveLabel.textAlignment = NSTextAlignmentRight;
    _arriveLabel.font = [UIFont systemFontOfSize:14];
    _arriveLabel.text = @"整晚保留";
    [self.contentView addSubview:_arriveLabel];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(_arriveButton.frame) - 0.5, SCREEN_Width - 10, 0.5)];
    line.backgroundColor = AppLineColor;
    [self.contentView addSubview:line];
    
}

- (void)setModel:(Xzb_HotelDetailModel *)model
{
    _model = model;
    UserAccount *account = [UserAccountTool account];
    _phoneLabel.text = account.mobile;
    if ([model.orderType integerValue] == 2) {
        _arriveLabel.text = model.arriveTime;
    }
    
}

@end
