//
//  Xzb_HotelDetailController.m
//  xzb
//
//  Created by 张荣廷 on 16/7/15.
//  Copyright © 2016年 xuwk. All rights reserved.
//

#import "Xzb_HotelDetailController.h"
#import <MapKit/MapKit.h>
#import "CXPhotoBrowser.h"
#import "STPhotoBrowserController.h"
#import "MJPhotoBrowser.h"
#import "MJPhoto.h"
#import "CXPhotoBrowser.h"
#import "HZPhotoBrowser.h"

#define IMAGE_HEIGHT 250
#define ONE_CELL_H 140
#define TWO_CELL_H 110
#define FOUR_CELL_H 50
#define HOVER_H ONE_CELL_H + TWO_CELL_H
#define HOVER_OFFSET_Y 186
#define LINE_W ScreenWidth /3

#define RoomTypeIntro @"房型介绍"
#define HotelFacilities @"酒店设施"
#define UserComment @"第一印象"

@interface Xzb_HotelDetailController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate,STPhotoBrowserDelegate,MJPhotoBrowserDelegate,HZPhotoBrowserDelegate>
@property (nonatomic,weak)  UIView *tipsView;
@property (nonatomic,weak)  UITableView *tableView;
/**
 *  酒店图片容器
 */
@property (nonatomic,weak)  UIScrollView *imageContentScrollView;
/**
 *  图片浏览器
 */
@property (nonatomic,strong) HZPhotoBrowser *roomTypeBrowser;
/**
 *  自定义导航条
 */
@property (nonatomic,weak)  UIView *navBGV;
/**
 *  自定义标题
 */
@property (nonatomic,weak)  UILabel *titleLabel;
/**
 *  酒店详情数据模型
 */
@property (nonatomic,strong) Xzb_HotelDetailModel *hotelModel;
/**
 *  酒店名称和遮盖
 */
@property (nonatomic,weak)  UIView *imageCover;
@property (nonatomic,weak)  UILabel *hotelNameLabel;
/**
 *  选择要被拉伸的imageview
 */
@property (nonatomic,strong)  UIImageView *zoomImageView;
@property (nonatomic,strong) STPhotoBrowserController *browserVc;
@property (nonatomic,strong)  UIView *pageSelectedBtnView;
@property (nonatomic,weak)  UIView *selectedLineView;
/**
 *  分页按钮
 */
@property (nonatomic,weak)  UIButton *selectedPageBtn;

@property (nonatomic,assign)  int index;
@property (nonatomic,assign)  CGFloat alpha;
@property (nonatomic,assign)  CGFloat cellHeight;
@property (nonatomic,assign)  CGFloat fourCellHeight;

/**
 *  酒店图片控件存放数组
 */
@property (nonatomic,strong) NSMutableArray *imageArray;
@property (nonatomic,strong) NSMutableArray *imageURLArray;
/**
 *  房型图片缓存数组
 */
@property (strong,nonatomic) NSMutableArray* imgs;
/**
 *  房型图文数据数组
 */
@property (strong,nonatomic) NSMutableArray* roomTypeImagesArray;
/**
 *  悬浮导航条数组
 */
@property (strong,nonatomic) NSMutableArray* pageBtnArray;
/**
 *  房型图文数据数组
 */
@property (strong,nonatomic) NSMutableArray* contentImageDataArray;
/**
 *  用户评论数据数组
 */
@property (strong,nonatomic) NSMutableArray* userCommentDataArray;

/**
 *  记录用户滚动位置的Y值
 */
@property (nonatomic,assign)  CGFloat onePageOffsetY;
@property (nonatomic,assign)  CGFloat twoPageOffsetY;
@property (nonatomic,assign)  CGFloat threePageOffsetY;
@property (nonatomic,assign)  CGFloat tempY;

@property (nonatomic,assign)  int commentPage;
@property (nonatomic,assign)  int commentLimit;
@property (nonatomic,assign)  int commentStart;
/**
 *  地图导航
 */
@property (nonatomic, strong) CLGeocoder *geocoder;

@property (nonatomic, strong) MKPlacemark *sourceMKPm;
@property (nonatomic, strong) MKPlacemark *destinationMKPm;
@property (nonatomic, strong) CLLocation *sourcePm;
@property (nonatomic, strong) CLLocation *destinationPm;
/**
 *  判断页面是否从下往上弹出控制器
 */
@property (nonatomic,assign)  BOOL isPresent;
@property (nonatomic,assign)  int hoverH;
@property (nonatomic,assign)  int hoverOffsetH;
@end

