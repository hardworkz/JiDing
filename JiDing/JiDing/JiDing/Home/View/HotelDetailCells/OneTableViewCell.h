//
//  OneTableViewCell.h
//  xzb
//
//  Created by 张荣廷 on 16/7/19.
//  Copyright © 2016年 xuwk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OneTableViewCell : UITableViewCell
@property (nonatomic,strong) Xzb_HotelDetailModel *model;
+(OneTableViewCell *)cellWithTableView:(UITableView *)tableView;
+ (NSString *)ID;
@end
