//
//  UserCommentTableViewCell.h
//  xzb
//
//  Created by 张荣廷 on 16/7/19.
//  Copyright © 2016年 xuwk. All rights reserved.
//

#import <UIKit/UIKit.h>

@class UserCommentModel,Xzb_UserCommentFrameModel;
@interface UserCommentTableViewCell : UITableViewCell
@property (nonatomic,strong) Xzb_UserCommentFrameModel *model;
@property (nonatomic , weak) UIImageView *headView;
+ (NSString *)ID;
+ (UserCommentTableViewCell *)cellWithTableView:(UITableView *)tableView;
@end
