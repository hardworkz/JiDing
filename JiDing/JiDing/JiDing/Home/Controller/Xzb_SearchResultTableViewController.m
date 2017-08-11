//
//  Xzb_SearchResultTableViewController.m
//  xzb
//
//  Created by 张荣廷 on 16/6/6.
//  Copyright © 2016年 xuwk. All rights reserved.
//

#import "Xzb_SearchResultTableViewController.h"

#define pageSize 5
@interface Xzb_SearchResultTableViewController ()<DQAlertViewDelegate,UITableViewDelegate,UITableViewDataSource>
//@property (nonatomic,weak)  ADView *adView;
@property (nonatomic,strong) NSMutableArray *allCellArray;
@property (nonatomic,strong) NSMutableArray *indexPathArray;
@property (nonatomic,strong) NSMutableArray *showDataArray;
@property (nonatomic,assign)  NSInteger page;
@property (strong, nonatomic) UITableView *tableView;
@end

@implementation Xzb_SearchResultTableViewController
- (NSMutableArray *)showDataArray
{
    if (_showDataArray == nil) {
        _showDataArray = [NSMutableArray array];
    }
    return _showDataArray;
}
- (NSMutableArray *)indexPathArray
{
    if (_indexPathArray == nil) {
        _indexPathArray = [NSMutableArray array];
    }
    return _indexPathArray;
}
- (NSArray *)allCellArray
{
    if (_allCellArray == nil) {
        _allCellArray = [NSMutableArray array];
    }
    return _allCellArray;
}
- (NSArray *)dataArray
{
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
- (void)alertTips
{
    NSString *alertViewCtr_str = @"离开当前页面将无法查看搜索酒店结果，是否继续？";
    //弹窗提示
    DQAlertView * alertView = [[DQAlertView alloc] initWithTitle:@"温馨提醒" message:alertViewCtr_str delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定离开", nil];
    [alertView.cancelButton setTitleColor:AppMainGrayTextColor forState:UIControlStateNormal];
    [alertView.otherButton setTitleColor:AppMainColor forState:UIControlStateNormal];
    [alertView show];
}

- (void)back_clicked
{
    [self alertTips];
}
/**
 *  跳转地图页面，添加大头针
 */
- (void)right_item_clicked
{
    Xzb_SearchResultMapController *searchResultMap = [[Xzb_SearchResultMapController alloc] init];
    searchResultMap.dataArray = self.dataArray;
    [self.navigationController pushViewController:searchResultMap animated:YES];
}
- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.page = 1;
    //设置导航栏标题
    self.title = @"酒店列表";
    UIBarButtonItem *right_item = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"列表地图"] style:UIBarButtonItemStyleDone target:self action:@selector(right_item_clicked)];
//    right_item.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = right_item;
    
    self.fd_interactivePopDisabled = YES;
    
    @WeakObj(self);
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [selfWeak refreshDataWithPage:selfWeak.page];
    }];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 10, 0);
    self.tableView.backgroundColor = AppLightLineColor;
    self.tableView.scrollsToTop = YES;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    //设置广告头部
//    [self setupHeaderView];
    //设置广告数据
