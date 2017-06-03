//
//  HotelIntroTableViewCell.m
//  xzb
//
//  Created by 张荣廷 on 16/7/19.
//  Copyright © 2016年 xuwk. All rights reserved.
//

#import "HotelIntroTableViewCell.h"

@implementation HotelIntroTableViewCell
+ (NSString *)ID
{
    return @"HotelIntroTableViewCell";
}
- (void)awakeFromNib {
    [super awakeFromNib];

    UILabel *content = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(self.contentImageView.frame), ScreenWidth - 20, 30)];
    content.numberOfLines = 0;
    content.text = @"碧海蓝湾酒店非常好碧海蓝湾酒店非常好碧海蓝湾酒店非常好碧海蓝湾酒店非常好碧海蓝湾酒店非常好碧海蓝湾酒店非常好";
    content.textColor = AppMainGrayTextColor;
    content.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:content];
    self.content = content;
    
}

@end
