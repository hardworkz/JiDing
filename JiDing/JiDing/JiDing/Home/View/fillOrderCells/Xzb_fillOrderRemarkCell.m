//
//  Xzb_fillOrderRemarkCell.m
//  xzb
//
//  Created by rainze on 16/7/22.
//  Copyright © 2016年 xuwk. All rights reserved.
//

#import "Xzb_fillOrderRemarkCell.h"

@interface Xzb_fillOrderRemarkCell ()<UITextFieldDelegate>

@property (nonatomic, strong) UILabel *remarkLabel;
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
    
    _remarkLabel = [[UILabel alloc] init];
    _remarkLabel.text = @"备注";
    _remarkLabel.textColor = AppMainGrayTextColor;
    _remarkLabel.font = [UIFont systemFontOfSize:14];
    [_remarkLabel sizeToFit];
    _remarkLabel.frame = CGRectMake(10, (self.contentView.frame.size.height - _remarkLabel.frame.size.height) / 2, _remarkLabel.frame.size.width, _remarkLabel.frame.size.height);
    [_customView addSubview:_remarkLabel];
    
    _remarkField = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_remarkLabel.frame) + 10, 0, SCREEN_Width - CGRectGetWidth(_remarkLabel.frame) - 30, 45)];
    _remarkField.font = [UIFont systemFontOfSize:14];
    _remarkField.textAlignment = NSTextAlignmentRight;
    _remarkField.placeholder = @"选填";
    _remarkField.returnKeyType = UIReturnKeyDone;
    _remarkField.delegate  = self;
    [_customView addSubview:_remarkField];
    
//    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_remarkField.frame) - 0.5, SCREEN_Width, 0.5)];
//    line.backgroundColor = AppLineColor;
//    [self.contentView addSubview:line];
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
