//
//  FourPingTransition.m
//  控制器专场动画集合
//
//  Created by apple on 16/6/12.
//  Copyright © 2016年 雷晏. All rights reserved.
//

#import "FourPingTransition.h"

@implementation FourPingTransition


+ (instancetype)transitionWithTransitionType:(XWPresentOneTransitionType)type
{
    return [[self alloc]initWithTransitionType:type];
}
- (instancetype)initWithTransitionType:(XWPresentOneTransitionType)type
{
    if(self = [super init]){
        _type = type;
    }
    return self;
}

#pragma - mark UIViewControllerAnimatedTransitioning
-(NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
    return 1.;
}

-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    switch (_type) {
        case XWPresentOneTransitionTypePresent:
            [self presentAnimation:transitionContext];
            break;
        case XWPresentOneTransitionTypeDismiss:
            [self dismissAnimation:transitionContext];
            break;
        default:
            break;
    }
}

//
- (void)presentAnimation:(id<UIViewControllerContextTransitioning>)transitionContext{
    
    //我们可以利用viewControllerForKey: 方法知道是从哪个controller变换到哪个controller
    UINavigationController *fromVC = (UINavigationController *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *temp = fromVC.viewControllers.lastObject;
    
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    //拿到button
//    UIButton *button;
//    NSArray *subArray = [[[[temp.view.window.subviews objectAtIndex:1] subviews] objectAtIndex:2] subviews];
//    for (UIView *view in subArray) {
//        if ([view.accessibilityLabel isEqualToString:@"设置"]) {
//            button = (UIButton *)view;
//            break;
//        }
//        if ([view.accessibilityLabel isEqualToString:@"个人"]) {
//            button = (UIButton *)view;
//            break;
//        }
//    }
    
    UIView *containerView = [transitionContext containerView]; //这个UIView就是执行动画的地方
    //我们还要确保controller的view都必须是这个containerView的subview
    [containerView addSubview:toVC.view];
    
    //画圆
    UIBezierPath *startCycle;
    CGFloat x;
    CGFloat y;
    if ([toVC isKindOfClass:[UserCenterViewController class]]) {
        startCycle = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(SCREEN_WIDTH, SCREEN_HEIGHT, 0, 0)];
        x = SCREEN_WIDTH;
        y = SCREEN_HEIGHT;
    }else{
        startCycle = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, SCREEN_HEIGHT, 0, 0)];
        x = SCREEN_WIDTH;
        y = SCREEN_HEIGHT;
    }

    //求出半径
    CGFloat radius = sqrtf(pow(x, 2) + pow(y, 2));
    
    UIBezierPath *endCycle = [UIBezierPath bezierPathWithArcCenter:containerView.center radius:radius startAngle:0 endAngle:M_PI * 2 clockwise:YES];
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.path = endCycle.CGPath;
    toVC.view.layer.mask = maskLayer;
    
    //
    CABasicAnimation *maskLayerAnimation = [CABasicAnimation animation];
    maskLayerAnimation.delegate = self;
    maskLayerAnimation.fromValue = (__bridge id _Nullable)(startCycle.CGPath);
    maskLayerAnimation.toValue = (__bridge id _Nullable)(endCycle.CGPath);
    maskLayerAnimation.duration = [self transitionDuration:transitionContext];
    maskLayerAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    
    [maskLayerAnimation setValue:transitionContext forKey:@"transitionContext"];
    [maskLayer addAnimation:maskLayerAnimation forKey:@"path"];
}

- (void)dismissAnimation:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UINavigationController *toVC = (UINavigationController *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController *temp = toVC.viewControllers.lastObject;
    UIView *containerView = [transitionContext containerView];
    [containerView insertSubview:toVC.view atIndex:0];
    //画两个圆路径
    CGFloat radius = sqrtf(containerView.frame.size.height * containerView.frame.size.height + containerView.frame.size.width * containerView.frame.size.width) / 2;
    UIBezierPath *startCycle = [UIBezierPath bezierPathWithArcCenter:containerView.center radius:radius startAngle:0 endAngle:M_PI * 2 clockwise:YES];
    UIBezierPath *endCycle =  [UIBezierPath bezierPathWithOvalInRect:[[[temp.view.subviews objectAtIndex:2] subviews] objectAtIndex:1].frame];
    //创建CAShapeLayer进行遮盖
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.fillColor = [UIColor greenColor].CGColor;
    maskLayer.path = endCycle.CGPath;
    fromVC.view.layer.mask = maskLayer;
    //创建路径动画
    CABasicAnimation *maskLayerAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
    maskLayerAnimation.delegate = self;
    maskLayerAnimation.fromValue = (__bridge id)(startCycle.CGPath);
    maskLayerAnimation.toValue = (__bridge id)((endCycle.CGPath));
    maskLayerAnimation.duration = [self transitionDuration:transitionContext];
    maskLayerAnimation.timingFunction = [CAMediaTimingFunction  functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [maskLayerAnimation setValue:transitionContext forKey:@"transitionContext"];
    [maskLayer addAnimation:maskLayerAnimation forKey:@"path"];
}

-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    switch (_type) {
        case XWPresentOneTransitionTypePresent:{
          id<UIViewControllerContextTransitioning> transitionContext = [anim valueForKey:@"transitionContext"];
            //更新内部视图控制器状态的转换在转换结束
            [transitionContext completeTransition:YES];
            [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey].view.layer.mask = nil;
        }
            break;
            
        case XWPresentOneTransitionTypeDismiss:{
            id<UIViewControllerContextTransitioning> transitionContext = [anim valueForKey:@"transitionContext"];
            [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
            if ([transitionContext transitionWasCancelled]) {
                [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey].view.layer.mask = nil;
            }
        }
            break;
        default:
            break;
    }
}
@end
