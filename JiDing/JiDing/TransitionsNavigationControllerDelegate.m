//
//  TransitionsNavigationControllerDelegate.m
//  JiDing
//
//  Created by 泡果 on 2017/7/18.
//  Copyright © 2017年 zhangrongting. All rights reserved.
//

#import "TransitionsNavigationControllerDelegate.h"

@implementation TransitionsNavigationControllerDelegate

- (id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                   animationControllerForOperation:(UINavigationControllerOperation)operation
                                                fromViewController:(UIViewController *)fromVC
                                                  toViewController:(UIViewController *)toVC
{
    if (operation == UINavigationControllerOperationPop && [toVC isKindOfClass:[AnimationViewController class]]) {
        
        return [FourPingTransition transitionWithTransitionType:XWPresentOneTransitionTypeDismiss];
    }
    
    if (operation == UINavigationControllerOperationPush && [fromVC isKindOfClass:[AnimationViewController class]]) {
    
        return [FourPingTransition transitionWithTransitionType:XWPresentOneTransitionTypePresent];
    }
    
    return nil;
}

@end
