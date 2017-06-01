//
//  PhotoViewController.m
//  照相机demo
//
//  Created by Jason on 11/1/16.
//  Copyright © 2016年 Jason. All rights reserved.
//

#import "PhotoViewController.h"
#import "UIButton+DJBlock.h"
#define AppWidth [[UIScreen mainScreen] bounds].size.width//

#define AppHeigt [[UIScreen mainScreen] bounds].size.height
@interface PhotoViewController ()

@end

@implementation PhotoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    // Do any additional setup after loading the view.
    UIImageView *imageView = [[UIImageView alloc] initWithImage:self.image];
    imageView.frame = CGRectMake(0, 0, AppWidth, AppHeigt);
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:imageView];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(20, [UIScreen mainScreen].bounds.size.height - 60, 40, 40);
    [button setTitle:@"重拍" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:button];
    __weak typeof(self) weak = self;
    [button addActionBlock:^(id sender) {
        [weak dismissViewControllerAnimated:YES completion:nil];
    } forControlEvents:UIControlEventTouchUpInside];
 
    
    
    UIButton *button_again = [UIButton buttonWithType:UIButtonTypeCustom];
    button_again.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 125,[UIScreen mainScreen].bounds.size.height - 60, 150, 40);
    [button_again setTitle:@"使用照片" forState:UIControlStateNormal];
    [button_again setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:button_again];
    [button_again addActionBlock:^(id sender) {
        [weak dismissViewControllerAnimated:NO completion:^{
            if (weak.operation) {
                weak.operation();
            }
        }];

        

    } forControlEvents:UIControlEventTouchUpInside];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com