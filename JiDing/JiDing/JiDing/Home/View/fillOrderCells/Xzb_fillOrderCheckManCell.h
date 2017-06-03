//
//  Xzb_fillOrderCheckManCell.h
//  xzb
//
//  Created by rainze on 16/7/22.
//  Copyright © 2016年 xuwk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Xzb_fillOrderCheckManCell : UITableViewCell

+ (NSString *)ID;
+ (Xzb_fillOrderCheckManCell *)cellWithTableView:(UITableView *)tableView;
@property (nonatomic, strong) UITextField *name;
@property (nonatomic, strong) UITextField *phone;

@end
