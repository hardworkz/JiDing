//
//  Xzb_SearchResultMapController.m
//  xzb
//
//  Created by 张荣廷 on 16/6/13.
//  Copyright © 2016年 xuwk. All rights reserved.
//

#import "Xzb_SearchResultMapController.h"
#import <MAMapKit/MAMapKit.h>
#import <MAMapKit/MAMapView.h>
#import <AMapSearchKit/AMapSearchKit.h>
#import <AMapLocationKit/AMapLocationKit.h>
#import <AMapFoundationKit/AMapFoundationKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

@interface Xzb_SearchResultMapController ()<MAMapViewDelegate>
@property (nonatomic,strong)  MAMapView *mapView;
@property (nonatomic,strong) NSMutableArray *annotationArray;
@property (nonatomic,assign)  BOOL isLocation;
@end

@implementation Xzb_SearchResultMapController
- (NSArray *)annotationArray
{
    if (_annotationArray == nil) {
        _annotationArray = [NSMutableArray array];
    }
    return _annotationArray;
}
- (NSMutableArray *)dataArray
{
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
- (void)back_clicked
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //设置导航栏标题
    self.title = @"酒店地图列表";

    [self initMapView];
    [self setupAnnotation];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(titleLabelTap:) name:TitleLabelTapNotification object:nil];
}
- (void)setupAnnotation
{
    // 先移除掉上次搜索的大头针  不然上一次的大头针会一直存在
    [self.mapView removeAnnotations:self.annotationArray];
    //清空数组
    [self.annotationArray removeAllObjects];
    //添加大头针
    for (HotelOfferModel *model in self.dataArray) {
        MAPointAnnotation *annotation = [[MAPointAnnotation alloc] init];
        CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake([model.xlocation floatValue], [model.ylocation floatValue]);
        annotation.coordinate = coordinate;
        annotation.title = model.name;
        [self.annotationArray addObject:annotation];
        [self.mapView addAnnotation:annotation];
    }
    
    //添加用户搜索位置大头针
    Xzb_ApplicationData *data = [Xzb_ApplicationDataTool account];
    MAPointAnnotation *annotation = [[MAPointAnnotation alloc] init];
    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(data.user_y.doubleValue, data.user_x.doubleValue);
    annotation.coordinate = coordinate;
    annotation.title = @"用户搜索位置";
    [self.annotationArray addObject:annotation];
    [self.mapView addAnnotation:annotation];
}
- (void)initMapView
{
    self.mapView = [[MAMapView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, SCREEN_Height)];
    self.mapView.delegate = self;
    self.mapView.showsCompass = NO;
    self.mapView.showsScale = NO;
    self.mapView.rotateCameraEnabled = NO;
    self.mapView.zoomLevel = 14.0;
    self.mapView.showsUserLocation = YES;
    self.mapView.mapType = MAMapTypeStandard;
    self.mapView.userTrackingMode = MAUserTrackingModeNone;
    [self.view addSubview:self.mapView];
    self.isLocation = YES;
}
/**
 *  点击气泡标题
 */
- (void)titleLabelTap:(NSNotification *)note
{
    NSDictionary *dict = note.userInfo;
    Xzb_AnnnotationRightBtn *button = dict[@"rightBtn"];
    [self rightBtnClicked:button];
}
- (void)rightBtnClicked:(Xzb_AnnnotationRightBtn *)button
{
    MAAnnotationView *annotationView = (MAAnnotationView *)button.view;
    //循环判读点击的大头针
    for (int i = 0; i<self.dataArray.count; i++) {
        MAPointAnnotation *annotation = (MAPointAnnotation *)annotationView.annotation;
        HotelOfferModel *model = self.dataArray[i];
        if (annotation.coordinate.latitude == [model.xlocation floatValue]/*这里放数组中模型的纬度值做对比 如果找到了，就跳转到对应的酒店详情控制*/) {
            if ([model.seconds intValue] <= 0) {
                [[Toast makeText:@"该报价已失效~"] show];
                return;
            }
            Xzb_HotelDetailController *hotelDetail = [[Xzb_HotelDetailController alloc] init];
            hotelDetail.orderRelID = model.orderRelId;
            hotelDetail.model = model;
            [self.navigationController pushViewController:hotelDetail animated:YES];
            break;//跳出循环
        }
    }
}
#pragma mark - mapview delegate
- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation
{
    //大头针
    if ([annotation isKindOfClass:[MAPointAnnotation class]])
    {
        HotelOfferModel *dataModel;
        NSString *imagePath;
        for (HotelOfferModel *model in self.dataArray) {
            if ([model.name isEqualToString:annotation.title]) {
                imagePath = model.image;
                dataModel = model;
                break;
            }
        }

        NSString *customReuseIndetifier;
        if ([annotation.title isEqualToString:@"用户搜索位置"]) {
            
            customReuseIndetifier = @"customUserReuseIndetifier";
        }else
        {
            customReuseIndetifier = @"customReuseIndetifier";
        }

        
        CusAnnotationView *annotationView = (CusAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:customReuseIndetifier];
        
        if (annotationView == nil)
        {
            annotationView = [[CusAnnotationView alloc] initWithAnnotation:annotation
                                                           reuseIdentifier:customReuseIndetifier];
        }
        
        [annotationView.leftBtn setTitle:[NSString stringWithFormat:@"¥\n%d",[dataModel.price intValue]] forState:UIControlStateNormal];
        annotationView.rightBtn.view = annotationView;
        annotationView.name = annotation.title;
        [annotationView.rightBtn addTarget:self action:@selector(rightBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        annotationView.image = [UIImage imageNamed:@"酒店列表地标"];
        if ([annotation.title isEqualToString:@"用户搜索位置"]) {
            annotationView.canShowCallout= YES;       //设置气泡可以弹出，默认为NO
            annotationView.image = [UIImage imageNamed:@"酒店列表用户位置"];
        }else
        {
            annotationView.image = [UIImage imageNamed:@"酒店列表地标"];
        }
//        annotationView.animatesDrop = YES;        //设置标注动画显示，默认为NO
//        annotationView.draggable = NO;        //设置标注可以拖动，默认为NO
//        annotationView.pinColor = MAPinAnnotationColorRed;
        
        return annotationView;
    }
    return nil;

}
#pragma mark - userLocation
- (void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation updatingLocation:(BOOL)updatingLocation
{
    if(!updatingLocation)
        return ;
    
    if (userLocation.location.horizontalAccuracy < 0)
    {
        return ;
    }
    if (self.isLocation) {
        [_mapView setCenterCoordinate:_mapView.userLocation.coordinate];
        CLLocationCoordinate2D center;
        Xzb_ApplicationData *data = [Xzb_ApplicationDataTool account];
        if (data.user_x.length && data.user_y.length) {
            center = CLLocationCoordinate2DMake(data.user_y.doubleValue, data.user_x.doubleValue);
        }else
        {
            center = self.mapView.userLocation.coordinate;
        }
        //设置气泡默认显示
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.mapView setCenterCoordinate:center];
        });
        
        self.isLocation = NO;
    }
    
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
