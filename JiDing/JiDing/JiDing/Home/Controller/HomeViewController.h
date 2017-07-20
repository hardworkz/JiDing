//
//  HomeViewController.h
//  JiDing
//
//  Created by 泡果 on 2017/5/26.
//  Copyright © 2017年 zhangrongting. All rights reserved.
//

#import "RootViewController.h"
#import "AnimationViewController.h"

@interface HomeViewController : RootViewController
/**
 单例

 @return 返回单例对象
 */
+ (instancetype)shareInstance;
/**
 *  当前选择的首页类型，默认为酒店
 */
@property (assign, nonatomic) SelectedHomeType homeType;
/**
 动画控制器
 */
@property (strong, nonatomic) AnimationViewController *animationVC;
@end
