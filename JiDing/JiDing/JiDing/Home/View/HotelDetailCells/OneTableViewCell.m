//
//  OneTableViewCell.m
//  xzb
//
//  Created by 张荣廷 on 16/7/19.
//  Copyright © 2016年 xuwk. All rights reserved.
//

#import "OneTableViewCell.h"

#define NumDayW 100
@interface OneTableViewCell ()
@property (nonatomic,strong)  UIView *contentsView;
@property (nonatomic,weak)  UILabel *hotelTypeLabel;
//@property (nonatomic,weak)  UILabel *payTypeLabel;
@property (nonatomic,weak)  UILabel *addressLabel;
@property (nonatomic,weak)  UILabel *starTimeLabel;
@property (nonatomic,weak)  UILabel *endTimeLabel;
@property (nonatomic,weak)  UILabel *numOfDayLabel;
@property (nonatomic,weak)  UIButton *hotelPhoneBtn;
@property (nonatomic,strong)  UIView *devider;
@property (nonatomic,weak)  UIImageView *timeIconImageView;
@property (nonatomic,weak)  UIWebView *webView;

@property (nonatomic,strong) NSArray *payTypeArray;
@property (nonatomic,strong) NSArray *payTypeIDArray;
@end
@implementation OneTableViewCell
- (NSArray *)payTypeArray
{
    if (_payTypeArray == nil) {
        _payTypeArray = @[@"预付",@"担保交易",@"到付"];
    }
    return _payTypeArray;
}
- (NSArray *)payTypeIDArray
{
    if (_payTypeIDArray == nil) {
        _payTypeIDArray = @[@"1",@"2",@"3"];
    }
    return _payTypeIDArray;
}

+ (NSString *)ID
{
    return @"OneTableViewCell";
}
+(OneTableViewCell *)cellWithTableView:(UITableView *)tableView
{
    OneTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[OneTableViewCell ID]];
    if (cell == nil) {
        cell = [[OneTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[OneTableViewCell ID]];
    }
    return cell;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = AppMainBgColor;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UIWebView *webView = [[UIWebView alloc] init];
        webView.frame = CGRectZero;
        [self addSubview:webView];
        self.webView = webView;
        
        UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 140 - 9)];
        contentView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:contentView];
        self.contentsView = contentView;
        
        UILabel *hotelTypeLabel = [[UILabel alloc] init];
//        hotelTypeLabel.text = @"经济型";
        hotelTypeLabel.font = [UIFont systemFontOfSize:18.];
        hotelTypeLabel.frame = CGRectMake(10, 10, 100, 20);
        hotelTypeLabel.textColor = AppGreenTextColor;
//        hotelTypeLabel.textAlignment = NSTextAlignmentl;
//        hotelTypeLabel.layer.borderColor = AppMainColor.CGColor;
//        hotelTypeLabel.layer.borderWidth = 1;
//        hotelTypeLabel.layer.cornerRadius = 10;
        [contentView addSubview:hotelTypeLabel];
        self.hotelTypeLabel = hotelTypeLabel;
        