@implementation Xzb_HotelDetailController
- (NSMutableArray *)imageURLArray
{
    if (_imageURLArray == nil) {
        _imageURLArray = [NSMutableArray array];
    }
    return _imageURLArray;
}
- (NSMutableArray *)contentImageDataArray
{
    if (_contentImageDataArray == nil) {
        _contentImageDataArray = [NSMutableArray array];
    }
    return _contentImageDataArray;
}
- (NSMutableArray *)userCommentDataArray
{
    if (_userCommentDataArray == nil) {
        _userCommentDataArray = [NSMutableArray array];
    }
    return _userCommentDataArray;
}
- (NSMutableArray *)pageBtnArray
{
    if (_pageBtnArray == nil) {
        _pageBtnArray = [NSMutableArray array];
    }
    return _pageBtnArray;
}
- (UIView *)pageSelectedBtnView
{
    if (_pageSelectedBtnView == nil) {
        _pageSelectedBtnView = [[UIView alloc] init];
        _pageSelectedBtnView.backgroundColor = [UIColor whiteColor];
        for (int i = 0; i<3; i++) {
            UIButton *pageBtn = [[UIButton alloc] init];
            pageBtn.frame = CGRectMake((ScreenWidth /3) * i, 0, (ScreenWidth /3), 49);
            pageBtn.tag = i;
            [pageBtn setTitleColor:AppMainGrayTextColor forState:UIControlStateNormal];
            pageBtn.titleLabel.font = [UIFont systemFontOfSize:15];
            [pageBtn addTarget:self action:@selector(pageBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
            [_pageSelectedBtnView addSubview:pageBtn];
            [self.pageBtnArray addObject:pageBtn];
            if (i == 0) {
                self.selectedPageBtn = pageBtn;
                [pageBtn setTitle:RoomTypeIntro forState:UIControlStateNormal];
            }else if (i == 1)
            {
                [pageBtn setTitle:HotelFacilities forState:UIControlStateNormal];
            }else
            {
                [pageBtn setTitle:UserComment forState:UIControlStateNormal];
            }
        }
        
        //设置指示的线
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 47, LINE_W, 2)];
        lineView.backgroundColor = AppMainColor;
        [_pageSelectedBtnView addSubview:lineView];
        self.selectedLineView = lineView;
        
        UIView *devider = [[UIView alloc] initWithFrame:CGRectMake(0, 48.5, ScreenWidth, 0.5)];
        devider.backgroundColor = AppLineColor;
        [_pageSelectedBtnView addSubview:devider];
    }
    return _pageSelectedBtnView;
}

#pragma mark - 分页按钮点击
- (void)pageBtnClicked:(UIButton *)button
{
    //设置选择按钮
    if ([self.selectedPageBtn isEqual:button]) {
        return;
    }
    self.selectedPageBtn.selected = NO;
    button.selected = YES;
    self.selectedPageBtn = button;
    
    //判断选择按钮
    if (button.tag == 0) {
        [self.tipsView removeFromSuperview];
        self.tableView.mj_footer.hidden = YES;
        
        [self.tableView reloadData];//刷新列表数据
        NSLog(@"%f",self.tableView.contentSize.height);
        self.selectedLineView.x = 0;
        if (self.onePageOffsetY >= self.hoverH ) {
            [self.tableView setContentOffset:CGPointMake(0, self.onePageOffsetY) animated:NO];
        }else
        {
            [self.tableView setContentOffset:CGPointMake(0, self.hoverOffsetH) animated:YES];
        }
    }else if (button.tag == 1) {
        [self.tipsView removeFromSuperview];
        self.tableView.mj_footer.hidden = YES;
        [self.tableView reloadData];//刷新列表数据
        NSLog(@"%f",self.tableView.contentSize.height);
        self.selectedLineView.x = LINE_W;
        [self.tableView setContentOffset:CGPointMake(0, self.hoverOffsetH) animated:YES];
    }else if (button.tag == 2) {
        self.tableView.mj_footer.hidden = NO;
        
        CGFloat tempY = self.threePageOffsetY;
        self.tempY = tempY;
        self.selectedLineView.x = LINE_W * 2;
        [self.tableView reloadData];//刷新列表数据
        NSLog(@"%f",self.tableView.contentSize.height);
        
        if (self.userCommentDataArray.count == 0) {
            UIView *tipsView = [[UIView alloc] init];
            tipsView.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
            tipsView.backgroundColor = [UIColor clearColor];
            tipsView.userInteractionEnabled = NO;
            [self.tableView insertSubview:tipsView aboveSubview:self.tableView];
            self.tipsView = tipsView;
            
            UIImageView *tipsImageView = [[UIImageView alloc] init];
            tipsImageView.frame = CGRectMake(0, SCREEN_Height * 0.7, ScreenWidth, 100);
            tipsImageView.image = [UIImage imageNamed:@"登录-logo"];
            tipsImageView.contentMode = UIViewContentModeCenter;
            [tipsView addSubview:tipsImageView];
            
            UILabel *tipsLabel = [[UILabel alloc] init];
            tipsLabel.text = @"暂无评论~";
            tipsLabel.textAlignment = NSTextAlignmentCenter;
            tipsLabel.textColor = [UIColor lightGrayColor];
            tipsLabel.frame = CGRectMake(0, CGRectGetMaxY(tipsImageView.frame) + 10, SCREEN_Width, 30);
            tipsLabel.font = [UIFont systemFontOfSize:15];
            [tipsView addSubview:tipsLabel];
        }

        if (tempY > self.hoverH) {
            [self.tableView setContentOffset:CGPointMake(0, tempY) animated:NO];
        }else
        {
            [self.tableView setContentOffset:CGPointMake(0, self.hoverOffsetH) animated:YES];
        }
        
    }
}
- (NSMutableArray *)imgs
{
    if (_imgs == nil) {
        _imgs = [NSMutableArray array];
    }
    return _imgs;
}
- (NSMutableArray *)roomTypeImagesArray
{
    if (_roomTypeImagesArray == nil) {
        _roomTypeImagesArray = [NSMutableArray array];
    }
    return _roomTypeImagesArray;
}
- (NSMutableArray *)imageArray
{
    if (_imageArray == nil) {
        _imageArray = [NSMutableArray array];
    }
    return _imageArray;
}
#pragma mark - viewWill....
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    self.imageContentScrollView.contentSize = CGSizeMake(self.view.width * self.imageArray.count, IMAGE_HEIGHT);
    if (_isComment) {
        [self pageBtnClicked:self.pageBtnArray[2]];
    }
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.isPresent = NO;
    
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    //设置导航栏的透明度;
    self.navBGV.alpha = self.alpha;
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    if (!self.isPresent) {
        [self.navigationController setNavigationBarHidden:NO animated:animated];
    }
    //设置导航栏背景色
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:AppMainColor] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage =[UIImage imageWithColor:AppMainColor];
    //移除通知
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)setupNavBar
{
    UIView *navBGV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 64)];
    navBGV.backgroundColor = AppMainColor;
    [self.view addSubview:navBGV];
    self.navBGV = navBGV;
    
    UIButton *backBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 20, 44, 44)];
    [backBtn setImage:[UIImage imageNamed:@"返回"] forState:UIControlStateNormal];
    backBtn.imageView.contentMode = UIViewContentModeCenter;
    [backBtn addTarget:self action:@selector(back_clicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view insertSubview:backBtn aboveSubview:navBGV];
    
    UIButton *shareBtn = [[UIButton alloc] initWithFrame:CGRectMake(ScreenWidth - 44, 20, 44, 44)];
    [shareBtn setImage:[UIImage imageNamed:@"分享"] forState:UIControlStateNormal];
    shareBtn.imageView.contentMode = UIViewContentModeCenter;
    [shareBtn addTarget:self action:@selector(shareBtn_clicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view insertSubview:shareBtn aboveSubview:shareBtn];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, ScreenWidth, 44)];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.font = [UIFont systemFontOfSize:20];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = @"";
    [self.navBGV insertSubview:titleLabel aboveSubview:navBGV];
    self.titleLabel = titleLabel;
}
/**
 *  酒店详情分享
 */
