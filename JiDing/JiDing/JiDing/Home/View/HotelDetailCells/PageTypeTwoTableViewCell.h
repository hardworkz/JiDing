//
//  PageTypeTwoTableViewCell.h
//  xzb
//
//  Created by 张荣廷 on 16/7/20.
//  Copyright © 2016年 xuwk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PageTypeTwoTableViewCell : UITableViewCell
@property (nonatomic,strong) NSString *businessFacilities;
@property (nonatomic,assign)  CGFloat cellHeight;

+(PageTypeTwoTableViewCell *)cellWithTableView:(UITableView *)tableView;
+ (NSString *)ID;
@end
