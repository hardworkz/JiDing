//
//  Xzb_fillOrderTicketCell.h
//  xzb
//
//  Created by rainze on 16/7/22.
//  Copyright © 2016年 xuwk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Xzb_fillOrderTicketCell : UITableViewCell

+ (NSString *)ID;
+(Xzb_fillOrderTicketCell *)cellWithTableView:(UITableView *)tableView;
@property (nonatomic, strong) NSString *couponMony;

@end