#pragma mark - 微信分享
- (void)shareBtn_clicked
{
    PhotoLibraryView *view = [[PhotoLibraryView alloc] init];
    [view.buttonOne setTitle:@"分享到朋友圈" forState:UIControlStateNormal];
    [view.buttonOne setTitleColor:Color(68, 68, 68) forState:UIControlStateNormal];
    [view.buttonTwo setTitle:@"分享给微信好友" forState:UIControlStateNormal];
    [view.buttonTwo setTitleColor:Color(68, 68, 68) forState:UIControlStateNormal];
    [view.cancle setTitleColor:Color(68, 68, 68) forState:UIControlStateNormal];
    __weak typeof(view) weakView = view;
    @WeakObj(self)
    view.PhotoOption = ^{
        [weakView coverClick];
        //分享朋友圈
        [selfWeak weixinShareWithTimeline:YES];
    };
    view.LibraryOption = ^{
        //分享微信好友
        [selfWeak weixinShareWithTimeline:NO];
    };
    [view show];

}
- (void)weixinShareWithTimeline:(BOOL)timeline
{
//    NSString *contentString = @"【五折返现，入住即返】开学季，疯狂五折酒店预订不用抢！返现，我们是认真的！"; // 分享到朋友圈的
//    NSString *contents = @"【五折返现，入住即返】开学季，疯狂五折酒店预订不用抢！返现，我们是认真的！"; // 分享到好友的
//    if (!timeline) {
//        [UMSocialData defaultData].extConfig.wechatSessionData.url = @"http://www.chinaxzb.com/static/down.htm";
//        [UMSocialData defaultData].extConfig.wechatSessionData.title = @"瞎找呗";
//        [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[UMShareToWechatSession] content:contents image:[UIImage imageNamed:@"Icon.png"] location:nil urlResource:nil presentedController:self completion:^(UMSocialResponseEntity *shareResponse){
//            if (shareResponse.responseCode == UMSResponseCodeSuccess) {
//                NSLog(@"分享成功！");
//                [self alertWithStr:@"分享成功！"];
//            }else
//            {
//                [self alertWithStr:@"分享失败！"];
//            }
//        }];
//    }
//    else{
//        [UMSocialData defaultData].extConfig.wechatTimelineData.url = @"http://www.chinaxzb.com/static/down.htm";
//        [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[UMShareToWechatTimeline] content:contentString image:[UIImage imageNamed:@"Icon.png"] location:nil urlResource:nil presentedController:self completion:^(UMSocialResponseEntity *shareResponse){
//            if (shareResponse.responseCode == UMSResponseCodeSuccess) {
//                NSLog(@"分享成功！");
//                [self alertWithStr:@"分享成功！"];
//            }else
//            {
//                [self alertWithStr:@"分享失败！"];
//            }
//        }];
//    }
}
- (void)alertWithStr:(NSString *)string
{
    NSString *alertViewCtr_str = string;
    
    //弹窗提示
    DQAlertView * alertView = [[DQAlertView alloc] initWithTitle:@"分享结果" message:alertViewCtr_str delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
    [alertView.otherButton setTitleColor:AppMainColor forState:UIControlStateNormal];
    [alertView show];}

- (void)back_clicked
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)initTableViewCell
{
    [_tableView registerNib:[UINib nibWithNibName:[HotelIntroTableViewCell ID] bundle:nil] forCellReuseIdentifier:[HotelIntroTableViewCell ID]];
}
#pragma mark - viewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITableView *moreTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - 49) style:UITableViewStylePlain];
    moreTableView.delegate = self;
    moreTableView.dataSource = self;
    moreTableView.scrollsToTop = YES;
    moreTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    moreTableView.contentInset = UIEdgeInsetsMake(IMAGE_HEIGHT - 20, 0, 0, 0);
    [self.view addSubview:moreTableView];
    self.tableView = moreTableView;
    
    @WeakObj(self);
    
    self.tableView.mj_footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
        if (selfWeak.selectedPageBtn.tag == 2){
            [selfWeak setupUserComment];
        }
    }];
    self.tableView.mj_footer.hidden = YES;
    //初始化cell
    [self initTableViewCell];
    
    //设置自定义导航栏
    [self setupNavBar];
    
    [self.tableView addSubview:self.pageSelectedBtnView];
    
    //设置头部的图片轮播器Header
    [self setupImageScrollView:moreTableView];
    
    self.index = 0;
    self.alpha = 0;
    self.onePageOffsetY = 0;
    self.twoPageOffsetY = 0;
    self.threePageOffsetY = 0;
    self.fourCellHeight = 60;
    self.commentLimit = 10;
    
    //预加载用户评论cell，防止点击用户评论出现重布局tableview 清空contentoffset
    self.selectedPageBtn = self.pageBtnArray[2];
    [self.tableView reloadData];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        //刷新完成
        self.selectedPageBtn = self.pageBtnArray[0];
        [self.tableView reloadData];
    });
    
    
    //通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(twoCellBtnClicked:) name:HotelDetailTwoCellBtnClickedNotification object:nil];
    
    [self setupHotelDetailData];
}
- (void)setupUserComment
{
    UserAccount *account = [UserAccountTool account];
    NSDictionary *param = @{USERID:account.userId,TOKEN:account.loginToken,@"businessId":self.hotelModel.businessId,@"limit":@(self.commentLimit),@"start":@(self.commentStart),@"page":@(self.commentPage)};
    RTLog(@"%@",param);
    @WeakObj(self)
    [RTHttpTool get:GET_SELECTLIST_FOR_MOBILE addHUD:NO param:param success:^(id responseObj) {
        id json = [RTHttpTool jsonWithResponseObj:responseObj];
        NSLog(@"酒店详情数据:%@",json);
        if ([json[SUCCESS] intValue] == 1) {
            if (selfWeak.commentPage == 0) {
                NSArray *array = [UserCommentModel mj_objectArrayWithKeyValuesArray:responseObj[ENTITIES][@"commentInfos"]];
                selfWeak.userCommentDataArray = [selfWeak userCommentFrameModelArrayWithUserCommentModelArray:array];
                if (selfWeak.userCommentDataArray.count < selfWeak.commentLimit || [json[@"totalPage"] intValue] == 1) {
                    [selfWeak.tableView.mj_footer endRefreshingWithNoMoreData];
                }else{
                    [selfWeak.tableView.mj_footer resetNoMoreData];
                    selfWeak.commentPage += 1;
                    selfWeak.commentStart = selfWeak.commentPage * selfWeak.commentLimit;
                }
            }else{
                NSArray *array = [UserCommentModel mj_objectArrayWithKeyValuesArray:responseObj[ENTITIES][@"commentInfos"]];
                NSArray *frameArray = [self userCommentFrameModelArrayWithUserCommentModelArray:array];
                selfWeak.commentPage += 1;
                selfWeak.commentStart = selfWeak.commentPage * selfWeak.commentLimit;
                if (array.count < selfWeak.commentLimit) {
                    [selfWeak.tableView.mj_footer endRefreshingWithNoMoreData];
//                    [[Toast makeText:@"没有更多数据"]show];
                }else{
                    [selfWeak.tableView.mj_footer resetNoMoreData];
                    selfWeak.commentPage += 1;
                    selfWeak.commentStart = selfWeak.commentPage * selfWeak.commentLimit;
                }
                [selfWeak.userCommentDataArray addObjectsFromArray:frameArray];
                
                [selfWeak.tableView reloadData];
                [selfWeak.tableView.mj_footer endRefreshing];
            }
            if (selfWeak.userCommentDataArray.count != 0) {
                [selfWeak.tipsView removeFromSuperview];
            }
        }
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];

}
/**
 *  转换评论模型数据为frame模型数据
 */
- (NSMutableArray *)userCommentFrameModelArrayWithUserCommentModelArray:(NSArray *)array
{
    NSMutableArray *dataArray = [NSMutableArray array];
    for (UserCommentModel *model in array) {
        Xzb_UserCommentFrameModel *frameModel = [[Xzb_UserCommentFrameModel alloc] init];
        frameModel.model = model;
        [dataArray addObject:frameModel];
    }
    return dataArray;
}

/**
 *  设置酒店详情数据
 */
- (void)setupHotelDetailData
{
    UserAccount *account = [UserAccountTool account];
    [RTHttpTool get:GET_BY_D_TO_ID addHUD:YES param:@{USERID:account.userId,TOKEN:account.loginToken,ORDERID:self.orderRelID?self.orderRelID:self.orderID,@"comeFrom":self.orderRelID?@"orderRela":@"order"} success:^(id responseObj) {
        NSLog(@"酒店详情数据:%@",responseObj);
        if ([responseObj[SUCCESS] intValue] == 1) {
            //转换成模型数据
            Xzb_HotelDetailModel *model = [Xzb_HotelDetailModel mj_objectWithKeyValues:responseObj[ENTITIES][@"orderBusinessRela"]];
            self.hotelModel = model;
            self.roomTypeImagesArray = self.hotelModel.roomPhotoArray;
            
            //设置底部工具条
            if (!self.orderID) {
                [self setupSubView];
            }else{
                self.tableView.height = ScreenHeight;
            }
            
            //酒店地址
            CGSize addressSize = [model.location boundingRectWithSize:CGSizeMake(ScreenWidth - 20 - 50, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size;
            
            self.hoverH = HOVER_H + addressSize.height * 0.5;
            self.hoverOffsetH = HOVER_OFFSET_Y + addressSize.height * 0.5;
            
            //添加悬停分页控件的view
            self.pageSelectedBtnView.frame = CGRectMake(0, self.hoverH, ScreenWidth, FOUR_CELL_H);
            
            //获取店铺位置
            [self setupdestinationPm];
            
            //设置用户评论数据
            [self setupUserComment];
            
            //设置酒店名称
            self.hotelNameLabel.text = model.businessName;
            self.titleLabel.text = self.hotelNameLabel.text;
            
            //设置酒店图片
            [self setupHeadScrollViewImageWithModel:model];
            
            //预加载房型介绍图片
            [self setupImageData];
            
            [self.tableView reloadData];
        }
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}
#pragma mark - 设置头部轮播图片
- (void)setupHeadScrollViewImageWithModel:(Xzb_HotelDetailModel *)model
{
    NSArray *imageArray = (NSMutableArray *)[model.businessPhoto componentsSeparatedByString:@","];
    
    if (imageArray.count != 0) {
        for (NSString *string in imageArray) {
            Xzb_PhotoModel *model = [[Xzb_PhotoModel alloc] init];
            model.photoUrl = string;
            [self.imageURLArray addObject:model];
        }
        
        for (int i = 0; i<self.imageURLArray.count; i++) {
            Xzb_PhotoModel *model = self.imageURLArray[i];
            RTLog(@"photoUrl---%@",model.photoUrl);
            UITapGestureRecognizer *imageTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageTap:)];
            
            UIImageView *zoomImageView = [[UIImageView alloc]initWithFrame:CGRectMake(i * ScreenWidth, 0, self.view.width, IMAGE_HEIGHT)];
            zoomImageView.clipsToBounds = YES;
            zoomImageView.tag = i;
            zoomImageView.contentMode = UIViewContentModeScaleAspectFill;
            zoomImageView.userInteractionEnabled = YES;
            [self.imageContentScrollView addSubview:zoomImageView];
            [zoomImageView addGestureRecognizer:imageTap];
            [self.imageArray addObject:zoomImageView];
            
            [zoomImageView sd_setImageWithURL:[NSURL URLWithString:model.photoUrl] placeholderImage:[UIImage imageNamed:@"1"]];
        }
        
    }
}
- (void)twoCellBtnClicked:(NSNotification *)note
{
    NSDictionary *dict = note.userInfo;
    if ([dict[@"buttonTag"] integerValue] == 10) {//点击酒店介绍
        HotelIntroView *hotelIntro = [[HotelIntroView alloc] init];
        hotelIntro.hotelModel = self.hotelModel;
        [hotelIntro show];
    }else if ([dict[@"buttonTag"] integerValue] == 11){//点击地图导航
        [self navigationClick];
    }else{//在住宿友
        if (self.hotelModel) {
            OnlineFriendsView *onlineFriends = [[OnlineFriendsView alloc] init];
            onlineFriends.businessID = self.hotelModel.businessId;
            onlineFriends.checkinDateString = [self.hotelModel.checkinDate substringToIndex:10];
            [onlineFriends show];

        }
    }
}

- (void)setupImageScrollView:(UITableView *)tableView
{
    UIScrollView *imageContentScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, -IMAGE_HEIGHT, self.view.width, IMAGE_HEIGHT)];
    imageContentScrollView.scrollsToTop = NO;
    imageContentScrollView.delegate = self;
    imageContentScrollView.scrollEnabled = YES;
    imageContentScrollView.pagingEnabled = YES;
    imageContentScrollView.showsHorizontalScrollIndicator = NO;
    [tableView addSubview:imageContentScrollView];
    self.imageContentScrollView = imageContentScrollView;
    
    //设置酒店名称的view
    UIView *imageCover = [[UIView alloc] init];
    imageCover.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    imageCover.frame = CGRectMake(0, -40, SCREEN_Width, 40);
    [tableView addSubview:imageCover];
    self.imageCover = imageCover;
    
    UILabel *hotelNameLabel = [[UILabel alloc] init];
    hotelNameLabel.frame = CGRectMake(10, 0, SCREEN_Width - 20, imageCover.height);
    hotelNameLabel.text = @"";
    hotelNameLabel.textColor = [UIColor whiteColor];
    hotelNameLabel.textAlignment = NSTextAlignmentLeft;
    hotelNameLabel.font = [UIFont systemFontOfSize:17];
    [imageCover addSubview:hotelNameLabel];
    self.hotelNameLabel = hotelNameLabel;
}

- (void)setupSubView
{
    UIView *bottomBar = [[UIView alloc] init];
    bottomBar.backgroundColor = [UIColor whiteColor];
    bottomBar.frame = CGRectMake(0, SCREEN_Height - 49, SCREEN_Width, 49);
    [self.view addSubview:bottomBar];
    //区别全日房和钟点房
    NSString *hourTime = @"";
    if ([self.hotelModel.orderType intValue] == 1) {
        hourTime = @"晚";
    }else if ([self.hotelModel.orderType intValue] == 2)
    {
        //钟点房显示时间
        if ([self.hotelModel.timePeriod intValue] == 1) {
            hourTime = @"3小时";
        }else if ([self.hotelModel.timePeriod intValue] == 2){
            hourTime = @"4小时";
        }else if ([self.hotelModel.timePeriod intValue] == 3){
            hourTime = @"5小时";
        }
        
    }
    //酒店报价
    NSString *text = [NSString stringWithFormat:@"¥%@/%@",self.hotelModel.price,hourTime];
    
    UILabel *unitPriceLabel = [[UILabel alloc] init];
    unitPriceLabel.text = text;
    unitPriceLabel.backgroundColor = [UIColor blackColor];
    unitPriceLabel.textColor = [UIColor whiteColor];
    unitPriceLabel.textAlignment = NSTextAlignmentCenter;
    unitPriceLabel.font = [UIFont systemFontOfSize:17];
    unitPriceLabel.frame = CGRectMake(0, 0, SCREEN_Width * 0.5, 49);
    [bottomBar addSubview:unitPriceLabel];
    
    //预订按钮
    UIButton *scheduledButton = [[UIButton alloc] init];
    scheduledButton.frame = CGRectMake(SCREEN_Width * 0.5, 0, ScreenWidth * 0.5, 49);
    scheduledButton.backgroundColor = AppMainColor;
    [scheduledButton setTitle:@"预订" forState:UIControlStateNormal];
    [scheduledButton addTarget:self action:@selector(scheduledClicked) forControlEvents:UIControlEventTouchUpInside];
    [bottomBar addSubview:scheduledButton];
}
/**
 *  预订按钮点击
 */
- (void)scheduledClicked
{
    if ([self.model.seconds intValue] <= 0) {
        [[Toast makeText:@"该订单报价已经失效~"] show];
        return;
    }
    Xzb_FillOrderViewController *fillOrder = [[Xzb_FillOrderViewController alloc] init];
    fillOrder.hotelModel = self.hotelModel;
    fillOrder.offerModel = self.model;
    [self.navigationController pushViewController:fillOrder animated:YES];
}
#pragma mark - 启动图片浏览器
- (void)imageTap:(UIGestureRecognizer *)gesture
{
    UIImageView *tapImageView = (UIImageView *)gesture.view;
    
    // 1.封装图片数据
//    NSMutableArray *myphotos = [NSMutableArray array];
//    for (int i = 0; i<self.imageURLArray.count; i++) {
//        // 一个MJPhoto对应一张显示的图片
//        MJPhoto *mjphoto = [[MJPhoto alloc] init];
//        
//        mjphoto.srcImageView = self.imageArray[i]; // 来源于哪个UIImageView
//        ;
//        Xzb_PhotoModel *photoModel = self.imageURLArray[i];
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
    browser.sourceImagesContainerView = self.imageContentScrollView; // 原图的父控件
    browser.imageCount =  self.imageArray.count; // 图片总数
    browser.currentImageIndex = (int)tapImageView.tag;
    browser.delegate = self;
    [browser show];
    
}
#pragma mark - photobrowser代理方法

// 返回临时占位图片（即原来的小图）
- (UIImage *)photoBrowser:(HZPhotoBrowser *)browser placeholderImageForIndex:(NSInteger)index
{
    UIImageView *view = self.imageArray[index];
    return view.image;
}
// 返回高质量图片的url
- (NSURL *)photoBrowser:(HZPhotoBrowser *)browser highQualityImageURLForIndex:(NSInteger)index
{
    Xzb_PhotoModel *photoModel = self.imageURLArray[index];
    NSString *urlStr = photoModel.photoUrl;
    return [NSURL URLWithString:urlStr];
}
#pragma mark - 设置缓存图片
/**
 *  设置缓存图片，获取图片宽高计算cell高度
 */
- (void)setupImageData
{
    for (int index=0;index<self.roomTypeImagesArray.count;index++) {
        Xzb_PhotoModel *model = self.roomTypeImagesArray[index];
        RTLog(@"index --- %@",model.photoUrl);
        NSMutableDictionary* dict = [@{@"url":model.photoUrl} mutableCopy];
        [self.imgs addObject:dict];
        if([[SDWebImageManager sharedManager] cachedImageExistsForURL:[NSURL URLWithString:model.photoUrl]]){
            NSMutableDictionary* dict = self.imgs[index];
            UIImage* img = [[SDWebImageManager sharedManager].imageCache imageFromMemoryCacheForKey:[[SDWebImageManager sharedManager] cacheKeyForURL:[NSURL URLWithString:model.photoUrl]]];
            
            if(!img)
                img = [[SDWebImageManager sharedManager].imageCache imageFromDiskCacheForKey:[[SDWebImageManager sharedManager] cacheKeyForURL:[NSURL URLWithString:model.photoUrl]]];
            
            [dict setObject:img forKey:@"img"];
            
        }else{
            
            [[SDWebImageManager sharedManager] downloadImageWithURL:[NSURL URLWithString:model.photoUrl] options:SDWebImageRetryFailed|SDWebImageLowPriority progress:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
                if (image) {
                    if(index <self.imgs.count){
                        NSMutableDictionary* dict = self.imgs[index];
                        [dict setObject:image forKey:@"img"];
                        [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:index inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
                    }
                }
            }];
        }
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark -TableView Delegate and Datasource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.selectedPageBtn.tag == 0) {
        if (self.roomTypeImagesArray.count > 1) {
            return 4+self.roomTypeImagesArray.count;
        }
        return 4 + 2;
    }else if (self.selectedPageBtn.tag == 1) {
        return 4;
    }else if (self.selectedPageBtn.tag == 2) {
        if (self.userCommentDataArray.count > 5) {
            return 4+self.userCommentDataArray.count;
        }else{
            return 4+6;
        }
    }

    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0){
        if (self.hotelModel) {
            CGSize addressSize = [self.hotelModel.location boundingRectWithSize:CGSizeMake(ScreenWidth - 20 - 50, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size;
            return ONE_CELL_H + addressSize.height * 0.5;
        }else{
            return ONE_CELL_H;
        }
    }else if (indexPath.row == 1){
        return TWO_CELL_H;
    }else if (indexPath.row == 2){
        return FOUR_CELL_H;
    }else if (indexPath.row == 3){//分页导航条下面的cell对应不同页面
        if (self.selectedPageBtn.tag == 0) {
            return self.fourCellHeight + 30;
        }else if (self.selectedPageBtn.tag == 1) {
            return 600;
        }else if (self.selectedPageBtn.tag == 2) {
            return 50;
        }
        return FOUR_CELL_H;
    }else{
        if (self.selectedPageBtn.tag == 0) {
            NSInteger index = indexPath.row-4;
            if(index<_imgs.count){
                
                NSDictionary* dict = _imgs[index];
                if([dict[@"img"] isKindOfClass:[UIImage class]]){
                    UIImage* img = dict[@"img"];
                    return img.size.height/img.size.width*tableView.mj_w > 100?img.size.height/img.size.width*tableView.mj_w:200;//返回图片的高度加上文字内容的高度加上间隔
                }else{
                    
                }
            }
            return 200;
        }else if (self.selectedPageBtn.tag == 1) {
            return 300;
        }else if (self.selectedPageBtn.tag == 2) {
            NSInteger index = indexPath.row-4;
            if (index<self.userCommentDataArray.count) {
                Xzb_UserCommentFrameModel *model = self.userCommentDataArray[index];
                return model.cellHeight;
            }

            return 88;
        }
        return 0;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0){
        OneTableViewCell *cell = [OneTableViewCell cellWithTableView:tableView];
        cell.model = self.hotelModel;
        return cell;
    }else if (indexPath.row == 1)
    {
        TwoTableViewCell *cell = [TwoTableViewCell cellWithTableView:tableView];
        return cell;
    }else if (indexPath.row == 3){
        if (self.selectedPageBtn.tag == 0) {
            PageTypeTableViewCell *cell = [PageTypeTableViewCell cellWithTableView:tableView];
            self.fourCellHeight = cell.cellHeight;
            cell.model = self.hotelModel;
            return cell;
        }else if (self.selectedPageBtn.tag == 1) {
            PageTypeTwoTableViewCell *cell = [PageTypeTwoTableViewCell cellWithTableView:tableView];
            if (self.hotelModel) {
                cell.businessFacilities = self.hotelModel.businessFacilities;
            }
            return cell;
        }else if (self.selectedPageBtn.tag == 2) {
            PageTypeThreeTableViewCell *cell = [PageTypeThreeTableViewCell cellWithTableView:tableView];
            cell.model = self.hotelModel;
            //好评率
            cell.rateLabel.text = [NSString stringWithFormat:@"好评率%@%%",self.hotelModel.rank];
            return cell;
        }
    }else if (indexPath.row > 3){
        if (self.selectedPageBtn.tag == 0) {//房型介绍
            
            HotelIntroTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[HotelIntroTableViewCell ID] forIndexPath:indexPath];
        
            cell.bottomConstraint.constant = 10;//设置为label内容的高度加上间隔
            cell.content.y = 0;//设置内容label的y值
            cell.content.height = 0;//设置内容label的高度
            
            NSInteger index = indexPath.row-4;
            if(index<_imgs.count){
                
                NSDictionary* dict = _imgs[index];
                if(([dict[@"img"] isKindOfClass:[UIImage class]])){
//                    cell.contentImageView.image = dict[@"img"];
                    UITapGestureRecognizer *imageTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(introImageTap:)];
                    [cell.contentImageView addGestureRecognizer:imageTap];
                    cell.contentImageView.tag = index;
                }else{
                    //placeholderImage
//                    cell.contentImageView.image = [UIImage imageNamed:@"1"];
                }
                
            }
            if (self.roomTypeImagesArray.count>index) {
                Xzb_PhotoModel *model = self.roomTypeImagesArray[index];
                RTLog(@"%@",model.photoUrl);
                [cell.contentImageView sd_setImageWithURL:[NSURL URLWithString:model.photoUrl] placeholderImage:[UIImage imageNamed:@"1"]];
            }

            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }else if (self.selectedPageBtn.tag == 2) {//用户评论
            UserCommentTableViewCell *cell = [UserCommentTableViewCell cellWithTableView:tableView];
            
            NSInteger index = indexPath.row-4;
            if (index<self.userCommentDataArray.count) {
                Xzb_UserCommentFrameModel *model = self.userCommentDataArray[index];
                cell.model = model;
                for(UIView *view in [cell.contentView subviews])
                {
                    view.hidden = NO;
                }
            }else
            {
                for(UIView *view in [cell.contentView subviews])
                {
                    view.hidden = YES;
                }
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
        UITableViewCell *cell;
        cell =[tableView dequeueReusableCellWithIdentifier:@"datacell"];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"datacell"];
        }
        cell.textLabel.text = [NSString stringWithFormat:@"测试数据-----%ld",(long)indexPath.row];
        return cell;
    }
    
    UITableViewCell *cell;
    cell =[tableView dequeueReusableCellWithIdentifier:@"datacell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"datacell"];
    }
    return cell;
}
#pragma mark - 图片浏览器
- (void)introImageTap:(UIGestureRecognizer *)gesture
{
    UIImageView *tapImageView = (UIImageView *)gesture.view;
    
    // 1.封装图片数据
    NSMutableArray *myphotos = [NSMutableArray array];
    
    NSArray *array = [self.hotelModel.roomPhoto componentsSeparatedByString:@","];
    
    for (int i = 0; i<array.count; i++) {
        // 一个MJPhoto对应一张显示的图片
        MJPhoto *mjphoto = [[MJPhoto alloc] init];
        
        mjphoto.srcImageView = (UIImageView *)gesture.view; // 来源于哪个UIImageView
        ;
        Xzb_PhotoModel *photoModel = [[Xzb_PhotoModel alloc] init];
        photoModel.photoUrl = array[i];
        
        mjphoto.url = [NSURL URLWithString:photoModel.photoUrl]; // 图片路径
        
        [myphotos addObject:mjphoto];
    }
    
    // 2.显示相册
    MJPhotoBrowser *browser = [[MJPhotoBrowser alloc] init];
    browser.delegate = self;
    browser.currentPhotoIndex = tapImageView.tag; // 弹出相册时显示的第一张图片是？
    browser.photos = myphotos; // 设置所有的图片
    [browser show];
}

