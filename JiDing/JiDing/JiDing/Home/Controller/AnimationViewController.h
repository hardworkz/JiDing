//
//  AnimationViewController.h
//  JiDing
//
//  Created by 泡果 on 2017/7/17.
//  Copyright © 2017年 zhangrongting. All rights reserved.
//

#import "RootViewController.h"
/**
 *  类型
 */
typedef NS_ENUM(NSUInteger, SelectedHomeType) {
    /**
     *  酒店
     */
    SelectedHomeTypeHotel = 1,
    /**
     *  KTV
     */
    SelectedHomeTypeKTV = 2,
};
@interface AnimationViewController : RootViewController

@end
