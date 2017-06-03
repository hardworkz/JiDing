//
//  Xzb_UserCommentFrameModel.m
//  xzb
//
//  Created by 张荣廷 on 16/8/5.
//  Copyright © 2016年 xuwk. All rights reserved.
//

#import "Xzb_UserCommentFrameModel.h"

#define PHOTO_W 60
@implementation Xzb_UserCommentFrameModel
- (NSMutableArray *)photoFArray
{
    if (_photoFArray == nil) {
        _photoFArray = [NSMutableArray array];
    }
    return _photoFArray;
}
- (void)setModel:(UserCommentModel *)model
{
    _model = model;
    
    //头像
    CGFloat headW;
    headW = 40;
    self.headViewF = CGRectMake(8, 8, headW, headW);
    //名称 model.userName
    CGSize nameLabelSize = [model.nickName boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size;
    self.nameLabelF = CGRectMake(CGRectGetMaxX(self.headViewF) + 15, 15,nameLabelSize.width, nameLabelSize.height);
    //时间 [NSDateFormatter stringFromDateString:model.createDate]
    CGSize timeLabelSize = [model.reviewDate boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size;
    self.timeLabelF = CGRectMake(ScreenWidth - timeLabelSize.width - 10, 18, timeLabelSize.width, timeLabelSize.height);
    //评论内容 model.content
    CGSize contentLabelSize = [model.content boundingRectWithSize:CGSizeMake(ScreenWidth - CGRectGetMaxX(self.headViewF) - 20, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]} context:nil].size;
    self.contentLabelF = CGRectMake(self.nameLabelF.origin.x, CGRectGetMaxY(self.headViewF) + 10, contentLabelSize.width, contentLabelSize.height);
    //评论图片容器
    self.imageContentLabelF = CGRectMake(0, CGRectGetMaxY(self.contentLabelF) + 10, ScreenWidth, 62);
    
    //评论图片
    for (int i = 0;i<3;i++) {
        CGRect frame = CGRectMake(self.nameLabelF.origin.x + i * (PHOTO_W + 10), 0, 62, 62);
        
        if (i<model.photoArray.count) {
            [self.photoFArray addObject:[NSValue valueWithCGRect:frame]];
        }
    }
    
    if (model.photoArray.count == 0) {
        self.deviderF = CGRectMake(10, CGRectGetMaxY(self.contentLabelF) + 10 - 0.5, ScreenWidth, 0.5);
    }else{
        self.deviderF = CGRectMake(10,CGRectGetMaxY(self.contentLabelF) + 10 + 72 - 0.5, ScreenWidth, 0.5);
    }
    self.cellHeight = CGRectGetMaxY(self.deviderF)+ 0.5;
}
@end