#pragma mark - UIScrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    CGFloat y = scrollView.contentOffset.y; //如果有导航控制器，这里应该加上导航控制器的高度64
    //计算滚动到第几张图片
    CGFloat x = scrollView.contentOffset.x;
    if ([scrollView isEqual:self.imageContentScrollView]) {
        self.index = x/ScreenWidth;
    }
    
    RTLog(@"scrollViewy  %f",y);
    
    if ([scrollView isEqual:self.tableView]) {
        if (y == self.hoverOffsetH || y == self.onePageOffsetY || self.tempY == y) {
            //设置导航栏的背景颜色，透明状态值
            UIColor *color = [UIColor colorWithRed:247/255.0 green:36/255.0 blue:96/255.0 alpha:1];
            [self.navigationController.navigationBar cnSetBackgroundColor:[color colorWithAlphaComponent:1]];
            self.navBGV.alpha = 1.0;
        }
        
        if (y<0) {//实现页面滚动导航栏透明度变化效果
            self.alpha = (1-y/(-IMAGE_HEIGHT))+(1-y/(-IMAGE_HEIGHT));
            if (self.alpha > 1.0) {
                self.alpha = 1.0;
            }
            //设置导航栏的背景颜色，透明状态值
            self.navBGV.alpha = self.alpha;
        }
        
        if (y< -IMAGE_HEIGHT) {//实现图片拉伸放大效果
            CGRect scrollViewframe = self.imageContentScrollView.frame;
            scrollViewframe.origin.y = y;
            scrollViewframe.size.height = -y;
            self.imageContentScrollView.frame = scrollViewframe;
            if (self.imageArray.count == 0) {
                return;
            }
            UIImageView *zoomImageView = self.imageArray[self.index];
            CGRect frame = zoomImageView.frame;
            frame.size.height = -y;
            zoomImageView.frame = frame;
        }
        
        //选择分页按钮悬停效果
        if (y>self.hoverOffsetH) {
            //悬停导航栏位置，值为64
            self.pageSelectedBtnView.frame = CGRectMake(0,y + 64, ScreenWidth, FOUR_CELL_H);
        }else
        {
            self.pageSelectedBtnView.frame = CGRectMake(0,self.hoverH, ScreenWidth, FOUR_CELL_H);
        }
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    CGFloat y = scrollView.contentOffset.y;
    if (self.selectedPageBtn.tag == 0) {
        self.onePageOffsetY = y;
    }else if (self.selectedPageBtn.tag == 1)
    {
        self.twoPageOffsetY = y;
    }else if (self.selectedPageBtn.tag == 2){
        self.threePageOffsetY = y;
    }
}
#pragma mark - 地图导航功能
- (CLGeocoder *)geocoder
{
    if (!_geocoder) {
        self.geocoder = [[CLGeocoder alloc] init];
    }
    return _geocoder;
}
/**
 *  获取传进来的用户的CLLocation
 */
