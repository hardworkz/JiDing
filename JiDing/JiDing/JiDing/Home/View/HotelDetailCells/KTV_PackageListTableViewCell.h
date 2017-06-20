//
//  KTV_PackageListTableViewCell.h
//  JiDing
//
//  Created by 泡果 on 2017/6/20.
//  Copyright © 2017年 zhangrongting. All rights reserved.
//

#import <UIKit/UIKit.h>

@class KTV_PackageListFrameModel;
@interface KTV_PackageListTableViewCell : UITableViewCell

@property (strong, nonatomic) KTV_PackageListFrameModel *frameModel;

+(KTV_PackageListTableViewCell *)cellWithTableView:(UITableView *)tableView;
@end
