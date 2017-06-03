//
//  SearchResultNewTableViewCell.h
//  xzb
//
//  Created by 张荣廷 on 16/6/13.
//  Copyright © 2016年 xuwk. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HotelOfferModel;
@interface SearchResultNewTableViewCell : UITableViewCell
@property (nonatomic,assign)  BOOL isAddTableView;
@property (nonatomic,strong) NSTimer *timer;
@property (nonatomic,strong) HotelOfferModel *model;
+ (NSString *)ID;
+(SearchResultNewTableViewCell *)cellWithTableView:(UITableView *)tableView;
@end
