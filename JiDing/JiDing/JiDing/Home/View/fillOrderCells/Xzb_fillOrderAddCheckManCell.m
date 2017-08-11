//
//  Xzb_fillOrderAddCheckManCell.m
//  xzb
//
//  Created by rainze on 16/7/22.
//  Copyright © 2016年 xuwk. All rights reserved.
//

#import "Xzb_fillOrderAddCheckManCell.h"

@interface Xzb_fillOrderAddCheckManCell ()

@property (nonatomic, strong) UIButton *addButton;

@end

@implementation Xzb_fillOrderAddCheckManCell

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
    return @"Xzb_fillOrderAddCheckManCell";
}

+ (Xzb_fillOrderAddCheckManCell *)cellWithTableView:(UITableView *)tableView
{
    Xzb_fillOrderAddCheckManCell *cell = [tableView dequeueReusableCellWithIdentifier:[Xzb_fillOrderAddCheckManCell ID]];
    if (cell == nil) {
        cell = [[Xzb_fillOrderAddCheckManCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[Xzb_fillOrderAddCheckManCell ID]];
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
    _addButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, 45)];
    [_addButton setTitle:@"添加入住人" forState:UIControlStateNormal];
    [_addButton setImage:[UIImage imageNamed:@"order_plus_man"] forState:UIControlStateNormal];
    [_addButton setTitleColor:AppMainGrayTextColor forState:UIControlStateNormal];
    _addButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [_addButton addTarget:self action:@selector(addClick) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_addButton];
    
    UIView *bottomline = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_addButton.frame) - 0.5, SCREEN_Width, 0.5)];
    bottomline.backgroundColor = AppLightLineColor;
    [self.contentView addSubview:bottomline];
}

- (void)addClick {
    if (self.addGuest) {
        self.addGuest();
    }
}

@end
