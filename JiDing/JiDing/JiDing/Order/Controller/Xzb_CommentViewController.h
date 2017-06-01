//
//  Xzb_CommentViewController.h
//  xzb
//
//  Created by 张荣廷 on 16/5/30.
//  Copyright © 2016年 xuwk. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface Xzb_CommentViewController : RootViewController
@property (nonatomic, copy) void(^commentSuccess)();
@property (nonatomic,strong) NSString *orderID;
@end
