//
//  Xzb_fillOrderPayTypeCell.h
//  xzb
//
//  Created by rainze on 16/7/21.
//  Copyright © 2016年 xuwk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Xzb_HotelDetailModel.h"

@interface Xzb_fillOrderPayTypeCell : UITableViewCell

+ (NSString *)ID;
+(Xzb_fillOrderPayTypeCell *)cellWithTableView:(UITableView *)tableView;
@property (nonatomic, strong) Xzb_HotelDetailModel *hotelModel;
@property (nonatomic, copy) void (^payTypeClick)(NSString *type);
@end
