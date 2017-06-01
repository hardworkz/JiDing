//
//  Xzb_myOrderHandler.m
//  xzb
//
//  Created by rainze on 16/7/20.
//  Copyright © 2016年 xuwk. All rights reserved.
//

#import "Xzb_myOrderHandler.h"
//#import <MJRefresh.h>
#import "Xzb_MyOrderListModel.h"

@interface Xzb_myOrderHandler ()

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, assign) NSInteger orderType;
@property (nonatomic, assign) NSInteger page;


@end

@implementation Xzb_myOrderHandler

- (instancetype)initWithTableView:(UITableView *)tableView orderType:(NSInteger)orderType
{
    if (self = [super init]) {
        self.tableView = tableView;
        self.orderType = orderType;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        @WeakObj(self)
        selfWeak.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [selfWeak getData];
        }];
        selfWeak.tableView.mj_footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
            [selfWeak loadMore];
        }];
        _dataArray = [NSMutableArray array];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getData) name:checkinNotification object:nil];
    }
    return self;
}

#pragma mark - 数据加载
- (void)getData {
    _page = 0;
    UserAccount *account = [UserAccountTool account];
    NSDictionary *dic = [[NSDictionary alloc] init];
    if (_orderType == 0) {
        dic = @{@"page":[NSNumber numberWithInteger:_page],
                @"limit":@"10",
                @"start":[NSString stringWithFormat:@"%zd",_page * 10],
                @"orderStatus":@"",
                @"checkinStatus":@"",
                @"orderUserid":account.userId,
                @"userId":account.userId,
                @"token":account.loginToken};
    }else if (_orderType == 4) {
        dic = @{@"page":[NSNumber numberWithInteger:_page],
                @"limit":@"10",
                @"start":[NSString stringWithFormat:@"%zd",_page * 10],
                @"orderStatus":@"2",
                @"checkinStatus":@"",
                @"orderUserid":account.userId,
                @"userId":account.userId,
                @"token":account.loginToken};
    }else if (_orderType == 5) {
        dic = @{@"page":[NSNumber numberWithInteger:_page],
                @"limit":@"10",
                @"start":[NSString stringWithFormat:@"%zd",_page * 10],
                @"orderStatus":@"",
                @"checkinStatus":@"",
                @"checkinStatuss":@"3-4",
                @"orderUserid":account.userId,
                @"userId":account.userId,
                @"token":account.loginToken};
    }else if (_orderType == 2) {
        dic = @{@"page":[NSNumber numberWithInteger:_page],
                @"limit":@"10",
                @"start":[NSString stringWithFormat:@"%zd",_page * 10],
                @"orderStatus":[NSNumber numberWithInteger:_orderType],
                @"checkinStatus":[NSNumber numberWithInteger:_orderType],
                @"orderUserid":account.userId,
                @"userId":account.userId,
                @"token":account.loginToken};
    }else {
        dic = @{@"page":[NSNumber numberWithInteger:_page],
                @"limit":@"10",
                @"start":[NSString stringWithFormat:@"%zd",_page * 10],
                @"orderStatus":[NSNumber numberWithInteger:_orderType],
                @"checkinStatus":@"",
                @"orderUserid":account.userId,
                @"userId":account.userId,
                @"token":account.loginToken};
    }
    @WeakObj(self);
    [RTHttpTool get:SELECT_D_TO_LIST_FOR_MOBILE_ID addHUD:NO param:dic success:^(id responseObj) {
        id json = [RTHttpTool jsonWithResponseObj:responseObj];
        NSLog(@"订单列表数据:%@",json);
        if ([json[SUCCESS] intValue] == 1) {
            Xzb_MyOrderListModel *model = [Xzb_MyOrderListModel mj_objectWithKeyValues:json];
            if (selfWeak.dataArray.count) {
                [selfWeak.dataArray removeAllObjects];
            }
            [selfWeak.dataArray addObjectsFromArray:model.entities.orderInfos];
            [selfWeak.tableView reloadData];
            [selfWeak.tableView.mj_header endRefreshing];
            [selfWeak.tableView.mj_footer endRefreshing];
        }else {
            [selfWeak.tableView.mj_header endRefreshing];
            [selfWeak.tableView.mj_footer endRefreshing];
        }
    } failure:^(NSError *error) {
        [selfWeak.tableView.mj_header endRefreshing];
        [selfWeak.tableView.mj_footer endRefreshing];
    }];
}

