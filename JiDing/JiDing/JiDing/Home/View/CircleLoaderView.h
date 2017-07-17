//
//  CircleLoaderView.h
//  JiDing
//
//  Created by 泡果 on 2017/7/17.
//  Copyright © 2017年 zhangrongting. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CircleLoaderView : UIView<CAAnimationDelegate>
@property (strong, nonatomic) CAShapeLayer *circlePathLayer;

//执行图层动画
- (void)reveal;
@end
