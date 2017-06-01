//
//  PhotoLibraryView.h
//  NewApp
//
//  Created by 敲代码mac1号 on 15/12/14.
//  Copyright © 2015年 you. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^buttonClickBlock) ();
@interface PhotoLibraryView : UIView

@property (nonatomic , strong) UIViewController *viewController;
@property (nonatomic , weak) UIButton *cover;
/***  余额按钮 */
@property (nonatomic , weak) UIButton *buttonZero;
/** 第一个按钮，可以setTitle */
@property (nonatomic , weak) UIButton *buttonOne;
/** 第二个按钮, 可以setTitle*/
@property (nonatomic , weak) UIButton *buttonTwo;
/** 取消按钮 */
@property (nonatomic , weak) UIButton *cancle;
/** 点击拍照操作 */
@property (nonatomic , copy) buttonClickBlock PhotoOption;
/** 点击相册操作 */
@property (nonatomic , copy) buttonClickBlock LibraryOption;
/** 点击余额操作 */
@property (nonatomic , copy) buttonClickBlock balancePay;
- (void)show;
- (void)coverClick;

@end
