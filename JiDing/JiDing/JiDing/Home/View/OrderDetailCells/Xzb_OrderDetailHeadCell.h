//
//  Xzb_OrderDetailHeadCell.h
//  xzb
//
//  Created by rainze on 16/7/25.
//  Copyright © 2016年 xuwk. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Xzb_OrderDetailsModel;
@interface Xzb_OrderDetailHeadCell : UITableViewCell
@property (nonatomic,strong) Xzb_OrderDetailsModel *model;
@property (nonatomic,assign)  CGFloat cellHeight;
+ (NSString *)ID;
+(Xzb_OrderDetailHeadCell *)cellWithTableView:(UITableView *)tableView;
@end
