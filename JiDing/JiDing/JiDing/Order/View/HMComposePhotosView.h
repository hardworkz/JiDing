//
//  HMComposePhotosView.h
//  黑马微博
//
//  Created by apple on 14-7-10.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^buttonClickBlock) ();
@class HMComposePhotosView,ImageBtn;
@protocol HMComposePhotosViewDelegate <NSObject>

@optional
- (void)commentPhotosViewDidClickAddButton:(HMComposePhotosView *)photosView;
- (void)commentPhotosViewDidChangeHeight:(CGFloat)height;
- (void)commentPhotosView:(HMComposePhotosView *)photosView didClickSelectImage:(UIImageView *)gestuer;
@end

@interface HMComposePhotosView : UIView
@property (nonatomic,weak)id<HMComposePhotosViewDelegate> delegate;
@property (nonatomic , assign) int imageLimit;
@property (nonatomic , copy) buttonClickBlock addOption;
@property (nonatomic , weak) UIImageView *oneImageView;
@property (nonatomic,weak)UIButton *addButton;
/**
 *  是否为一张图，是的话图片会比较大
 */
@property (nonatomic , assign) BOOL isOne;
/**
 *  添加一张图片到相册内部
 *
 *  @param image 新添加的图片
 */
- (void)addImage:(UIImage *)image withPath:(NSString *)path;
/**
*  添加一张图片到相册内部
*
*  @param imageArray 新添加的图片数组
*/
- (void)addImages:(NSArray *)imageArray;

- (NSMutableArray *)images;
- (NSMutableArray *)imageViews;
- (void)removeImageView:(UIImageView *)imageView;
@end
