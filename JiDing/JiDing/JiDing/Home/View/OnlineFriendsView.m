//
//  OnlineFriendsView.m
//  xzb
//
//  Created by 张荣廷 on 16/7/22.
//  Copyright © 2016年 xuwk. All rights reserved.
//

#import "OnlineFriendsView.h"
#define ALERT_HEIGHT 400
@interface OnlineFriendsView ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)  UITableView *tableView;
@property (nonatomic,assign)  CGFloat cellHeight;

@property (nonatomic,strong) NSMutableArray *dataArray;
@end
@implementation OnlineFriendsView
- (NSMutableArray *)dataArray
{
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
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
        titleLabel.text = @"当天入住宿友";
        [self addSubview:titleLabel];
        self.titleLabel = titleLabel;
        
        _tableView = [[UITableView alloc] init];
        _tableView.frame = CGRectMake(0, CGRectGetMaxY(titleLabel.frame), ScreenWidth, ALERT_HEIGHT - 60);
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self addSubview:_tableView];
        
    }
    return self;
}
/**
 *  获取入住宿友数据
 */
- (void)setupFriendData
{
    UserAccount *account = [UserAccountTool account];
    [RTHttpTool get:GET_SIMPLE_DAY_FRIEND addHUD:NO param:@{USERID:account.userId,TOKEN:account.loginToken,@"businessId":self.businessID,@"checkinDate":self.checkinDateString} success:^(id responseObj) {
        if ([responseObj[SUCCESS] intValue] == 1) {
            self.dataArray = [StayInFriendsModel mj_objectArrayWithKeyValuesArray:responseObj[ENTITIES][LIST]];
            
            [self.tableView reloadData];
        }
    } failure:^(NSError *error) {
        
    }];
}

-(UIView *)topView
{
    return [[[UIApplication sharedApplication] delegate] window];
}
- (void)show
{
    [self setupFriendData];
    
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
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    StayInFriendsTableViewCell *cell = [StayInFriendsTableViewCell cellWithTableView:tableView];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    StayInFriendsModel *model = self.dataArray[indexPath.row];
    cell.model = model;
    return cell;
}
#pragma mark - tableDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    StayInFriendsModel *model = self.dataArray[indexPath.row];
    return model.cellHeight;
}
@end
