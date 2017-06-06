//
//  CustomTextField.m
//  xzb
//
//  Created by 张荣廷 on 16/6/14.
//  Copyright © 2016年 xuwk. All rights reserved.
//

#import "CustomTextField.h"

@implementation CustomTextField
//控制placeHolder的位置，左右缩20
-(CGRect)placeholderRectForBounds:(CGRect)bounds
{
    
    //return CGRectInset(bounds, 20, 0);
    CGRect inset = CGRectMake(bounds.origin.x-5, bounds.origin.y + 8, bounds.size.width, bounds.size.height);//更好理解些
    return inset;
}
//控制placeHolder的颜色、字体
- (void)drawPlaceholderInRect:(CGRect)rect
{
    //CGContextRef context = UIGraphicsGetCurrentContext();
    //CGContextSetFillColorWithColor(context, [UIColor yellowColor].CGColor);
    [AppMainColor setFill];
    
    [[self placeholder] drawInRect:rect withAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14],NSForegroundColorAttributeName:[UIColor whiteColor]}];
}

@end
