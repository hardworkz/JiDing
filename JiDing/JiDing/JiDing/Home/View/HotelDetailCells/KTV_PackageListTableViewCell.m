//
//  KTV_PackageListTableViewCell.m
//  JiDing
//
//  Created by 泡果 on 2017/6/20.
//  Copyright © 2017年 zhangrongting. All rights reserved.
//

#import "KTV_PackageListTableViewCell.h"

@interface KTV_PackageListTableViewCell ()
{
    UIImageView *KTVImageView;
    UILabel *ktvNameLabel;
    UILabel *priceLabel;
    UILabel *orignPriceAndSellNumLabel;
    UIView *priceLine;
    UIImageView *rightArrow;
    UIView *devider;
}
@end
@implementation KTV_PackageListTableViewCell
+ (NSString *)ID
{
    return @"KTV_PackageListTableViewCell";
}
+(KTV_PackageListTableViewCell *)cellWithTableView:(UITableView *)tableView
{
    KTV_PackageListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[KTV_PackageListTableViewCell ID]];
    if (cell == nil) {
        cell = [[KTV_PackageListTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[KTV_PackageListTableViewCell ID]];
    }
    return cell;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        KTVImageView = [[UIImageView alloc] init];
        KTVImageView.contentMode = UIViewContentModeScaleAspectFill;
        [self.contentView addSubview:KTVImageView];
        
        ktvNameLabel = [[UILabel alloc] init];
        ktvNameLabel.text = @"自选套餐";
        [ktvNameLabel setAppFontWithSize:16.0];
        ktvNameLabel.textColor = AppMainGrayTextColor;
        [self.contentView addSubview:ktvNameLabel];
        
        priceLabel = [[UILabel alloc] init];
        priceLabel.text = @"¥200";
        [priceLabel setAppFontWithSize:18.0];
        [self.contentView addSubview:priceLabel];
        
        orignPriceAndSellNumLabel = [[UILabel alloc] init];
        orignPriceAndSellNumLabel.text = @"¥600   已售出：10000";
        orignPriceAndSellNumLabel.textColor = AppLightGrayTextColor;
        [orignPriceAndSellNumLabel setAppFontWithSize:15.0];
        [self.contentView addSubview:orignPriceAndSellNumLabel];
        
        priceLine = [[UIView alloc] init];
        priceLine.backgroundColor = AppLineColor;
        [self.contentView addSubview:priceLine];
        
        rightArrow = [[UIImageView alloc] init];
        rightArrow.image = [UIImage imageNamed:@"入住箭头"];
        rightArrow.contentMode = UIViewContentModeCenter;
        [self.contentView addSubview:rightArrow];
        
        devider = [[UIView alloc] init];
        devider.backgroundColor = AppLineColor;
        [self.contentView addSubview:devider];
    }
    return self;
}
- (void)setFrameModel:(KTV_PackageListFrameModel *)frameModel
{
    _frameModel = frameModel;
    
    KTVImageView.frame = frameModel.KTVImageViewF;
    ktvNameLabel.frame = frameModel.ktvNameLabelF;
    priceLabel.frame = frameModel.priceLabelF;
    orignPriceAndSellNumLabel.frame = frameModel.orignPriceAndSellNumLabelF;
    priceLine.frame = frameModel.priceLineF;
    rightArrow.frame = frameModel.rightArrowF;
    devider.frame = frameModel.deviderF;
}
@end
