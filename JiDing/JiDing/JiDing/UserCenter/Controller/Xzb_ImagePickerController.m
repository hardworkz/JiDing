//
//  Xzb_ImagePickerController.m
//  xzb
//
//  Created by 张荣廷 on 16/8/1.
//  Copyright © 2016年 xuwk. All rights reserved.
//

#import "Xzb_ImagePickerController.h"

@interface Xzb_ImagePickerController ()

@end

@implementation Xzb_ImagePickerController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark status bar style
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

#pragma mark navigationBar tintColor & title textColor
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.navigationBar.tintColor = [UIColor blackColor];
        [self.navigationBar setTitleTextAttributes:@{
                                                     NSForegroundColorAttributeName : [UIColor blackColor], NSFontAttributeName:[UIFont systemFontOfSize:17]
                                                     }];
    }
    return self;
}


@end
