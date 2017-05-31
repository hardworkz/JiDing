//
//  UserCenterViewController.m
//  JiDing
//
//  Created by 泡果 on 2017/5/27.
//  Copyright © 2017年 zhangrongting. All rights reserved.
//

#import "UserCenterViewController.h"

@interface UserCenterViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) UITableView *tableView;
@end

@implementation UserCenterViewController
- (UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"我的";
    
    
    [self.view addSubview:self.tableView];
}
- (void)actionAutoBack:(UIBarButtonItem *)barItem
{
    if ([self.delegate respondsToSelector:@selector(userCenterVCDidPop:)]) {
        [self.delegate userCenterVCDidPop:self];
    }
}
#pragma mark - table dataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        UserDataTableViewCell *cell = [UserDataTableViewCell cellWithTableView:tableView];
        return cell;
    }else if (indexPath.row == 1) {
        UserCenterOrderCell *cell = [UserCenterOrderCell cellWithTableView:tableView];
        return cell;
    }else {
        UserCenterMessageCell *cell = [UserCenterMessageCell cellWithTableView:tableView];
        return cell;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 200;
    }else if (indexPath.row == 1) {
        return 200;
    }else {
        return 200;
    }
}
#pragma mark - table delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

@end
