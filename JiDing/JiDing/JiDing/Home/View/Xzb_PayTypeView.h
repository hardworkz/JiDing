//
//  Xzb_PayTypeView.h
//  xzb
//
//  Created by 张荣廷 on 16/8/10.
//  Copyright © 2016年 xuwk. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^buttonClickBlock) ();
@interface Xzb_PayTypeView : UIView

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
