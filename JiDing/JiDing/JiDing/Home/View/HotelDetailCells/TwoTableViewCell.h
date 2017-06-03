//
//  TwoTableViewCell.h
//  xzb
//
//  Created by 张荣廷 on 16/7/19.
//  Copyright © 2016年 xuwk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TwoTableViewCell : UITableViewCell
@property (nonatomic,strong)  UIView *contentsView;
+(TwoTableViewCell *)cellWithTableView:(UITableView *)tableView;
+ (NSString *)ID;
@end
