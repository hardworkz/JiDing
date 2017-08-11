//
//  Xzb_MyOrderViewController.m
//  xzb
//
//  Created by 张荣廷 on 16/5/26.
//  Copyright © 2016年 xuwk. All rights reserved.
//

#import "Xzb_MyOrderViewController.h"
#import "Xzb_myOrderHandler.h"
#import "Xzb_MyorderHeadView.h"

@interface Xzb_MyOrderViewController ()<UIScrollViewDelegate>

@property (nonatomic, strong) Xzb_MyorderHeadView *headView;
@property (nonatomic, strong) UIScrollView        *scrollView;
@property (nonatomic, strong) NSArray             *handlers;
@property (nonatomic, strong) NSArray             *tableViews;

@end

@implementation Xzb_MyOrderViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupView];

}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    NSMutableArray *handlerNew = [NSMutableArray array];
    for (Xzb_myOrderHandler *handler in self.handlers) {
        handler.navigationController = self.navigationController;
        [handlerNew addObject:handler];
    }
    self.handlers = handlerNew;
}

- (void)back_clicked
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -设置视图
- (void)setupView {
    //设置导航栏标题
    self.title = @"我的订单";
    
    NSArray *titles = @[@"全部",@"待付款",@"待入住",@"待评价",@"已取消"];
    _headView = [[Xzb_MyorderHeadView alloc] initWithTitles:titles];
    _headView.size = CGSizeMake(ScreenWidth, 42);
    _headView.selectIndex = 0;
    @WeakObj(self)
    _headView.buttonSelect = ^(NSInteger index) {
        [selfWeak selectButton:index];
    };
    [self.view addSubview:_headView];
    
    _scrollView = [UIScrollView new];
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.pagingEnabled = YES;
    _scrollView.top = _headView.bottom;
    _scrollView.width = ScreenWidth;
    _scrollView.height = SCREEN_Height - 64 - 42;
    _scrollView.delegate = self;
    [self.view addSubview:_scrollView];
    _scrollView.contentSize = CGSizeMake(ScreenWidth * titles.count, 0);
    
    NSMutableArray *tempArr = [NSMutableArray arrayWithCapacity:titles.count];
    NSMutableArray *tempTableViewArr = [NSMutableArray arrayWithCapacity:titles.count];
    //给每个scrollView添加tableView
    for (int i = 0; i < titles.count; i++) {
        UITableView *tableview = [[UITableView alloc] initWithFrame:_scrollView.bounds style:UITableViewStylePlain];
        tableview.left = i * _scrollView.width;
        [self.scrollView addSubview:tableview];
        //初始化handler
        NSInteger type = 0;
        switch (i) {
            case 0:
                type = 0;
                break;
            case 1:
                type = 1;
                break;
            case 2:
                type = 2;
                break;
            case 3:
                type = 5;
                break;
            case 4:
                type = -1;
                break;
                
            default:
                break;
        }
        Xzb_myOrderHandler *handler = [[Xzb_myOrderHandler alloc] initWithTableView:tableview orderType:type];
        handler.navigationController = self.navigationController;
        handler.viewController = self;
        [tempArr addObject:handler];
        [tempTableViewArr addObject:tableview];
        if (i == 0) {
            [tableview.mj_header beginRefreshing];
        }
    }
    self.handlers = tempArr;
    self.tableViews = tempTableViewArr;
    
    
    UISwipeGestureRecognizer *rightSwipe = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(back)];
    [rightSwipe setDirection:UISwipeGestureRecognizerDirectionRight];
    [self.view addGestureRecognizer:rightSwipe];
    UISwipeGestureRecognizer *back = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(back)];
    [_scrollView addGestureRecognizer:back];
}
- (void)back{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)selectButton:(NSInteger )tag {
    [self.scrollView setContentOffset:CGPointMake(tag * self.scrollView.width, 0) animated:YES];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger index = floor(scrollView.contentOffset.x / scrollView.width);
    self.headView.selectIndex = index;
    [self refreshTableViewAnIndec:index];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    NSInteger index = floor(scrollView.contentOffset.x / scrollView.width);
    [self refreshTableViewAnIndec:index];
}

- (void)refreshTableViewAnIndec:(NSInteger )index
{
    if (index < self.handlers.count) {
        Xzb_myOrderHandler *handler = self.handlers[index];
        if (handler.dataArray.count == 0) {
            [handler beginRefresh];
        }
    }
}

@end
