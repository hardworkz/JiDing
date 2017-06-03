//
//  OnlineFriendsView.h
//  xzb
//
//  Created by 张荣廷 on 16/7/22.
//  Copyright © 2016年 xuwk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OnlineFriendsView : UIView
@property (nonatomic , weak) UIButton *cover;
@property (nonatomic,weak)  UILabel *titleLabel;
@property (nonatomic,strong) NSString *businessID;
@property (nonatomic,strong) NSString *checkinDateString;

- (void)show;
@end
