//
//  SettingCell.h
//  xzb
//
//  Created by 张荣廷 on 16/5/26.
//  Copyright © 2016年 xuwk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingCell : UITableViewCell
@property (nonatomic,weak)  UIImageView *iconView;
@property (nonatomic,weak)  UILabel *titleLabel;
@property (nonatomic,weak)  UIView *devider;
+ (NSString *)ID;
+(SettingCell *)cellWithTableView:(UITableView *)tableView;
@end
