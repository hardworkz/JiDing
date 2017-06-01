//
//  Xzb_MyorderHeadView.h
//  xzb
//
//  Created by rainze on 16/7/20.
//  Copyright © 2016年 xuwk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Xzb_MyorderHeadView : UIView

/**
 *  选中按钮的下标,外部修改这个值也可以改变选中按钮的位置
 */
@property (nonatomic, assign) NSUInteger    selectIndex;

@property (nonatomic, copy) void(^buttonSelect)(NSInteger buttonTag);

- (instancetype) initWithTitles:(NSArray *)titles;

@end
