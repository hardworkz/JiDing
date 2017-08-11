//
//  UserDataTableViewCell.h
//  JiDing
//
//  Created by zhangrongting on 2017/5/28.
//  Copyright © 2017年 zhangrongting. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserDataTableViewCell : UITableViewCell

@property (strong, nonatomic) void (^changeHeader)(UIImageView *imageView);

+(UserDataTableViewCell *)cellWithTableView:(UITableView *)tableView;
@end
