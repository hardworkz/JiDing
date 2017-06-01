//
//  Xzb_MapViewController.h
//  xzb
//
//  Created by 张荣廷 on 16/5/29.
//  Copyright © 2016年 xuwk. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol Xzb_MapViewControllerDelegate <NSObject>

- (void)chooseLocationWithString:(NSString *)locationString;

@end
@interface Xzb_MapViewController : RootViewController
@property (nonatomic,weak)  id<Xzb_MapViewControllerDelegate> delegate;
@end
