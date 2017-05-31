//
//  SettingViewController.h
//  JiDing
//
//  Created by 泡果 on 2017/5/27.
//  Copyright © 2017年 zhangrongting. All rights reserved.
//

#import "RootViewController.h"

@class SettingViewController;
@protocol SettingViewControllerDelegate <NSObject>

- (void)settingVCDidPop:(SettingViewController *)settingVC;

@end
@interface SettingViewController : RootViewController
@property (weak, nonatomic) id<SettingViewControllerDelegate> delegate;
@end
