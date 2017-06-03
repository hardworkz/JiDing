//
//  Xzb_PhotoModel.m
//  xzb
//
//  Created by 张荣廷 on 16/7/26.
//  Copyright © 2016年 xuwk. All rights reserved.
//

#import "Xzb_PhotoModel.h"

@implementation Xzb_PhotoModel
- (NSString *)photoUrl
{
    return [RTHttpTool returnPhotoStringWithString:_photoUrl];
}

@end
