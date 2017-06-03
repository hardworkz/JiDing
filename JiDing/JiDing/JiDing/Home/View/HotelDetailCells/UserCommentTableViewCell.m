//
//  UserCommentTableViewCell.m
//  xzb
//
//  Created by 张荣廷 on 16/7/19.
//  Copyright © 2016年 xuwk. All rights reserved.
//

#import "UserCommentTableViewCell.h"
#import "MJPhotoBrowser.h"
#import "HZPhotoBrowser.h"
#import "MJPhoto.h"
#import "STPhotoBrowserController.h"

#define PHOTO_W 60
@interface UserCommentTableViewCell ()<MJPhotoBrowserDelegate,HZPhotoBrowserDelegate>

@property (nonatomic , weak) UILabel *nameLabel;
@property (nonatomic , weak) UILabel *timeLabel;
@property (nonatomic , weak) UIView *devider;
@property (nonatomic , weak) UILabel *contentLabel;
@property (nonatomic,weak)  UIView *imageContentView;

@property (nonatomic , strong) NSMutableArray *photoViewArray;

@property (nonatomic,strong) STPhotoBrowserController *browserVc;
@end
@implementation UserCommentTableViewCell
- (NSMutableArray *)photoViewArray
{
    if (_photoViewArray == nil) {
        _photoViewArray = [NSMutableArray array];
    }
    return _photoViewArray;
}
+ (NSString *)ID
{
    return @"UserCommentTableViewCell";
}
+ (UserCommentTableViewCell *)cellWithTableView:(UITableView *)tableView
{
    UserCommentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[UserCommentTableViewCell ID]];
    if (cell == nil) {
        cell = [[UserCommentTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[UserCommentTableViewCell ID]];
    }
    return cell;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        UIImageView *headView = [[UIImageView alloc] init];
        headView.image = [UIImage imageNamed:@"头像－默认"];
        headView.clipsToBounds = YES;
        [self.contentView addSubview:headView];
        self.headView = headView;
        
        UILabel *nameLabel = [[UILabel alloc] init];
        nameLabel.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:nameLabel];
        self.nameLabel = nameLabel;
        
        UILabel *timeLabel = [[UILabel alloc] init];
        timeLabel.font = [UIFont systemFontOfSize:15];
        timeLabel.textColor = AppMainGrayTextColor;
        [self.contentView addSubview:timeLabel];
        self.timeLabel = timeLabel;
        
        UIView *devider = [[UIView alloc] init];
        devider.backgroundColor = AppLineColor;
        [self.contentView addSubview:devider];
        self.devider = devider;
        
        UILabel *contentLabel = [[UILabel alloc] init];
        contentLabel.font = [UIFont systemFontOfSize:17];
        contentLabel.numberOfLines = 0;
        [self.contentView addSubview:contentLabel];
        self.contentLabel = contentLabel;
        
        UIView *imageContentView = [[UIView alloc] init];
        [self.contentView addSubview:imageContentView];
        self.imageContentView = imageContentView;
        
        for (int i = 0; i<3; i++) {
            UIImageView *photoView = [[UIImageView alloc] init];
            photoView.contentMode = UIViewContentModeScaleAspectFill;
            photoView.hidden = YES;
            photoView.clipsToBounds = YES;
            [imageContentView addSubview:photoView];
        }
    }
    return self;
}
- (void)setModel:(Xzb_UserCommentFrameModel *)model
{
    _model = model;
    if (model == nil) {
        self.headView.hidden = YES;
        self.devider.hidden = YES;
        return;
    }else{
        self.headView.hidden = NO;
        self.devider.hidden = NO;
    }
    
    //头像
    CGFloat headW;
    headW = 40;
    self.headView.frame = model.headViewF;
    self.headView.layer.cornerRadius = headW * 0.5;
    [self.headView sd_setImageWithURL:[NSURL URLWithString:model.model.userPhoto] placeholderImage:[UIImage imageNamed:PLACEHOLDERIMAGE]];
    //名称 model.userName
    self.nameLabel.frame = model.nameLabelF;
    self.nameLabel.text = model.model.nickName;
    //时间 [NSDateFormatter stringFromDateString:model.createDate]
    self.timeLabel.frame = model.timeLabelF;
    self.timeLabel.text = model.model.reviewDate;
    //评论内容 model.content
    self.contentLabel.frame = model.contentLabelF;
    self.contentLabel.text = model.model.content;

    //评论图片加载frame和data
    self.imageContentView.frame = model.imageContentLabelF;
    for (int i = 0;i<model.photoFArray.count;i++) {
        UITapGestureRecognizer *imageTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageTap:)];
        CGRect photoF = [model.photoFArray[i] CGRectValue];
        UIImageView *photoView = self.imageContentView.subviews[i];
        photoView.userInteractionEnabled = YES;
        [photoView addGestureRecognizer:imageTap];
        photoView.tag = i;
        photoView.frame = photoF;
        if (i < model.model.photoArray.count) {
            photoView.hidden = NO;
            Xzb_PhotoModel *photoModel = model.model.photoArray[i];
            [photoView sd_setImageWithURL:[NSURL URLWithString:photoModel.photoUrl] placeholderImage:[UIImage imageNamed:@"1"]];
        }else{
            photoView.hidden = YES;
        }
    }
    //判断评论图片是否隐藏，防止循环利用
    for (int i = 0; i<3; i++) {
        UIImageView *photoView = self.imageContentView.subviews[i];
        if (i<model.model.photoArray.count) {
            photoView.hidden = NO;
        }else{
            photoView.hidden = YES;
        }
    }
    
    self.devider.frame = model.deviderF;
}
- (void)imageTap:(UIGestureRecognizer *)gesture
{
    UIImageView *tapImageView = (UIImageView *)gesture.view;
    
    // 1.封装图片数据
//    NSMutableArray *myphotos = [NSMutableArray array];
//    for (int i = 0; i<_model.model.photoArray.count; i++) {
//        // 一个MJPhoto对应一张显示的图片
//        MJPhoto *mjphoto = [[MJPhoto alloc] init];
//        
//        mjphoto.srcImageView = self.imageContentView.subviews[i]; // 来源于哪个UIImageView
//        ;
//        Xzb_PhotoModel *photoModel = _model.model.photoArray[i];
//        mjphoto.url = [NSURL URLWithString:photoModel.photoUrl]; // 图片路径
//        
//        [myphotos addObject:mjphoto];
//    }
//    
//    // 2.显示相册
//    MJPhotoBrowser *browser = [[MJPhotoBrowser alloc] init];
//    browser.delegate = self;
//    browser.currentPhotoIndex = tapImageView.tag; // 弹出相册时显示的第一张图片是？
//    browser.photos = myphotos; // 设置所有的图片
//    [browser show];
    
    //启动图片浏览器
    HZPhotoBrowser *browser = [[HZPhotoBrowser alloc] init];
    browser.sourceImagesContainerView = self.imageContentView; // 原图的父控件
    browser.imageCount =  _model.model.photoArray.count; // 图片总数
    browser.currentImageIndex = (int)tapImageView.tag;
    browser.delegate = self;
    [browser show];
}
#pragma mark - photobrowser代理方法

// 返回临时占位图片（即原来的小图）
- (UIImage *)photoBrowser:(HZPhotoBrowser *)browser placeholderImageForIndex:(NSInteger)index
{
    UIImageView *view = self.imageContentView.subviews[index];
    return view.image;
}
// 返回高质量图片的url
- (NSURL *)photoBrowser:(HZPhotoBrowser *)browser highQualityImageURLForIndex:(NSInteger)index
{
    Xzb_PhotoModel *photoModel = _model.model.photoArray[index];
    NSString *urlStr = photoModel.photoUrl;
    return [NSURL URLWithString:urlStr];
}

@end
