//
//  PageTypeTableViewCell.h
//  xzb
//
//  Created by 张荣廷 on 16/7/20.
//  Copyright © 2016年 xuwk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PageTypeTableViewCell : UITableViewCell
@property (nonatomic,strong) Xzb_HotelDetailModel *model;
@property (nonatomic,assign)  CGFloat cellHeight;
@property (nonatomic,strong) NSMutableArray *dataArray;

+(PageTypeTableViewCell *)cellWithTableView:(UITableView *)tableView;
+ (NSString *)ID;
@end
