//
//  HotelIntroView.h
//  xzb
//
//  Created by 张荣廷 on 16/7/22.
//  Copyright © 2016年 xuwk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HotelIntroView : UIView
/**
 *  酒店详情数据模型
 */
@property (nonatomic,strong) Xzb_HotelDetailModel *hotelModel;
@property (nonatomic , weak) UIButton *cover;
@property (nonatomic,weak)  UILabel *titleLabel;

- (void)show;
@end
