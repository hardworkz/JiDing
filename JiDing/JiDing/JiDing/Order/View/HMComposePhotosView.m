//
//  HMComposePhotosView.m
//  黑马微博
//
//  Created by apple on 14-7-10.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import "HMComposePhotosView.h"
#import "ImageBtn.h"
#import "CommentImageView.h"

#define Column 4
@interface HMComposePhotosView ()
@end

@implementation HMComposePhotosView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        UIButton *addButton = [[UIButton alloc] init];
//        addButton.backgroundColor = [UIColor blueColor];
        [addButton setBackgroundImage:[UIImage imageNamed:@"添加图片"] forState:UIControlStateNormal];
        addButton.layer.cornerRadius = 5;
        addButton.layer.masksToBounds = YES;
        [self addSubview:addButton];
        [addButton addTarget:self action:@selector(addButtonClick) forControlEvents:UIControlEventTouchUpInside];
        self.addButton = addButton;
    }
    return self;
}
- (void)removeImageView:(UIImageView *)imageView
{
    [imageView removeFromSuperview];
}

- (void)addImages:(NSArray *)imageArray
{
    for (UIImage *image in imageArray) {
        [self addImage:image withPath:nil];
    }
}

- (void)addImage:(UIImage *)image withPath:(NSString *)path
{
    CommentImageView *imageView = [[CommentImageView alloc] init];
    imageView.photoPath = path;
//    imageView.layer.cornerRadius = 5;
    imageView.userInteractionEnabled = YES;
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.clipsToBounds = YES;
    imageView.image = image;
    [self insertSubview:imageView atIndex:0];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    [imageView addGestureRecognizer:tap];
    if (self.isOne) {
        self.oneImageView = imageView;
    }
    // 一行的最大列数
    int maxColsPerRow = Column;
    
    // 每个图片之间的间距
    CGFloat marginw = 10;
    
    // 每个图片的宽高
    CGFloat imageViewW = (self.width - (maxColsPerRow + 1) * marginw) / maxColsPerRow;
    ImageBtn *subBtn = [[ImageBtn alloc] initWithFrame:CGRectMake(imageViewW - 20, 0, 20, 20)];
    [subBtn setBackgroundImage:[UIImage imageNamed:@"删除图片"] forState:UIControlStateNormal];
    subBtn.clipsToBounds = YES;
    subBtn.layer.cornerRadius = 10;
    subBtn.imageViews = imageView;
    [subBtn addTarget:self action:@selector(removeImageViews:) forControlEvents:UIControlEventTouchUpInside];
    [imageView addSubview:subBtn];
}
- (void)removeImageViews:(ImageBtn *)btn
{
    if ([self.delegate respondsToSelector:@selector(commentPhotosView:didClickSelectImage:)]) {
        [self.delegate commentPhotosView:self didClickSelectImage:btn.imageViews];
    }
    
    [self removeImageView:btn.imageViews];
}
-(void)tap:(UITapGestureRecognizer *)gesture
{
    
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    NSUInteger count = self.subviews.count;
    // 一行的最大列数
    int maxColsPerRow = Column;
    
    // 每个图片之间的间距
    CGFloat marginw = 10;
    
    // 每个图片的宽高
    CGFloat imageViewW = (self.width - (maxColsPerRow + 1) * marginw) / maxColsPerRow;
    CGFloat imageViewH = imageViewW;
    
    for (int i = 0; i<count; i++) {
        // 行号
        int row = i / maxColsPerRow;
        // 列号
        int col = i % maxColsPerRow;
        UIImageView *imageView = self.subviews[i];
        if (self.isOne) {
            
            imageView.width = 100;
            imageView.height = 150;
            imageView.y = 0;
            imageView.x = 0;
            
        }else
        {            
            imageView.width = imageViewW;
            imageView.height = imageViewH;
            imageView.y = row * (imageViewH + marginw);
            imageView.x = col * (imageViewW + marginw) + marginw;
        }
        
        if (i == count - 1) {
            self.height = CGRectGetMaxY(imageView.frame);
            if ([self.delegate respondsToSelector:@selector(commentPhotosViewDidChangeHeight:)]) {
                [self.delegate commentPhotosViewDidChangeHeight:self.height];
            }
        }
        
        self.addButton.size = CGSizeMake(imageViewW, imageViewW);
    }
    if (self.subviews.count == self.imageLimit) {
        self.addButton.hidden = YES;
    }else{
        self.addButton.hidden = NO;
    }
    
}
- (void)addButtonClick
{
    if (self.addOption) {
        self.addOption();
    }
    if ([self.delegate respondsToSelector:@selector(commentPhotosViewDidClickAddButton:)]) {
        [self.delegate commentPhotosViewDidClickAddButton:self];
    }
}
- (NSMutableArray *)images
{
    NSMutableArray *array = [NSMutableArray array];
    for (UIImageView *imageView in self.subviews) {
        if ([imageView isKindOfClass:[UIImageView class]]) {
            [array addObject:imageView.image];
        }
    }
    return array;
}
- (NSMutableArray *)imageViews
{
    NSMutableArray *array = [NSMutableArray array];
    for (UIImageView *imageView in self.subviews) {
        if ([imageView isKindOfClass:[CommentImageView class]]) {
            [array addObject:imageView];
        }
    }
    return array;
}
@end