//    [self getADList];
    
    //设置初始酒店数据
    if (self.dataArray.count <= pageSize) {
        [self.showDataArray addObjectsFromArray:self.dataArray];
        [self.tableView.mj_footer endRefreshingWithNoMoreData];
        [self.tableView reloadData];
    }else
    {
        [self.showDataArray addObjectsFromArray:[self.dataArray subarrayWithRange:NSMakeRange(0, pageSize)]];
        [self.tableView reloadData];
    }
    //通知应用即将关闭
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationDidOver) name:ApplicationDidEnterBackgroundNotification object:nil];
}
- (void)applicationDidOver
{
    //恢复酒店订单状态
    UserAccount *account = [UserAccountTool account];
    [RTHttpTool post:CANCLE_ORDER addHUD:NO param:@{ID:self.orderID,USERID:account.userId,TOKEN:account.loginToken} success:^(id responseObj) {
        if ([responseObj[SUCCESS] intValue] == 1) {
            
        }
    } failure:^(NSError *error) {
        
    }];

    [self.navigationController popViewControllerAnimated:YES];
}
- (void)refreshDataWithPage:(NSInteger)page
{
    //判断数组长度
    if (self.dataArray.count > ((page + 1) * pageSize)) {//表示数据多于当前页面所需要的，可满页显示，并且可以下拉刷新
        
        [self.showDataArray addObjectsFromArray:[self.dataArray subarrayWithRange:NSMakeRange(page * pageSize, pageSize)]];
        [self.tableView.mj_footer resetNoMoreData];
        self.page ++;
        NSLog(@"page---%ld",(long)self.page);
        [self.tableView reloadData];
        
    }else if(self.dataArray.count <= ((page + 1) * pageSize) && self.dataArray.count > (page  * pageSize)){//表示数据少于当前页面显示，不可满页显示，并且不可以下拉刷新
        
        [self.showDataArray addObjectsFromArray:[self.dataArray subarrayWithRange:NSMakeRange(page * pageSize, self.dataArray.count - (page  * pageSize))]];
        [self.tableView.mj_footer endRefreshingWithNoMoreData];
        [self.tableView reloadData];
        
    }else//表示当前页面不够显示，没有下页，并且不可以下拉刷新
    {
        [self.tableView.mj_footer endRefreshingWithNoMoreData];
        [self.tableView reloadData];
    }
    
}
#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.showDataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SearchResultNewTableViewCell *cell = [SearchResultNewTableViewCell cellWithTableView:tableView];
    cell.backgroundColor = [UIColor whiteColor];
    cell.model = self.showDataArray[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [self.allCellArray removeObject:cell];
    [self.allCellArray addObject:cell];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return SCREEN_WIDTH * 3/5;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    HotelOfferModel *model = self.showDataArray[indexPath.row];
    if ([model.seconds intValue] <= 0) {
        [[Toast makeText:@"该报价已失效~"] show];
        return;
    }
    Xzb_HotelDetailController *hotelDetail = [[Xzb_HotelDetailController alloc] init];
    hotelDetail.model = model;
    hotelDetail.orderRelID = model.orderRelId;
    [self.navigationController pushViewController:hotelDetail animated:YES];
}
- (void)alertOrderTips
{
    NSString *alertViewCtr_str = @"该订单报价已失效！";
    
    //弹窗提示
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:alertViewCtr_str preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    }];
    [alertController addAction:okAction];
    [self presentViewController:alertController animated:YES completion:nil];
}
#pragma mark - DQAlertViewDelegate
- (void)cancelButtonClickedOnAlertView:(DQAlertView *)alertView {
    
}

- (void)otherButtonClickedOnAlertView:(DQAlertView *)alertView {
    
    [self.navigationController popViewControllerAnimated:YES];
    //恢复酒店订单状态
    UserAccount *account = [UserAccountTool account];
    [RTHttpTool post:CANCLE_ORDER addHUD:NO param:@{ID:self.orderID,USERID:account.userId,TOKEN:account.loginToken} success:^(id responseObj) {
        if ([responseObj[SUCCESS] intValue] == 1) {
            
        }
    } failure:^(NSError *error) {
        
    }];

}
- (void)dealloc
{
//    [self.adView removeTimer];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    NSLog(@"dealloc---Xzb_SearchResultTableViewController");
    for (int i=0; i<self.dataArray.count; i++) {
        HotelOfferModel *model = self.dataArray[i];
        [model.timer invalidate];
        model.timer = nil;
    }
    for (int i=0; i<self.showDataArray.count; i++) {
        HotelOfferModel *models = self.showDataArray[i];
        [models.timer invalidate];
        models.timer = nil;
    }
    for (SearchResultNewTableViewCell *cell in self.allCellArray) {
        [cell.timer invalidate];
        cell.timer = nil;
    }
}
@end
