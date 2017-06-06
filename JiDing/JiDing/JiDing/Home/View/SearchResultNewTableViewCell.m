//
//  SearchResultNewTableViewCell.m
//  xzb
//
//  Created by 张荣廷 on 16/6/13.
//  Copyright © 2016年 xuwk. All rights reserved.
//

#import "SearchResultNewTableViewCell.h"

@interface SearchResultNewTableViewCell ()
{
    NSInteger _index;
}
@property (nonatomic,weak)  UILabel *priceLabel;
@property (nonatomic,weak)  UIImageView *hotelImageView;
@property (nonatomic,weak)  UILabel *hotelNameLabel;
@property (nonatomic,weak)  UIButton *payCountDownBtn;
@end
@implementation SearchResultNewTableViewCell
- (void)setIsAddTableView:(BOOL)isAddTableView
{
    _isAddTableView = isAddTableView;
    if (isAddTableView) {
        
    }
}
+ (NSString *)ID
{
    return @"SearchResultTableViewCell";
}
+(SearchResultNewTableViewCell *)cellWithTableView:(UITableView *)tableView
{
    SearchResultNewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[SearchResultNewTableViewCell ID]];
    if (cell == nil) {
        cell = [[SearchResultNewTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[SearchResultNewTableViewCell ID]];
    }
    return cell;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        //酒店图片
        UIImageView *hotelImageView = [[UIImageView alloc] init];
        hotelImageView.frame = CGRectMake(0, 0, SCREEN_Width,SCREEN_WIDTH * 3/5);
        hotelImageView.contentMode = UIViewContentModeScaleAspectFill;
        hotelImageView.clipsToBounds = YES;
        [self.contentView addSubview:hotelImageView];
        self.hotelImageView = hotelImageView;
        //透明遮盖
        UIView *imageCover = [[UIView alloc] init];
        imageCover.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
        imageCover.frame = CGRectMake(0, hotelImageView.height - 80, SCREEN_Width, 80);
        [hotelImageView addSubview:imageCover];
        //付款倒计时
        UIButton *payCountDownBtn = [[UIButton alloc] init];
        [payCountDownBtn setImage:[UIImage imageNamed:@"酒店列表时间图标"] forState:UIControlStateNormal];
        payCountDownBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        [payCountDownBtn setTitle:@"00:00" forState:UIControlStateNormal];
        payCountDownBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [payCountDownBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        payCountDownBtn.frame = CGRectMake(SCREEN_WIDTH - 80 - 5, 40, 80, 40);
        [imageCover addSubview:payCountDownBtn];
        self.payCountDownBtn = payCountDownBtn;
        //价格
        UILabel *priceLabel = [[UILabel alloc] init];
        priceLabel.textColor = [UIColor whiteColor];
        priceLabel.font = [UIFont systemFontOfSize:25];
        priceLabel.textAlignment = NSTextAlignmentRight;
        priceLabel.frame = CGRectMake(SCREEN_Width - (SCREEN_Width * 0.5) - 10, 5, SCREEN_Width * 0.5, 40);
        priceLabel.textAlignment = NSTextAlignmentRight;
        [imageCover addSubview:priceLabel];
        self.priceLabel = priceLabel;
        //酒店名称
        UILabel *hotelNameLabel = [[UILabel alloc] init];
        hotelNameLabel.frame = CGRectMake(10, 40, SCREEN_Width * 0.5, 40);
        hotelNameLabel.textColor = [UIColor whiteColor];
        hotelNameLabel.textAlignment = NSTextAlignmentLeft;
        hotelNameLabel.font = [UIFont systemFontOfSize:20];
        [imageCover addSubview:hotelNameLabel];
        self.hotelNameLabel = hotelNameLabel;
        
    }
    return self;
}
- (void)setModel:(HotelOfferModel *)model
{
    _model = model;
    //酒店报价
    NSString *text = [NSString stringWithFormat:@"¥%@",model.price];
    self.priceLabel.text = text;
    //酒店名称
    CGSize hotelNameLabelSize = [model.name boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.hotelNameLabel.font} context:nil].size;
    
    self.hotelNameLabel.width = hotelNameLabelSize.width;
    self.hotelNameLabel.text = model.name;
    
    //酒店图片
    [self.hotelImageView sd_setImageWithURL:[NSURL URLWithString:model.image] placeholderImage:[UIImage imageNamed:@"1"]];
    

    //付款倒计时
    [self.payCountDownBtn setTitle:[self timeFormatted:[model.seconds intValue]] forState:UIControlStateNormal];
    [self attAction:[model.seconds intValue]];
}
//将秒数转成时间格式
- (NSString *)timeFormatted:(NSInteger)totalSeconds
{
    int seconds = totalSeconds % 60;
    int minutes = (totalSeconds / 60) % 60;
    
    return [NSString stringWithFormat:@"%02d:%02d",minutes, seconds];
}
- (void)attAction:(NSInteger)totalSeconds
{
    //先停止定时器，防止cell重用问题
    [self.timer invalidate];
    self.timer = nil;
    
    _index = totalSeconds;
    //启动定时器
    NSTimer *testTimer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                                          target:self
                                                        selector:@selector(timeAction:)
                                                        userInfo:nil
                                                         repeats:YES];
    [testTimer fire];//
    [[NSRunLoop currentRunLoop] addTimer:testTimer forMode:NSRunLoopCommonModes];
    self.timer = testTimer;
}
//每隔1秒 调用一次
- (void)timeAction:(NSTimer *)timer
{
    _index--;
    RTLog(@"_index = %ld",(long)_index);
    NSString *again_str = [self timeFormatted:_index];
    self.payCountDownBtn.titleLabel.text = again_str;
    if (_index <= 0) {
        //invalidate  终止定时器
        self.payCountDownBtn.titleLabel.text = @"00:00";
        [self.payCountDownBtn setTitle:@"00:00" forState:UIControlStateNormal];
        [timer invalidate];
        timer = nil;
    }else{
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.payCountDownBtn setTitle:[self timeFormatted:_index] forState:UIControlStateNormal];
        });
    }
}
@end
