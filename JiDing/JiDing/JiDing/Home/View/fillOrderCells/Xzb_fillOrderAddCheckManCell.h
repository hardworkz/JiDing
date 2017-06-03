//
//  Xzb_fillOrderAddCheckManCell.h
//  xzb
//
//  Created by rainze on 16/7/22.
//  Copyright © 2016年 xuwk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Xzb_fillOrderAddCheckManCell : UITableViewCell

+ (NSString *)ID;
+ (Xzb_fillOrderAddCheckManCell *)cellWithTableView:(UITableView *)tableView;
@property (nonatomic, copy) void(^addGuest)();

@end
