//
//  HotelIntroTableViewCell.h
//  xzb
//
//  Created by 张荣廷 on 16/7/19.
//  Copyright © 2016年 xuwk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HotelIntroTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomConstraint;
@property (weak, nonatomic) IBOutlet UIImageView *contentImageView;
//@property (weak, nonatomic) IBOutlet myUILabel *contentLabel;
@property (nonatomic,weak)  UILabel *content;
+ (NSString *)ID;
@end