- (void)loadMore {
    _page ++;
    UserAccount *account = [UserAccountTool account];
    NSDictionary *dic = [[NSDictionary alloc] init];
    if (_orderType == 0) {
        dic = @{@"page":[NSNumber numberWithInteger:_page],
                @"limit":@"10",
                @"start":[NSString stringWithFormat:@"%zd",_page * 10],
                @"orderStatus":@"",
                @"checkinStatus":@"",
                @"orderUserid":account.userId,
                @"userId":account.userId,
                @"token":account.loginToken};
    }else if (_orderType == 4) {
        dic = @{@"page":[NSNumber numberWithInteger:_page],
                @"limit":@"10",
                @"start":[NSString stringWithFormat:@"%zd",_page * 10],
                @"orderStatus":@"2",
                @"checkinStatus":@"",
                @"orderUserid":account.userId,
                @"userId":account.userId,
                @"token":account.loginToken};
    }else if (_orderType == 5) {
        dic = @{@"page":[NSNumber numberWithInteger:_page],
                @"limit":@"10",
                @"start":[NSString stringWithFormat:@"%zd",_page * 10],
                @"orderStatus":@"",
                @"checkinStatus":@"",
                @"checkinStatuss":@"3-4",
                @"orderUserid":account.userId,
                @"userId":account.userId,
                @"token":account.loginToken};
    }else if (_orderType == 2) {
        dic = @{@"page":[NSNumber numberWithInteger:_page],
                @"limit":@"10",
                @"start":[NSString stringWithFormat:@"%zd",_page * 10],
                @"orderStatus":[NSNumber numberWithInteger:_orderType],
                @"checkinStatus":[NSNumber numberWithInteger:_orderType],
                @"orderUserid":account.userId,
                @"userId":account.userId,
                @"token":account.loginToken};
    }else {
        dic = @{@"page":[NSNumber numberWithInteger:_page],
                @"limit":@"10",
                @"start":[NSString stringWithFormat:@"%zd",_page * 10],
                @"orderStatus":[NSNumber numberWithInteger:_orderType],
                @"checkinStatus":@"",
                @"orderUserid":account.userId,
                @"userId":account.userId,
                @"token":account.loginToken};
    }
    @WeakObj(self);
    [RTHttpTool get:SELECT_D_TO_LIST_FOR_MOBILE_ID addHUD:NO param:dic success:^(id responseObj) {
        id json = [RTHttpTool jsonWithResponseObj:responseObj];
        NSLog(@"%@",json);
        if ([json[SUCCESS] intValue] == 1) {
            Xzb_MyOrderListModel *model = [Xzb_MyOrderListModel mj_objectWithKeyValues:json];
            [selfWeak.dataArray addObjectsFromArray:model.entities.orderInfos];
            [selfWeak.tableView reloadData];
            [selfWeak.tableView.mj_header endRefreshing];
            [selfWeak.tableView.mj_footer endRefreshing];
        }else {
            selfWeak.page --;
            [selfWeak.tableView.mj_header endRefreshing];
            [selfWeak.tableView.mj_footer endRefreshing];
        }
    } failure:^(NSError *error) {
        _page --;
        [selfWeak.tableView.mj_header endRefreshing];
        [selfWeak.tableView.mj_footer endRefreshing];
    }];
}

