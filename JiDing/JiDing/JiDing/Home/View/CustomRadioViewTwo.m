//
//  CustomRadioViewTwo.m
//  JiDing
//
//  Created by 泡果 on 2017/6/7.
//  Copyright © 2017年 zhangrongting. All rights reserved.
//

#import "CustomRadioViewTwo.h"

#define RadioLineW sqrt(2*SCREEN_HEIGHT*SCREEN_HEIGHT)
#define Radius 5 * SCREEN_HEIGHT - RadioLineW/2
@implementation CustomRadioViewTwo

- (void)drawRect:(CGRect)rect {
    //一个不透明类型的Quartz 2D绘画环境,相当于一个画布,你可以在上面任意绘画
    CGContextRef context = UIGraphicsGetCurrentContext();
    /*画圆*/
    //边框圆
    CGContextSetRGBStrokeColor(context,115/255.0,211/255.0,52/255.0,1.0);//画笔线的颜色
    CGContextSetLineWidth(context, 100);//线的宽度
    //void CGContextAddArc(CGContextRef c,CGFloat x, CGFloat y,CGFloat radius,CGFloat startAngle,CGFloat endAngle, int clockwise)1弧度＝180°/π （≈57.3°） 度＝弧度×180°/π 360°＝360×π/180 ＝2π 弧度
    // x,y为圆点坐标，radius半径，startAngle为开始的弧度，endAngle为 结束的弧度，clockwise 0为顺时针，1为逆时针。
    CGContextAddArc(context,SCREEN_WIDTH * 0.5,SCREEN_HEIGHT * 0.5, SCREEN_WIDTH * 0.5 - 50, 0, 2*M_PI, 0); //添加一个圆
    CGContextDrawPath(context, kCGPathStroke); //绘制路径
}

@end
