//
//  Xzb_UserCommentFrameModel.h
//  xzb
//
//  Created by 张荣廷 on 16/8/5.
//  Copyright © 2016年 xuwk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Xzb_UserCommentFrameModel : NSObject
@property (nonatomic,strong) UserCommentModel *model;

@property (nonatomic , assign) CGRect headViewF;
@property (nonatomic , assign) CGRect nameLabelF;
@property (nonatomic , assign) CGRect timeLabelF;
@property (nonatomic , assign) CGRect nperLabelF;
@property (nonatomic , assign) CGRect deviderF;
@property (nonatomic , assign) CGRect contentLabelF;
@property (nonatomic , assign) CGRect imageContentLabelF;
@property (nonatomic , assign) CGFloat cellHeight;
@property (nonatomic , strong) NSMutableArray *photoFArray;

@end
