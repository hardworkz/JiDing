//
//  HotelIntroView.m
//  xzb
//
//  Created by 张荣廷 on 16/7/22.
//  Copyright © 2016年 xuwk. All rights reserved.
//

#import "HotelIntroView.h"

#define ALERT_HEIGHT 400

@interface HotelIntroView ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,weak)  UITableView *tableView;

@property (nonatomic,strong) NSMutableArray *imageArray;
@property (strong,nonatomic) NSMutableArray* imgs;
@end
@implementation HotelIntroView
- (void)setHotelModel:(Xzb_HotelDetailModel *)hotelModel
{
    _hotelModel = hotelModel;
    NSArray *array = [hotelModel.businessPhoto componentsSeparatedByString:@","];
    if (array.count != 0) {
        Xzb_PhotoModel *model = [[Xzb_PhotoModel alloc] init];
        model.photoUrl = array[0];
        RTLog(@"%@",model.photoUrl);
        [self.imageArray addObject:model];
    }
    [self setupImageData];
    [self.tableView reloadData];
}
- (NSMutableArray *)imgs
{
    if (_imgs == nil) {
        _imgs = [NSMutableArray array];
    }
    return _imgs;
}
- (NSMutableArray *)imageArray
{
    if (_imageArray == nil) {
        _imageArray = [NSMutableArray array];
    }
    return _imageArray;
}

- (instancetype)init
{
    if (self == [super init]) {
        self.backgroundColor = [UIColor whiteColor];
        
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.frame = CGRectMake(0,0, ScreenWidth, 30);
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.textColor = AppMainGrayTextColor;
        titleLabel.font = [UIFont systemFontOfSize:17];
        [self addSubview:titleLabel];
        self.titleLabel = titleLabel;
        
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(titleLabel.frame), ScreenWidth, ALERT_HEIGHT - 60)];
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self addSubview:tableView];
        self.tableView = tableView;
        
        [self initTableViewCell];
    }
    return self;
}
- (void)initTableViewCell
{
    [_tableView registerNib:[UINib nibWithNibName:[HotelIntroTableViewCell ID] bundle:nil] forCellReuseIdentifier:[HotelIntroTableViewCell ID]];
}
-(UIView *)topView
{
    return [[[UIApplication sharedApplication] delegate] window];
}
- (void)show
{
    self.frame = CGRectMake(0, SCREEN_Height, SCREEN_Width, ALERT_HEIGHT);
    [[self topView] addSubview:self];
    //添加遮盖
    UIButton *cover = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, SCREEN_Height)];
    
    cover.backgroundColor = [UIColor blackColor];
    cover.alpha = 0;
    [cover addTarget:self action:@selector(coverClick) forControlEvents:UIControlEventTouchUpInside];
    self.cover = cover;
    
    [[self topView] insertSubview:cover belowSubview:self];
    
    [UIView animateWithDuration:0.25 animations:^{
        cover.alpha = 0.6;
        self.frame = CGRectMake(0, SCREEN_Height - ALERT_HEIGHT, SCREEN_Width, ALERT_HEIGHT);
    }];
}
- (void)coverClick
{
    [UIView animateWithDuration:0.25 animations:^{
        self.frame = CGRectMake(0, SCREEN_Height, SCREEN_Width, ALERT_HEIGHT);
        self.cover.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        [self.cover removeFromSuperview];
    }];
}
#pragma mark - tableDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HotelIntroTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[HotelIntroTableViewCell ID] forIndexPath:indexPath];
    Xzb_PhotoModel *model = self.imageArray[indexPath.row];
    [cell.contentImageView sd_setImageWithURL:[NSURL URLWithString:model.photoUrl] placeholderImage:[UIImage imageNamed:@"1"]];
    CGSize contentSize = [self.hotelModel.descriptions boundingRectWithSize:CGSizeMake(300, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size;
    cell.bottomConstraint.constant = 10 + contentSize.height;//设置为label内容的高度加上间隔
    if(indexPath.row<(_imgs.count)){
        
        NSDictionary* dict = _imgs[indexPath.row];
        if([dict[@"img"] isKindOfClass:[UIImage class]]){
            UIImage* img = dict[@"img"];
            cell.content.y = img.size.height/img.size.width*tableView.mj_w + 10;//设置内容label的y值
//            cell.contentImageView.image = img;
        }else{
            cell.content.y = 200;
        }
    }
    
    _titleLabel.text = self.hotelModel.businessName;
    cell.content.text = self.hotelModel.descriptions;
    cell.content.height = contentSize.height;//设置内容label的高度
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
#pragma mark - tableDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row<(_imgs.count)){
        
        NSDictionary* dict = _imgs[indexPath.row];
        if([dict[@"img"] isKindOfClass:[UIImage class]]){
            UIImage* img = dict[@"img"];
            CGSize contentSize = [self.hotelModel.descriptions boundingRectWithSize:CGSizeMake(300, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size;
            NSLog(@"cellH---%f",img.size.height/img.size.width*tableView.mj_w + 10 + contentSize.height);
            return img.size.height/img.size.width*tableView.mj_w + 10 + contentSize.height;
        }else{
            
        }
    }
    return 200;
}
/**
 *  设置缓存图片，获取图片宽高计算cell高度
 */
- (void)setupImageData
{
    for (int index=0;index<self.imageArray.count;index++) {
        Xzb_PhotoModel *model = self.imageArray[index];
        NSString *photoUrl = model.photoUrl;
        NSMutableDictionary* dict = [@{@"url":model.photoUrl} mutableCopy];
        [self.imgs addObject:dict];
        if([[SDWebImageManager sharedManager] cachedImageExistsForURL:[NSURL URLWithString:photoUrl]]){
            NSMutableDictionary* dict = _imgs[index];
            UIImage* img = [[SDWebImageManager sharedManager].imageCache imageFromMemoryCacheForKey:[[SDWebImageManager sharedManager] cacheKeyForURL:[NSURL URLWithString:photoUrl]]];
            
            if(!img)
                img = [[SDWebImageManager sharedManager].imageCache imageFromDiskCacheForKey:[[SDWebImageManager sharedManager] cacheKeyForURL:[NSURL URLWithString:photoUrl]]];
            
            [dict setObject:img forKey:@"img"];
            
        }else{
            
            [[SDWebImageManager sharedManager] downloadImageWithURL:[NSURL URLWithString:photoUrl] options:SDWebImageRetryFailed|SDWebImageLowPriority progress:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
                if (image) {
                    if(index <_imgs.count){
                        NSMutableDictionary* dict = _imgs[index];
                        [dict setObject:image forKey:@"img"];
                        [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:index inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
                    }
                }
            }];
        }
    }
}

@end
