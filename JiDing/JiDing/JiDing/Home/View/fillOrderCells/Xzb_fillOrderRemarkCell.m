//
//  Xzb_fillOrderRemarkCell.m
//  xzb
//
//  Created by rainze on 16/7/22.
//  Copyright © 2016年 xuwk. All rights reserved.
//

#import "Xzb_fillOrderRemarkCell.h"

@interface Xzb_fillOrderRemarkCell ()<UITextFieldDelegate>

@property (nonatomic, strong) UIButton *remarkBtn;
@property (nonatomic, strong) UIView *customView;

@end

@implementation Xzb_fillOrderRemarkCell

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
    return @"Xzb_fillOrderRemarkCell";
}

+ (Xzb_fillOrderRemarkCell *)cellWithTableView:(UITableView *)tableView
{
    Xzb_fillOrderRemarkCell *cell = [tableView dequeueReusableCellWithIdentifier:[Xzb_fillOrderRemarkCell ID]];
    if (cell == nil) {
        cell = [[Xzb_fillOrderRemarkCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[Xzb_fillOrderRemarkCell ID]];
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
    
    _remarkBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 0, (SCREEN_Width - 20)/ 2, 45)];
    [_remarkBtn setTitleColor:AppMainGrayTextColor forState:UIControlStateNormal];
    [_remarkBtn setTitle:@" 备注" forState:UIControlStateNormal];
    [_remarkBtn setImage:[UIImage imageNamed:@"其他要求"] forState:UIControlStateNormal];
    _remarkBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    _remarkBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [_customView addSubview:_remarkBtn];
    
    _remarkField = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_remarkBtn.frame) + 10, 0, SCREEN_Width - CGRectGetWidth(_remarkBtn.frame) - 30, 45)];
    _remarkField.font = [UIFont systemFontOfSize:14];
    _remarkField.textAlignment = NSTextAlignmentRight;
    _remarkField.placeholder = @"选填";
    _remarkField.returnKeyType = UIReturnKeyDone;
    _remarkField.delegate  = self;
    [_customView addSubview:_remarkField];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [_remarkField resignFirstResponder];
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField.text.length > 18) return NO;
    
    return YES;
}

@end
