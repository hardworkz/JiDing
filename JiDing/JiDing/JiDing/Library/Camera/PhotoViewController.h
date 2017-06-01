//
//  PhotoViewController.h
//  照相机demo
//
//  Created by Jason on 11/1/16.
//  Copyright © 2016年 Jason. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotoViewController : UIViewController
@property (nonatomic,strong) UIImage *image;
@property (nonatomic, copy) void(^operation)();
@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com