//
//  TransitionsNavigationController.m
//  JiDing
//
//  Created by 泡果 on 2017/7/18.
//  Copyright © 2017年 zhangrongting. All rights reserved.
//

#import "TransitionsNavigationController.h"

@interface TransitionsNavigationController ()<UINavigationControllerDelegate>

@property (nonatomic, strong) TransitionsNavigationControllerDelegate *navigationDelegate;
@end

@implementation TransitionsNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置导航栏控制器代理
    _navigationDelegate = [[TransitionsNavigationControllerDelegate alloc] init];
    self.delegate = _navigationDelegate;
    
    self.navigationController.navigationBar.translucent = NO;
}

@end
