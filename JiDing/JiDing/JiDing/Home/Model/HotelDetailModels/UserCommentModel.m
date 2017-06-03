//
//  UserCommentModel.m
//  xzb
//
//  Created by 张荣廷 on 16/7/19.
//  Copyright © 2016年 xuwk. All rights reserved.
//

#import "UserCommentModel.h"

@implementation UserCommentModel
- (CGFloat)cellHeight
{
    CGSize contentLabelSize = [_content boundingRectWithSize:CGSizeMake(ScreenWidth - 48 - 20, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]} context:nil].size;

    if (self.photoArray.count != 0) {
        RTLog(@"%f",88 + 72 + contentLabelSize.height - 17);
            return 88 + 72 + contentLabelSize.height - 17;
    }
    RTLog(@"%f",88 + contentLabelSize.height - 17);
    return 88 + contentLabelSize.height - 17;
}
- (NSMutableArray *)photoArray
{
    if (_photoArray == nil) {
        _photoArray = [NSMutableArray array];
    }
    if (_photoArray.count != 0) {
        return _photoArray;
    }
    NSArray *array = [_photos componentsSeparatedByString:@","];
    
    [_photoArray removeAllObjects];
    if ([_photos isEqualToString:@""]) {
        return _photoArray;
    }
    for (NSString *string in array) {
        Xzb_PhotoModel *model = [[Xzb_PhotoModel alloc] init];
        model.photoUrl = string;
        [_photoArray addObject:model];
    }
    return _photoArray;
}
- (NSString *)userPhoto
{
    return [RTHttpTool returnPhotoStringWithString:_userPhoto];
}
//- (NSString *)content
//{
//    return [_content stringByReplacingOccurrencesOfString:@"\n" withString:@""];
//}
@end
