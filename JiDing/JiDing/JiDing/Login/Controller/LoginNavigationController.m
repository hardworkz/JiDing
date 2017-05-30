//
//  LoginNavigationController.m
//  JiDing
//
//  Created by zhangrongting on 2017/5/29.
//  Copyright © 2017年 zhangrongting. All rights reserved.
//

#import "LoginNavigationController.h"

@interface LoginNavigationController ()

@end

@implementation LoginNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置一张透明图片遮盖导航栏底下的黑色线条
    [self.navigationBar setBackgroundImage:[UIImage imageNamed:@"shadow"]
                            forBarPosition:UIBarPositionAny
                                barMetrics:UIBarMetricsDefault];
    [self.navigationBar setShadowImage:[UIImage new]];
    self.navigationBar.translucent = NO;
}


@end