- (void)setupdestinationPm
{
    // 这里获得店铺经纬度
    float longtitudeText = [self.hotelModel.businessYLocation floatValue];
    float latitudeText = [self.hotelModel.businessXLocation floatValue];
    if (longtitudeText == 0 || latitudeText == 0) return;
    
    CLLocationDegrees latitude = latitudeText;
    CLLocationDegrees longtitude = longtitudeText;
    //开始反向编码
    CLLocation *destinationPm = [[CLLocation alloc] initWithLatitude:latitude longitude:longtitude];
    self.destinationPm = destinationPm;
    
    [self.geocoder reverseGeocodeLocation:destinationPm completionHandler:^(NSArray *placemarks, NSError *error) {
        CLPlacemark *destinationCLPm = [placemarks firstObject];
        if (destinationCLPm == nil) return;
        
        // 设置终点
        MKPlacemark *destinationMKPm = [[MKPlacemark alloc] initWithPlacemark:destinationCLPm];
        self.destinationMKPm = destinationMKPm;
    }];
}

/**
 *  导航按钮点击
 */
- (void)navigationClick
{
    if (self.destinationMKPm == nil){
        [[Toast makeText:@"无法获取酒店位置，请重新刷新页面"] show];
        return;
    }
    MKMapItem *sourceItem=[MKMapItem mapItemForCurrentLocation];//当前位置
    
    // 终点
    MKMapItem *destinationItem = [[MKMapItem alloc] initWithPlacemark:self.destinationMKPm];
    
    // 存放起点和终点
    NSArray *items = @[sourceItem,destinationItem];
    
    // 参数
    NSMutableDictionary *options = [NSMutableDictionary dictionary];
    // 导航模式：驾驶导航
    options[MKLaunchOptionsDirectionsModeKey] = MKLaunchOptionsDirectionsModeDriving;
    // 是否要显示路况
    options[MKLaunchOptionsShowsTrafficKey] = @YES;
    // 打开苹果官方的导航应用
    [MKMapItem openMapsWithItems:items launchOptions:options];
}
- (void)dealloc
{
    NSLog(@"dealloc---Xzb_HotelDetailController");
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
