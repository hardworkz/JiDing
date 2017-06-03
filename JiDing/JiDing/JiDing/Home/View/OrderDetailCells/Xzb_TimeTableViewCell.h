//
//  Xzb_TimeTableViewCell.h
//  xzb
//
//  Created by 张荣廷 on 16/7/26.
//  Copyright © 2016年 xuwk. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Xzb_OrderDetailsModel;
@interface Xzb_TimeTableViewCell : UITableViewCell
@property (nonatomic,strong) Xzb_OrderDetailsModel *model;
+ (NSString *)ID;
+ (Xzb_TimeTableViewCell *)cellWithTableView:(UITableView *)tableView;
@end
