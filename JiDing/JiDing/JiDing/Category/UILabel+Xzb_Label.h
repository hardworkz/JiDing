//
//  UILabel+Xzb_Label.h
//  xzb
//
//  Created by 张荣廷 on 16/9/5.
//  Copyright © 2016年 xuwk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (Xzb_Label)
/**
 *  设置APP字体样式
 *
 *  @param size 字体大小，默认为15
 */
- (void)setAppFontWithSize:(CGFloat)size;
/**
 *  改变行间距
 */
+ (void)changeLineSpaceForLabel:(UILabel *)label WithSpace:(float)space;

/**
 *  改变字间距
 */
+ (void)changeWordSpaceForLabel:(UILabel *)label WithSpace:(float)space;

/**
 *  改变行间距和字间距
 */
+ (void)changeSpaceForLabel:(UILabel *)label withLineSpace:(float)lineSpace WordSpace:(float)wordSpace;
@end
