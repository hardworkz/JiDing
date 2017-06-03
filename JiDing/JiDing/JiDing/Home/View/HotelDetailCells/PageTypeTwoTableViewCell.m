//
//  PageTypeTwoTableViewCell.m
//  xzb
//
//  Created by 张荣廷 on 16/7/20.
//  Copyright © 2016年 xuwk. All rights reserved.
//

#import "PageTypeTwoTableViewCell.h"

@interface PageTypeTwoTableViewCell ()
@property (nonatomic,strong) NSMutableArray *facilitiesModelArray;
@end
@implementation PageTypeTwoTableViewCell
- (NSMutableArray *)facilitiesModelArray
{
    if (_facilitiesModelArray == nil) {
        _facilitiesModelArray = [NSMutableArray array];
    }
    return _facilitiesModelArray;
}
+ (NSString *)ID
{
    return @"PageTypeTwoTableViewCell";
}
+(PageTypeTwoTableViewCell *)cellWithTableView:(UITableView *)tableView
{
    PageTypeTwoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[PageTypeTwoTableViewCell ID]];
    if (cell == nil) {
        cell = [[PageTypeTwoTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[PageTypeTwoTableViewCell ID]];
    }
    return cell;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 600)];
        contentView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:contentView];
    }
    return self;
}
- (void)setBusinessFacilities:(NSString *)businessFacilities
{
    _businessFacilities = businessFacilities;
    //分割酒店设施数据，用，号隔开
    NSArray *facilitiesArray = [businessFacilities componentsSeparatedByString:@","];
    
    
    for (int i = 1; i<28; i++) {
        Xzb_BusinessFacilitiesModel *model = [[Xzb_BusinessFacilitiesModel alloc] init];
        model.facilitiesID = [NSString stringWithFormat:@"%d",i];
        if (i == 1) {
            model.facilitiesImage = @"无线网络";
            model.facilitiesImage_no = @"无线网络1";
            model.facilitiesName = @"无线网络";
        }else if (i == 2){
            model.facilitiesImage = @"热水淋浴";
            model.facilitiesImage_no = @"热水淋浴1";
            model.facilitiesName = @"热水淋浴";
        }else if (i == 3){
            model.facilitiesImage = @"空调";
            model.facilitiesImage_no = @"空调1";
            model.facilitiesName = @"空调";
        }else if (i == 4){
            model.facilitiesImage = @"饮水设备";
            model.facilitiesImage_no = @"饮水设备1";
            model.facilitiesName = @"饮水设备";
        }else if (i == 5){
            model.facilitiesImage = @"拖鞋";
            model.facilitiesImage_no = @"拖鞋1";
            model.facilitiesName = @"拖鞋";
        }else if (i == 6){
            model.facilitiesImage = @"手纸";
            model.facilitiesImage_no = @"手纸1";
            model.facilitiesName = @"手纸";
        }else if (i == 7){
            model.facilitiesImage = @"沐浴露";
            model.facilitiesImage_no = @"沐浴露1";
            model.facilitiesName = @"沐浴/洗发";
        }else if (i == 8){
            model.facilitiesImage = @"有线网络";
            model.facilitiesImage_no = @"有线网络1";
            model.facilitiesName = @"有线网络";
        }else if (i == 9){
            model.facilitiesImage = @"牙具";
            model.facilitiesImage_no = @"牙具1";
            model.facilitiesName = @"牙具";
        }else if (i == 10){
            model.facilitiesImage = @"香皂";
            model.facilitiesImage_no = @"香皂1";
            model.facilitiesName = @"香皂";
        }else if (i == 11){
            model.facilitiesImage = @"行李寄存";
            model.facilitiesImage_no = @"行李寄存1";
            model.facilitiesName = @"行李寄存";
        }else if (i == 12){
            model.facilitiesImage = @"门禁系统";
            model.facilitiesImage_no = @"门禁系统1";
            model.facilitiesName = @"门禁";
        }else if (i == 13){
            model.facilitiesImage = @"有线电视";
            model.facilitiesImage_no = @"有线电视1";
            model.facilitiesName = @"有线电视";
        }else if (i == 14){
            model.facilitiesImage = @"吹风机";
            model.facilitiesImage_no = @"吹风机1";
            model.facilitiesName = @"吹风机";
        }else if (i == 15){
            model.facilitiesImage = @"暖气";
            model.facilitiesImage_no = @"暖气1";
            model.facilitiesName = @"暖气";
        }else if (i == 16){
            model.facilitiesImage = @"叫醒服务";
            model.facilitiesImage_no = @"叫醒服务1";
            model.facilitiesName = @"叫醒服务";
        }else if (i == 17){
            model.facilitiesImage = @"允许吸烟";
            model.facilitiesImage_no = @"允许吸烟1";
            model.facilitiesName = @"允许吸烟";
        }else if (i == 18){
            model.facilitiesImage = @"毛巾";
            model.facilitiesImage_no = @"毛巾1";
            model.facilitiesName = @"毛巾";
        }else if (i == 19){
            model.facilitiesImage = @"中餐厅";
            model.facilitiesImage_no = @"中餐厅1";
            model.facilitiesName = @"中餐厅";
        }else if (i == 20){
            model.facilitiesImage = @"西餐厅";
            model.facilitiesImage_no = @"西餐厅1";
            model.facilitiesName = @"西餐厅";
        }else if (i == 21){
            model.facilitiesImage = @"浴缸";
            model.facilitiesImage_no = @"浴缸1";
            model.facilitiesName = @"浴缸";
        }else if (i == 22){
            model.facilitiesImage = @"停车位";
            model.facilitiesImage_no = @"停车位1";
            model.facilitiesName = @"停车位";
        }else if (i == 23){
            model.facilitiesImage = @"洗衣机";
            model.facilitiesImage_no = @"洗衣机1";
            model.facilitiesName = @"洗衣机";
        }else if (i == 24){
            model.facilitiesImage = @"电梯";
            model.facilitiesImage_no = @"电梯1";
            model.facilitiesName = @"电梯";
        }else if (i == 25){
            model.facilitiesImage = @"允许聚会";
            model.facilitiesImage_no = @"允许聚会1";
            model.facilitiesName = @"允许聚会";
        }else if (i == 26){
            model.facilitiesImage = @"允许带宠物";
            model.facilitiesImage_no = @"允许带宠物1";
            model.facilitiesName = @"携带宠物";
        }else if (i == 27){
            model.facilitiesImage = @"冰箱";
            model.facilitiesImage_no = @"冰箱1";
            model.facilitiesName = @"冰箱";
        }
        
        //判读是否存在该类型酒店设施
        [self existWithIndex:i array:facilitiesArray model:model];
        
        //添加到模型数据数组
        [self.facilitiesModelArray addObject:model];
    }
    
    //九宫格
    // 一行的最大列数
    int maxColsPerRow = 3;
    
    // 每个图片之间的间距
    CGFloat margin = 10;
    
    // 每个图片的宽高
    CGFloat viewW = (SCREEN_Width)/3;
    CGFloat viewH = 30;
    
    for (int i = 0; i<self.facilitiesModelArray.count; i++) {
        Xzb_BusinessFacilitiesModel *model = self.facilitiesModelArray[i];
        // 行号
        int row = i / maxColsPerRow;
        // 列号
        int col = i % maxColsPerRow;
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake((ScreenWidth/3) * col,row * (viewH + margin) + 10, viewW, viewH)];
        view.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:view];
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 0, 30, 30)];
        imageView.contentMode = UIViewContentModeCenter;
        
        [view addSubview:imageView];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(imageView.frame), 0, (ScreenWidth/3) - 30, 30)];
        label.textColor = [UIColor lightGrayColor];
        label.font = [UIFont systemFontOfSize:14];
        label.text = model.facilitiesName;
        [view addSubview:label];
        
        if (model.status == YES) {
            imageView.image = [UIImage imageNamed:model.facilitiesImage];
            label.textColor = AppMainGrayTextColor;
        }else{
            imageView.image = [UIImage imageNamed:model.facilitiesImage_no];
            label.textColor = [UIColor lightGrayColor];
        }
    }
    
}
- (void)existWithIndex:(int)index array:(NSArray *)facilitiesArray model:(Xzb_BusinessFacilitiesModel *)model
{
    BOOL exist;
    for (int j = 0; j<facilitiesArray.count; j++) {
        if (index == [facilitiesArray[j] intValue]) {//表示存在酒店设施
            exist = YES;
            break;//找到符合条件跳出循环
        }
    }
    if (exist) {
        model.status = YES;
    }else{
        model.status = NO;
    }
}
@end
