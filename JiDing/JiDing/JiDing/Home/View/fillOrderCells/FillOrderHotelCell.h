//
//  FillOrderHotelCell.h
//  xzb
//
//  Created by rainze on 16/7/21.
//  Copyright © 2016年 xuwk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Xzb_HotelDetailModel.h"

@interface FillOrderHotelCell : UITableViewCell
+ (NSString *)ID;
+(FillOrderHotelCell *)cellWithTableView:(UITableView *)tableView;
@property (nonatomic, strong) Xzb_HotelDetailModel *hotelModel;
@end