#pragma mark - UITableViewDelegate && UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Xzb_MyOrderInfosModel *model = _dataArray[indexPath.row];
    MyOrderTableViewCell *cell = [MyOrderTableViewCell cellWithTableView:tableView];
    cell.model = model;
    @WeakObj(self);
    cell.cancleOrder = ^(){
        if ([model.businessLevel integerValue] == 6) {
            [[Toast makeText:@"无法取消"] show];
        }else {
            [selfWeak cancleOrderWithOrderID:model.ID];
        }
    };
    cell.payClick = ^(){
        [selfWeak payMonyWithOrderID:model.ID];
    };
    cell.detailClick = ^(){
        [selfWeak pushOrderDetailVCWithOrderId:model.ID];
        //        [selfWeak evaluationWithOrderId:model.ID];
    };
    cell.evaluationClick = ^(){
        [selfWeak evaluationWithOrderId:model.ID];
    };
    cell.myComment = ^(){
        [selfWeak commentDetail:model.ID];
    };
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 203;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    Xzb_MyOrderInfosModel *model = _dataArray[indexPath.row];
    [self pushOrderDetailVCWithOrderId:model.ID];
    
}

#pragma mark - 刷新数据
- (void)beginRefresh
{
    [self.tableView.mj_header beginRefreshing];
}

#pragma mark - 取消订单
- (void)cancleOrderWithOrderID:(NSString *)orderId {
    UserAccount *account = [UserAccountTool account];
    NSDictionary *dic = @{ID:orderId,USERID:account.userId,TOKEN:account.loginToken};
    @WeakObj(self);
    [RTHttpTool post:CANCLE_ORDER addHUD:NO param:dic success:^(id responseObj) {
        NSLog(@"%@",responseObj);
        if ([responseObj[SUCCESS] intValue] == 1) {
            [selfWeak getData];
        }else {
            [[Toast makeText:responseObj[MESSAGE]] show];
        }
    } failure:^(NSError *error) {
        
    }];
}

#pragma mark - 支付点击
- (void)payMonyWithOrderID:(NSString *)orderId {
//    Xzb_OrderDetailController *detailVC = [[Xzb_OrderDetailController alloc] init];
//    detailVC.orderRelID = orderId;
//    detailVC.orderID = orderId;
//    detailVC.view.backgroundColor = AppMainBgColor;
//    @WeakObj(self)
//    detailVC.didChange = ^() {
//        [selfWeak.tableView.mj_header beginRefreshing];
//    };
//    [self.navigationController pushViewController:detailVC animated:YES];
}

#pragma mark - 订单详情
- (void)pushOrderDetailVCWithOrderId:(NSString *)orderId {
//    Xzb_OrderDetailController *detailVC = [[Xzb_OrderDetailController alloc] init];
//    detailVC.orderRelID = orderId;
//    detailVC.orderID = orderId;
//    detailVC.view.backgroundColor = AppMainBgColor;
//    @WeakObj(self)
//    detailVC.didChange = ^() {
//        [selfWeak.tableView.mj_header beginRefreshing];
//    };
//    [self.navigationController pushViewController:detailVC animated:YES];
}

#pragma mark - 评价订单
- (void)evaluationWithOrderId:(NSString *)orderId{
    Xzb_CommentViewController *commentVC = [[Xzb_CommentViewController alloc] init];
    commentVC.orderID = orderId;
    @WeakObj(self);
    commentVC.commentSuccess = ^(){
        [selfWeak getData];
    };
//    commentVC.view.backgroundColor = AppMainBgColor;
    [self.navigationController pushViewController:commentVC animated:YES];
}

#pragma mark - 查看评论
- (void)commentDetail:(NSString *)orderId {
//    Xzb_HotelDetailController *hotelDetail = [[Xzb_HotelDetailController alloc] init];
//    hotelDetail.orderID = orderId;
//    hotelDetail.view.backgroundColor = AppMainBgColor;
//    hotelDetail.isComment = YES;
//    [self.navigationController pushViewController:hotelDetail animated:YES];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
