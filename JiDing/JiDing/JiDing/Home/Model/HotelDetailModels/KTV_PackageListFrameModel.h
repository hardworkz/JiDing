//
//  KTV_PackageListFrameModel.h
//  JiDing
//
//  Created by 泡果 on 2017/6/20.
//  Copyright © 2017年 zhangrongting. All rights reserved.
//

#import <Foundation/Foundation.h>

@class KTV_PackageListModel;
@interface KTV_PackageListFrameModel : NSObject
@property (strong, nonatomic) KTV_PackageListModel *model;

@property (assign, nonatomic) CGRect KTVImageViewF;
@property (assign, nonatomic) CGRect ktvNameLabelF;
@property (assign, nonatomic) CGRect priceLabelF;
@property (assign, nonatomic) CGRect orignPriceAndSellNumLabelF;
@property (assign, nonatomic) CGRect priceLineF;
@property (assign, nonatomic) CGRect rightArrowF;
@property (assign, nonatomic) CGRect deviderF;
@property (assign, nonatomic) CGFloat cellHeight;
@end
