//
//  Xzb_fillOrderCheckManCell.m
//  xzb
//
//  Created by rainze on 16/7/22.
//  Copyright © 2016年 xuwk. All rights reserved.
//

#import "Xzb_fillOrderCheckManCell.h"

@interface Xzb_fillOrderCheckManCell ()<UITextFieldDelegate>

@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *phoneLabel;
@property (nonatomic, strong) UIView *line;

@end

@implementation Xzb_fillOrderCheckManCell

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
    return @"Xzb_fillOrderCheckManCell";
}

+ (Xzb_fillOrderCheckManCell *)cellWithTableView:(UITableView *)tableView
{
    Xzb_fillOrderCheckManCell *cell = [tableView dequeueReusableCellWithIdentifier:[Xzb_fillOrderCheckManCell ID]];
    if (cell == nil) {
        cell = [[Xzb_fillOrderCheckManCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[Xzb_fillOrderCheckManCell ID]];
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
    _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, (SCREEN_Width - 20) / 2, 45)];
    _nameLabel.textColor = AppMainGrayTextColor;
    _nameLabel.text = @"入住人";
    _nameLabel.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:_nameLabel];
    
    _name = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_nameLabel.frame), 0, CGRectGetWidth(_nameLabel.frame), 45)];
    _name.textAlignment = NSTextAlignmentRight;
    _name.textColor = [UIColor lightGrayColor];
    _name.font = [UIFont systemFontOfSize:14];
    _name.returnKeyType = UIReturnKeyDone;
    _name.placeholder = @"输入姓名";
    _name.delegate = self;
    [self.contentView addSubview:_name];
    
    _line = [[UIView alloc] initWithFrame:CGRectMake(10, 45, SCREEN_Width - 10, 0.5)];
    _line.backgroundColor = AppLightLineColor;
    [self.contentView addSubview:_line];
    
    _phoneLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 45, (SCREEN_Width - 20) / 2, 45)];
    _phoneLabel.textColor = AppMainGrayTextColor;
    _phoneLabel.text = @"手机号码";
    _phoneLabel.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:_phoneLabel];
    
    _phone = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_phoneLabel.frame), 45, CGRectGetWidth(_phoneLabel.frame), 45)];
    _phone.textAlignment = NSTextAlignmentRight;
    _phone.textColor = [UIColor lightGrayColor];
    _phone.font = [UIFont systemFontOfSize:14];
    _phone.returnKeyType = UIReturnKeyDone;
    _phone.keyboardType = UIKeyboardTypeDecimalPad;
    _phone.delegate = self;
    [self.contentView addSubview:_phone];
    
    UIView *bottomline = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_phoneLabel.frame) - 0.5, SCREEN_Width, 0.5)];
    bottomline.backgroundColor = AppLightLineColor;
    [self.contentView addSubview:bottomline];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.phone resignFirstResponder];
    [self.name resignFirstResponder];
    return YES;
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if ([textField isEqual:_name]) {
        BOOL isString = ![RTHttpTool validateNumber:string textField:textField];
        if ([string isEqualToString:@""]) {
            isString = YES;
        }
        return isString;
    }
    return YES;
}
@end
