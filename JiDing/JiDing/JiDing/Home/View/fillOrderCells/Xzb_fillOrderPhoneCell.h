//
//  Xzb_fillOrderPhoneCell.h
//  xzb
//
//  Created by rainze on 16/7/22.
//  Copyright © 2016年 xuwk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Xzb_HotelDetailModel.h"

@interface Xzb_fillOrderPhoneCell : UITableViewCell

+ (NSString *)ID;
+(Xzb_fillOrderPhoneCell *)cellWithTableView:(UITableView *)tableView;
@property (nonatomic, strong) UILabel *phoneLabel;

@property (nonatomic, strong) Xzb_HotelDetailModel *model;

@end
