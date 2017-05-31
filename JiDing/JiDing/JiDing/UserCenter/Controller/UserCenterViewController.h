//
//  UserCenterViewController.h
//  JiDing
//
//  Created by 泡果 on 2017/5/27.
//  Copyright © 2017年 zhangrongting. All rights reserved.
//

#import "RootViewController.h"

@class UserCenterViewController;
@protocol UserCenterViewControllerDelegate <NSObject>

- (void)userCenterVCDidPop:(UserCenterViewController *)userCenterVC;

@end
@interface UserCenterViewController : RootViewController

@property (weak, nonatomic) id<UserCenterViewControllerDelegate> delegate;
@end
