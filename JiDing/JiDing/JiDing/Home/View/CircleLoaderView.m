//
//  CircleLoaderView.m
//  JiDing
//
//  Created by 泡果 on 2017/7/17.
//  Copyright © 2017年 zhangrongting. All rights reserved.
//

#import "CircleLoaderView.h"

@interface CircleLoaderView ()
@property (strong, nonatomic) UIView *view;
@end

@implementation CircleLoaderView

- (instancetype)init
{
    if (self = [super init]) {
        [self configure];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self configure];
    }
    return self;
}
//初始化形状图层的配置
- (void)configure
{
    _circlePathLayer = [CAShapeLayer layer];
    _circlePathLayer.frame = self.bounds;
    _circlePathLayer.lineWidth = 2.f;
    _circlePathLayer.fillColor = [UIColor clearColor].CGColor;
    _circlePathLayer.strokeColor = [UIColor redColor].CGColor;
    _circlePathLayer.backgroundColor = [UIColor whiteColor].CGColor;
    [self.layer addSublayer:_circlePathLayer];
}
//设置环形进度条的矩形frame
- (CGRect)circleFrame
{
    CGRect circleFrame = CGRectMake(0, 0, 0, 0);
    circleFrame.origin.x = CGRectGetMidX(_circlePathLayer.bounds) - CGRectGetMidX(circleFrame);
    circleFrame.origin.y = CGRectGetMidY(_circlePathLayer.bounds) - CGRectGetMidY(circleFrame);
    return circleFrame;
}
// 通过一个矩形（正方形）绘制椭圆（圆形）路径
- (UIBezierPath *)circlePath
{
    return [UIBezierPath bezierPathWithRect:[self circleFrame]];
}
//实时刷新变化
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    _circlePathLayer.frame = self.bounds;
    _circlePathLayer.path = [self circlePath].CGPath;
}
//执行图层动画
- (void)reveal
{
    // 背景透明，那么藏着后面的imageView将显示出来
    _circlePathLayer.backgroundColor = [UIColor clearColor].CGColor;
    
    // 从它的superLayer 移除circlePathLayer ,然后赋值给super的layer mask
    [_circlePathLayer removeFromSuperlayer];
    // 通过这个这个circlePathLayer 的mask hole动画 ,image 逐渐可见
    self.superview.layer.mask = _circlePathLayer;
//    _view = view;
    
    // 1 求出最终形状
    CGPoint centerRadius = CGPointMake(SCREEN_WIDTH * 0.5, SCREEN_HEIGHT * 0.5);
    CGFloat finalRadius = sqrt((centerRadius.x*centerRadius.x) + (centerRadius.y*centerRadius.y));
    // CAShapeLayer mask最终形状
    UIBezierPath *finalPath = [UIBezierPath bezierPath];
    [finalPath addArcWithCenter:centerRadius radius:finalRadius startAngle:0. endAngle:180. clockwise:YES];
    [finalPath stroke];
    CGPathRef toPath = finalPath.CGPath;
    
    // 2 初始值
    CGPathRef fromPath = _circlePathLayer.path;
    CGFloat fromLineWidth = _circlePathLayer.lineWidth;
    
    // 3 最终值
    [CATransaction begin];
    // 防止动画完成跳回原始值
    [CATransaction setValue:@(true) forKey:kCATransactionDisableActions];
    _circlePathLayer.lineWidth = 2 * finalRadius;
    _circlePathLayer.path = toPath;
    [CATransaction commit];

    // 4 圆外扩动画（增加半径）
    CABasicAnimation *lineWidthAnimation = [CABasicAnimation animationWithKeyPath:@"lineWidth"];
    lineWidthAnimation.fromValue = @(fromLineWidth);
    lineWidthAnimation.toValue = @(2 * finalRadius);
    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
    pathAnimation.fromValue = (__bridge id _Nullable)(fromPath);
    pathAnimation.toValue = (__bridge id _Nullable)(toPath);
    
    // 5 组动画
    CAAnimationGroup *groupAnimation = [CAAnimationGroup animation];
    groupAnimation.duration = 1;
    groupAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    groupAnimation.animations = @[pathAnimation,lineWidthAnimation];
    groupAnimation.delegate = self;
    [_circlePathLayer addAnimation:groupAnimation forKey:@"strokeWidth"];
}
#pragma mark - animationDelegate
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    self.superview.layer.mask = nil;
}
@end
