//
//  StayInFriendsModel.m
//  xzb
//
//  Created by 张荣廷 on 16/7/22.
//  Copyright © 2016年 xuwk. All rights reserved.
//

#import "StayInFriendsModel.h"

@implementation StayInFriendsModel
+ (void)load
{
    [StayInFriendsModel mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
        return @{@"userID":@"id"};
    }];
}
- (NSString *)checkinDate
{
    if (_checkinDate.length >= 10) {
        _checkinDate = [_checkinDate substringToIndex:10];
    }
    return _checkinDate;
}
- (NSString *)userPhoto
{
    return [RTHttpTool returnPhotoStringWithString:_userPhoto];
}
- (CGFloat)cellHeight
{
    CGSize remarkH = [_remark boundingRectWithSize:CGSizeMake(ScreenWidth - 83, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size;
    return 53 + remarkH.height;
}
@end