//        UILabel *payTypeLabel = [[UILabel alloc] init];
//        payTypeLabel.text = @"预付";
//        payTypeLabel.font = [UIFont systemFontOfSize:13];
//        payTypeLabel.frame = CGRectMake(CGRectGetMaxX(hotelTypeLabel.frame) + 10, hotelTypeLabel.y, 60, 20);
//        payTypeLabel.textColor = AppGreenBtnColor;
//        payTypeLabel.textAlignment = NSTextAlignmentCenter;
//        payTypeLabel.layer.borderColor = AppGreenBtnColor.CGColor;
//        payTypeLabel.layer.borderWidth = 1;
//        payTypeLabel.layer.cornerRadius = 10;
//        [contentView addSubview:payTypeLabel];
//        self.payTypeLabel = payTypeLabel;
        
        UIButton *hotelPhoneBtn = [[UIButton alloc] init];
        hotelPhoneBtn.frame = CGRectMake(ScreenWidth - 60 , -15, 50, 100);
        [hotelPhoneBtn setImage:[UIImage imageNamed:@"酒店详情-电话"] forState:UIControlStateNormal];
        hotelPhoneBtn.imageView.contentMode = UIViewContentModeCenter;
        [hotelPhoneBtn addTarget:self action:@selector(hotelPhoneBtnClicked) forControlEvents:UIControlEventTouchUpInside];
        [contentView addSubview:hotelPhoneBtn];
        self.hotelPhoneBtn = hotelPhoneBtn;

        UILabel *addressLabel = [[UILabel alloc] init];
        addressLabel.text = @"福建省厦门市思明区软件园二期望海路67号801";
        addressLabel.font = [UIFont systemFontOfSize:14];
        addressLabel.frame = CGRectMake(10, CGRectGetMaxY(hotelTypeLabel.frame) + 10, ScreenWidth - 20 - 50, 20);
        addressLabel.textColor = [UIColor lightGrayColor];
        addressLabel.numberOfLines = 0;
        [contentView addSubview:addressLabel];
        self.addressLabel = addressLabel;
        
        _devider = [[UIView alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(addressLabel.frame) + 10, ScreenWidth, 0.5)];
        _devider.backgroundColor = AppLightLineColor;
        [contentView addSubview:_devider];
        
        //入住日期
        UILabel *starTimeLabel = [[UILabel alloc] init];
        [starTimeLabel setAppFontWithSize:15.0];
        starTimeLabel.frame = CGRectMake(0, CGRectGetMaxY(_devider.frame), (SCREEN_WIDTH - NumDayW - 25)* 0.5, 60);
        starTimeLabel.textColor = AppMainGrayTextColor;
        starTimeLabel.textAlignment = NSTextAlignmentCenter;
        starTimeLabel.numberOfLines = 0;
        [contentView addSubview:starTimeLabel];
        self.starTimeLabel = starTimeLabel;
        //箭头和至
        UIImageView *rightArrow = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(starTimeLabel.frame), starTimeLabel.y + 10, 25, 25)];
        rightArrow.image = [UIImage imageNamed:@"入住箭头"];
        rightArrow.contentMode = UIViewContentModeCenter;
        [contentView addSubview:rightArrow];
        
        UILabel *zhi = [[UILabel alloc] init];
        zhi.font = [UIFont systemFontOfSize:15];
        zhi.frame = CGRectMake(rightArrow.x, CGRectGetMaxY(rightArrow.frame) - 3, 25, 25);
        zhi.text = @"至";
        zhi.textColor = AppMainGrayTextColor;
        zhi.textAlignment = NSTextAlignmentCenter;
        [contentView addSubview:zhi];
        //离店日期
        UILabel *endTimeLabel = [[UILabel alloc] init];
        [endTimeLabel setAppFontWithSize:15.0];
        endTimeLabel.frame = CGRectMake(SCREEN_WIDTH - NumDayW - (SCREEN_WIDTH - NumDayW - 25)* 0.5, CGRectGetMaxY(_devider.frame), (SCREEN_WIDTH - NumDayW - 25)* 0.5, 60);
        endTimeLabel.textColor = AppMainGrayTextColor;
        endTimeLabel.textAlignment = NSTextAlignmentCenter;
        endTimeLabel.numberOfLines = 0;
        [contentView addSubview:endTimeLabel];
        self.endTimeLabel = endTimeLabel;
        //时钟图标
        UIImageView *timeIconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - NumDayW, starTimeLabel.y - 5 -3, NumDayW, 30)];
        timeIconImageView.image = [UIImage imageNamed:@"入住时间"];
        timeIconImageView.contentMode = UIViewContentModeCenter;
        [contentView addSubview:timeIconImageView];
        self.timeIconImageView = timeIconImageView;
        //共几晚label
        UILabel *numOfDayLabel = [[UILabel alloc] init];
        numOfDayLabel.font = [UIFont systemFontOfSize:16];
        numOfDayLabel.frame = CGRectMake(SCREEN_WIDTH - NumDayW, starTimeLabel.y + 30, NumDayW, 20);
        numOfDayLabel.textColor = AppGreenTextColor;
        numOfDayLabel.textAlignment = NSTextAlignmentCenter;
        [contentView addSubview:numOfDayLabel];
        self.numOfDayLabel = numOfDayLabel;
    }
    return self;
}
- (void)setModel:(Xzb_HotelDetailModel *)model
{
    _model = model;
    if (model == nil) {
        return;
    }
    self.hotelTypeLabel.text = [NSString stringWithFormat:@"¥%@/晚",model.price];
    
    //酒店地址
    CGSize addressSize = [model.location boundingRectWithSize:CGSizeMake(ScreenWidth - 20 - 50, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size;
    self.addressLabel.height = addressSize.height;
    self.addressLabel.text = model.location;
    
    _devider.frame = CGRectMake(10, CGRectGetMaxY(_addressLabel.frame) + 10, ScreenWidth, 0.5);
    if ([model.orderType intValue] == 1) {//全日房
        //入住时间 和 离店时间
        if (model.checkinDate.length >= 10) {
            self.starTimeLabel.text = [NSString stringWithFormat:@"入住\n%@",[model.checkinDate substringToIndex:10]];
        }
        if (model.leaveDate.length >= 10) {
            self.endTimeLabel.text = [NSString stringWithFormat:@"离店\n%@",[model.leaveDate substringToIndex:10]];
        }

    }else if ([model.orderType intValue] == 2)
    {
        //预计到店时间
        self.starTimeLabel.text = [NSString stringWithFormat:@"预计到店时间\n%@ %@",[model.checkinDate substringToIndex:10],model.arriveTime];
    }
    
    self.starTimeLabel.y = CGRectGetMaxY(_devider.frame) + addressSize.height - 10;
    self.endTimeLabel.y = _starTimeLabel.y;
    
    self.timeIconImageView.y = self.starTimeLabel.y;
    self.numOfDayLabel.y = CGRectGetMaxY(self.timeIconImageView.frame) + 3;
    self.contentsView.height = 140 - 9 + addressSize.height * 0.5;
    //支付类型（预付）
    NSArray *payTypeArray = [model.payType componentsSeparatedByString:@","];
    NSString *payTypeString;
    for (int i = 0; i<self.payTypeIDArray.count; i++) {
        for (int j = 0; j<payTypeArray.count; j++) {
            if ([self.payTypeIDArray[i] intValue] == [payTypeArray[j] intValue]) {
                if (payTypeString) {
                    payTypeString = [payTypeString stringByAppendingString:[NSString stringWithFormat:@"/%@",self.payTypeArray[i]]];
                }else
                {
                    payTypeString = self.payTypeArray[i];
                }
            }
        }
    }
    
//    self.payTypeLabel.text = payTypeString;
    
//    CGSize payTypeLabelSize = [payTypeString boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.payTypeLabel.font} context:nil].size;
//    self.payTypeLabel.width = payTypeLabelSize.width + 20;
    
    //区别全日房和钟点房
    NSString *hourTime = @"";
    if ([model.orderType intValue] == 1) {
        //格式化两个日期，并拼接字符串，计算相隔天数
        NSCalendar *gregorian = [NSCalendar currentCalendar];
        [gregorian setFirstWeekday:2];
        NSDateFormatter *dateFormatter2 = [[NSDateFormatter alloc] init];
        [dateFormatter2 setDateFormat:@"yyyy-MM-dd HH:mm:ss"];

        NSDate *fromDate;
        NSDate *toDate;
        [gregorian rangeOfUnit:NSCalendarUnitDay startDate:&fromDate interval:NULL forDate:[dateFormatter2 dateFromString:model.checkinDate]];
        [gregorian rangeOfUnit:NSCalendarUnitDay startDate:&toDate interval:NULL forDate:[dateFormatter2 dateFromString:model.leaveDate]];
        NSDateComponents *dayComponents = [gregorian components:NSCalendarUnitDay fromDate:fromDate toDate:toDate options:0];
        _numOfDayLabel.text = [NSString stringWithFormat:@"共%ld晚",(long)dayComponents.day];
        self.endTimeLabel.hidden = NO;
    }else if ([model.orderType intValue] == 2)
    {
        //钟点房显示时间
        if ([model.timePeriod intValue] == 1) {
            hourTime = @"3小时";
        }else if ([model.timePeriod intValue] == 2){
            hourTime = @"4小时";
        }else if ([model.timePeriod intValue] == 3){
            hourTime = @"5小时";
        }
        _numOfDayLabel.text = [NSString stringWithFormat:@"共%@",hourTime];
        _timeIconImageView.centerX = (ScreenWidth*3)/4;
        _numOfDayLabel.centerX = _timeIconImageView.centerX;
        
        self.endTimeLabel.hidden = YES;
        self.starTimeLabel.width = ScreenWidth * 3/4;
    }
}
/**
 *  拨打酒店客服电话
 */
- (void)hotelPhoneBtnClicked
{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",self.model.mainTel]];
    [self.webView loadRequest:[NSURLRequest requestWithURL:url]];
}
@end
