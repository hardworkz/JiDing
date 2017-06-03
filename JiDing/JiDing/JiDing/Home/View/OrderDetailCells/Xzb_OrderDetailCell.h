//
//  Xzb_OrderDetailCell.h
//  xzb
//
//  Created by 张荣廷 on 16/7/28.
//  Copyright © 2016年 xuwk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Xzb_OrderDetailCell : UITableViewCell
@property (nonatomic,weak)  UILabel *accessoryLabel;
@property (nonatomic,weak)  UIImageView *iconImageView;
@property (nonatomic,weak)  UILabel *contentLabel;
+ (Xzb_OrderDetailCell *)cellWithTableView:(UITableView *)tableView;
+ (NSString *)ID;
@end
