//
//  StayInFriendsTableViewCell.h
//  xzb
//
//  Created by 张荣廷 on 16/7/22.
//  Copyright © 2016年 xuwk. All rights reserved.
//

#import <UIKit/UIKit.h>

@class StayInFriendsModel;
@interface StayInFriendsTableViewCell : UITableViewCell
@property (nonatomic,strong) StayInFriendsModel *model;
//@property (nonatomic , assign) CGFloat cellHeight;

+ (NSString *)ID;
+ (StayInFriendsTableViewCell *)cellWithTableView:(UITableView *)tableView;
@end
