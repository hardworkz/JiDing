//
//  PageTypeThreeTableViewCell.h
//  xzb
//
//  Created by 张荣廷 on 16/7/20.
//  Copyright © 2016年 xuwk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PageTypeThreeTableViewCell : UITableViewCell
@property (nonatomic,strong) Xzb_HotelDetailModel *model;
@property (nonatomic,assign)  CGFloat cellHeight;
@property (nonatomic,weak)  UILabel *rateLabel;

+(PageTypeThreeTableViewCell *)cellWithTableView:(UITableView *)tableView;
+ (NSString *)ID;
@end
