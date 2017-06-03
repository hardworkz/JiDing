//
//  PageTypeTableViewCell.m
//  xzb
//
//  Created by 张荣廷 on 16/7/20.
//  Copyright © 2016年 xuwk. All rights reserved.
//

#import "PageTypeTableViewCell.h"

@interface PageTypeTableViewCell ()
@property (nonatomic,weak)  UILabel *roomTypeLabel;
@end
@implementation PageTypeTableViewCell
- (NSMutableArray *)dataArray
{
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
+ (NSString *)ID
{
    return @"PageTypeTableViewCell";
}
+(PageTypeTableViewCell *)cellWithTableView:(UITableView *)tableView
{
    PageTypeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[PageTypeTableViewCell ID]];
    if (cell == nil) {
        cell = [[PageTypeTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[PageTypeTableViewCell ID]];
    }
    return cell;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 60)];
        contentView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:contentView];
        
        UILabel *roomTypeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, ScreenWidth, 30)];
        roomTypeLabel.textAlignment = NSTextAlignmentCenter;
        roomTypeLabel.textColor = AppMainColor;
        roomTypeLabel.text = @"豪华大床房-大床房";
        roomTypeLabel.font = [UIFont systemFontOfSize:16];
        [contentView addSubview:roomTypeLabel];
        self.roomTypeLabel = roomTypeLabel;
        
        //九宫格选择框
        // 一行的最大列数
        int maxColsPerRow = 3;
        
        // 每个图片之间的间距
        CGFloat margin = 10;
        
        // 每个图片的宽高
        CGFloat viewW = (SCREEN_Width)/3;
        CGFloat viewH = 30;
        
        for (int i = 0; i<6; i++) {
            // 行号
            int row = i / maxColsPerRow;
            // 列号
            int col = i % maxColsPerRow;
            
            UIView *view = [[UIView alloc] initWithFrame:CGRectMake((ScreenWidth/3) * col, CGRectGetMaxY(roomTypeLabel.frame) + row * (viewH + margin) + 10, viewW, viewH)];
            view.backgroundColor = [UIColor whiteColor];
            [contentView addSubview:view];
            
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 0, 30, 30)];
            imageView.contentMode = UIViewContentModeCenter;
            [view addSubview:imageView];
            
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(imageView.frame), 0, (ScreenWidth/3) - 30, 30)];
            label.textColor = [UIColor lightGrayColor];
            label.font = [UIFont systemFontOfSize:14];
            [view addSubview:label];
            
            [self.dataArray addObject:view];
            
            if (i == 0) {
                imageView.image = [UIImage imageNamed:@"床"];
                label.text = @"1.8米大床";
            }else if (i == 1) {
                imageView.image = [UIImage imageNamed:@"平方"];
                label.text = @"18-20m²";
            }else if (i == 5) {
                imageView.image = [UIImage imageNamed:@"窗"];
                label.text = @"有窗";
            }else if (i == 4) {
                imageView.image = [UIImage imageNamed:@"无线网络"];
                label.text = @"WI-FI";
            }else if (i == 3) {
                imageView.image = [UIImage imageNamed:@"人数"];
                label.text = @"可住1-2人";
            }else if (i == 2) {
                imageView.image = [UIImage imageNamed:@"楼层"];
                label.text = @"2-10层";
                self.cellHeight = CGRectGetMaxY(view.frame) + 10;
            }
            
        }
    }
    return self;
}
- (void)setModel:(Xzb_HotelDetailModel *)model
{
    _model = model;
    if (model == nil) {
        return;
    }
    //房型
    self.roomTypeLabel.text = model.roomName;
    
    //图标
    UIView *view0 = self.dataArray[0];
    for (int i = 0; i<view0.subviews.count; i++) {
        if ([view0.subviews[i] isKindOfClass:[UILabel class]]){
            UILabel *label = view0.subviews[i];
            label.text = [NSString stringWithFormat:@"%@米大床",model.width];
        }
    }
    //可用面积
    UIView *view1 = self.dataArray[1];
    for (int i = 0; i<view1.subviews.count; i++) {
        if ([view1.subviews[i] isKindOfClass:[UILabel class]]){
            UILabel *label = view1.subviews[i];
            label.text = [NSString stringWithFormat:@"%@m²",model.useArea];
        }
    }
    //楼层
    UIView *view2 = self.dataArray[2];
    for (int i = 0; i<view2.subviews.count; i++) {
        if ([view2.subviews[i] isKindOfClass:[UILabel class]]){
            UILabel *label = view2.subviews[i];
            label.text = [NSString stringWithFormat:@"%@-%@层",model.floorStart,model.floorEnd];
        }
    }
    //可住人数
    UIView *view3 = self.dataArray[3];
    for (int i = 0; i<view3.subviews.count; i++) {
        if ([view3.subviews[i] isKindOfClass:[UILabel class]]){
            UILabel *label = view3.subviews[i];
            label.text = [NSString stringWithFormat:@"可住%@人",model.supportNum];
        }
    }
    //wifi
    UIView *view4 = self.dataArray[4];
    for (int i = 0; i<view4.subviews.count; i++) {
        if ([view4.subviews[i] isKindOfClass:[UILabel class]]){
            UILabel *label = view4.subviews[i];
            if ([model.wifi intValue] == 1) {//1 为WiFi
                label.text = @"WIFI";
            }else if ([model.wifi intValue] == 2){//2 为有线网络
                label.text = @"有线网络";
            }
        }
        
        if ([view4.subviews[i] isKindOfClass:[UIImageView class]]){
            UIImageView *imageView = view4.subviews[i];
            if ([model.wifi intValue] == 1) {//1 为WiFi
                imageView.image = [UIImage imageNamed:@"无线网络"];
            }else if ([model.wifi intValue] == 2){//2 为有线网络
                imageView.image = [UIImage imageNamed:@"有线网络"];
            }
        }
    }
    //是否有窗
    UIView *view5 = self.dataArray[5];
    if ([model.isWindow intValue] == 0) {
        view5.hidden = YES;
    }
}

@end
