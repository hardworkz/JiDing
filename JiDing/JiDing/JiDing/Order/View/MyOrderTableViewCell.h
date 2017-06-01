//
//  MyOrderTableViewCell.h
//  xzb
//
//  Created by 张荣廷 on 16/5/30.
//  Copyright © 2016年 xuwk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Xzb_MyOrderInfosModel.h"

@interface MyOrderTableViewCell : UITableViewCell
//@property (nonatomic,weak)  UIButton *timeBtn;
//@property (nonatomic,weak)  UILabel *typeLabel;
//@property (nonatomic,weak)  UIButton *rightBtn;
//@property (nonatomic,weak)  UIButton *leftBtn;
@property (nonatomic, strong) Xzb_MyOrderInfosModel *model;
+ (NSString *)ID;
+(MyOrderTableViewCell *)cellWithTableView:(UITableView *)tableView;

@property (nonatomic, copy) void(^cancleOrder)();
@property (nonatomic, copy) void(^payClick)();
@property (nonatomic, copy) void(^detailClick)();
@property (nonatomic, copy) void(^evaluationClick)();
@property (nonatomic, copy) void(^myComment)();

@end
