//
//  Xzb_HotelNameCell.h
//  xzb
//
//  Created by 张荣廷 on 16/7/28.
//  Copyright © 2016年 xuwk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Xzb_HotelNameCell : UITableViewCell
@property (nonatomic,weak)  UIImageView *iconImageView;
@property (nonatomic,weak)  UILabel *hotelNameLabel;
+ (NSString *)ID;
+ (Xzb_HotelNameCell *)cellWithTableView:(UITableView *)tableView;
@end
