//
//  AutoImageTableViewCell.m
//  JiDing
//
//  Created by zhangrongting on 2017/6/17.
//  Copyright © 2017年 zhangrongting. All rights reserved.
//

#import "AutoImageTableViewCell.h"
#import "AutoImageViewHeightFrameModel.h"

@interface AutoImageTableViewCell ()
{
    UIImageView *autoImageView;
}
@end
@implementation AutoImageTableViewCell
static const char * KeyTapGes = "KeyTapGes";
+ (NSString *)ID
{
    return @"AutoImageTableViewCell";
}
+(AutoImageTableViewCell *)cellWithTableView:(UITableView *)tableView
{
    AutoImageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[AutoImageTableViewCell ID]];
    if (cell == nil) {
        cell = [[AutoImageTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[AutoImageTableViewCell ID]];
    }
    return cell;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        autoImageView = [[UIImageView alloc] init];
        autoImageView.contentMode = UIViewContentModeScaleAspectFit;
        autoImageView.clipsToBounds = YES;
        autoImageView.userInteractionEnabled = YES;
        
        autoImageView.userInteractionEnabled = YES;
        UITapGestureRecognizer * tap = nil;
        tap = (UITapGestureRecognizer*)objc_getAssociatedObject(self, KeyTapGes);
        if (nil == tap) {
            //        [self removeAllGesture];
            tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showZoomImageView:)];
            tap.numberOfTapsRequired = 1;
            tap.numberOfTouchesRequired = 1;
            tap.cancelsTouchesInView = YES;
            tap.delaysTouchesBegan = YES;
            tap.delaysTouchesEnded = YES;
            [self addGestureRecognizer:tap];
            tap.enabled = YES;
            objc_setAssociatedObject(self,KeyTapGes, tap, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        };

        [self.contentView addSubview:autoImageView];
    }
    return self;
}
- (void)setFrameModel:(AutoImageViewHeightFrameModel *)frameModel
{
    _frameModel = frameModel;
    
    autoImageView.frame = frameModel.imageViewF;
    autoImageView.image = frameModel.image;
}
- (void)showZoomImageView:(UITapGestureRecognizer *)tap
{
    if (self.tapImage) {
        self.tapImage(tap);
    }
}
@end
