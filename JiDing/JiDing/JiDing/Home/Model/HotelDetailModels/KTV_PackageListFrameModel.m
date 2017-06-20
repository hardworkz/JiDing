//
//  KTV_PackageListFrameModel.m
//  JiDing
//
//  Created by 泡果 on 2017/6/20.
//  Copyright © 2017年 zhangrongting. All rights reserved.
//

#import "KTV_PackageListFrameModel.h"

#define margin 10

@implementation KTV_PackageListFrameModel
- (void)setModel:(KTV_PackageListModel *)model
{
    _model = model;
    
    _KTVImageViewF = CGRectMake(margin, margin, 80, 60);
    _ktvNameLabelF = CGRectMake(CGRectGetMaxX(_KTVImageViewF) + margin, margin, SCREEN_WIDTH, 30);
    
    CGSize priceSize = [@"200" boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18.0]} context:nil].size;
    _priceLabelF = CGRectMake(CGRectGetMaxX(_KTVImageViewF) + margin, CGRectGetMaxY(_ktvNameLabelF), priceSize.width, 30);
    
    CGSize orignPriceLineW = [@"¥600" boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15.0]} context:nil].size;
    _orignPriceAndSellNumLabelF = CGRectMake(CGRectGetMaxX(_priceLabelF), CGRectGetMaxY(_ktvNameLabelF), SCREEN_WIDTH, 30);
    _priceLineF = CGRectMake(_orignPriceAndSellNumLabelF.origin.x, _orignPriceAndSellNumLabelF.origin.y + 14.5, orignPriceLineW.width, 1);
    
    _deviderF = CGRectMake(margin, CGRectGetMaxY(_KTVImageViewF) + margin, SCREEN_WIDTH, 0.5);
    _cellHeight = CGRectGetMaxY(_deviderF);
}
@end
