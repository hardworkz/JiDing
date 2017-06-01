//
//  AreaTableViewCell.h
//  xzb
//
//  Created by 张荣廷 on 16/6/1.
//  Copyright © 2016年 xuwk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AreaTableViewCell : UITableViewCell

@property (nonatomic,weak)  UILabel *titleLabel;

+ (NSString *)ID;
+(AreaTableViewCell *)cellWithTableView:(UITableView *)tableView;
@end
