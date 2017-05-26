//
//  UILabel+Xzb_Label.m
//  xzb
//
//  Created by 张荣廷 on 16/9/5.
//  Copyright © 2016年 xuwk. All rights reserved.
//

#import "UILabel+Xzb_Label.h"

@implementation UILabel (Xzb_Label)
- (void)setAppFontWithSize:(CGFloat)size
{
    if (size != 0) {
        [self setFont:[UIFont fontWithName:STHeitiSC_Light size:size]];
    }else{
        [self setFont:[UIFont fontWithName:STHeitiSC_Light size:15.0]];
    }
}
@end
