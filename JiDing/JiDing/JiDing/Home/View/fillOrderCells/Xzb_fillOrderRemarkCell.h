//
//  Xzb_fillOrderRemarkCell.h
//  xzb
//
//  Created by rainze on 16/7/22.
//  Copyright © 2016年 xuwk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Xzb_fillOrderRemarkCell : UITableViewCell

+ (NSString *)ID;
+ (Xzb_fillOrderRemarkCell *)cellWithTableView:(UITableView *)tableView;
@property (nonatomic, strong) UITextField *remarkField;
@end
