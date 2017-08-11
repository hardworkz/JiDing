//
//  Xzb_MapViewController.m
//  xzb
//
//  Created by 张荣廷 on 16/5/29.
//  Copyright © 2016年 xuwk. All rights reserved.
//

#import "Xzb_MapViewController.h"

@interface Xzb_MapViewController ()<MAMapViewDelegate,AMapSearchDelegate,UITableViewDelegate,UITableViewDataSource,CLLocationManagerDelegate,UITextFieldDelegate>
@property (nonatomic, strong) MAMapView            *mapView;
@property (nonatomic, strong) AMapSearchAPI        *search;
@property (nonatomic,weak)  UIView *selectedLocationView;
@property (nonatomic,weak)  UIButton *userLocationBtn;
@property (nonatomic,strong)  UIImageView *redWaterView;
@property (nonatomic,weak)  UIButton *cover;
@property (nonatomic,weak)  UIButton *addressBtn;
@property (nonatomic,weak)  UILabel *moveAddressLabel;
@property (nonatomic,weak)  CustomTextField *searchBar;

@property (nonatomic, assign) BOOL                  isLocated;
@property (nonatomic, assign) BOOL                  isSelectedLocation;

@property (nonatomic, assign) NSInteger             searchPage;
@property (nonatomic,weak)  UITableView *provinceTableView;
@property (nonatomic,weak)  UITableView *cityTableView;
@property (nonatomic,strong)  UITableView *tipsTableView;
@property (nonatomic,strong) NSMutableArray *provinceArray;
@property (nonatomic,strong) NSMutableArray *cityArray;
@property (nonatomic,strong) NSNumber *ProvinceID;
@property (nonatomic,strong) NSMutableArray *citys;
@property (nonatomic,strong) NSMutableArray *tipsArray;
@property (nonatomic,strong) NSMutableArray *poisArray;
@property (nonatomic,strong) NSMutableArray *annotationArr;
@property (nonatomic,strong) NSMutableArray *openCityArray;

@property (nonatomic,assign) BOOL  isAlert;
@property (nonatomic,assign)  CGFloat centerY;

@property (nonatomic,strong) NSString *userAddress;
@property (nonatomic,strong) NSString *townShip;
@end

@implementation Xzb_MapViewController
- (NSMutableArray *)openCityArray
{
    if (_openCityArray == nil) {
        _openCityArray = [NSMutableArray array];
    }
    return _openCityArray;
}
#pragma mark - viewWillAppear
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self actionLocation];
}
#pragma mark - viewDidAppear
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}
#pragma mark - viewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [AMapServices sharedServices].apiKey = MaMapApiKey;
    
    self.ProvinceID = @(1);
    
//    UIButton *addressBtn = [[UIButton alloc] init];
//    [addressBtn setTitle:@"定位中" forState:UIControlStateNormal];
//    addressBtn.frame = CGRectMake(0, 0, 56, 30);
//    [addressBtn addTarget:self action:@selector(addressBtnClicked) forControlEvents:UIControlEventTouchUpInside];
//    addressBtn.titleLabel.font = [UIFont systemFontOfSize:14];
//    addressBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
//    self.addressBtn = addressBtn;
//    
//    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"下箭头"]];
//    imageView.contentMode = UIViewContentModeCenter;
//    imageView.frame = CGRectMake(45, 0, 24, 30);
//    
//    UIView *addressView = [[UIView alloc] init];
//    addressView.frame = CGRectMake(0, 0, 80, 30);
//    [addressView addSubview:addressBtn];
//    [addressView addSubview:imageView];
    
//    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:addressView];
//    leftItem.tintColor = [UIColor whiteColor];
//    self.navigationItem.leftBarButtonItem = leftItem;
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(back_clicked)];
    [rightItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont boldSystemFontOfSize:14], NSFontAttributeName,nil] forState:UIControlStateNormal];
    rightItem.tintColor = AppDeepGrayTextColor;
    self.navigationItem.rightBarButtonItem = rightItem;
    
    CustomTextField *searchBar = [[CustomTextField alloc] init];
    searchBar.returnKeyType = UIReturnKeySearch;
    searchBar.placeholder = @"  输入街道、地名、地标...";
    searchBar.frame = CGRectMake(0, 0, 300, 30);
    searchBar.borderStyle = UITextBorderStyleNone;
    searchBar.layer.cornerRadius = 5;
    searchBar.backgroundColor = AppGreenTextColor;
    searchBar.tintColor = AppDeepGrayTextColor;
    searchBar.delegate = self;
    self.navigationItem.titleView = searchBar;
    self.searchBar = searchBar;
    
    [self initMapView];
    [self initSearch];
    [self initRedWaterView];
    [self initChooseLocationBtnAndUserLocationBtn];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange:) name:UITextFieldTextDidChangeNotification object:nil];
    
    //获取开发酒店城市数据
//    [self getOpenHotelCityData];
    
    //添加地图热力图遮盖
//    [self setupMapTileOverlay];
}
#pragma mark - 热力图生成遮盖
- (void)setupMapTileOverlay
{//构造热力图图层对象
    MAHeatMapTileOverlay  *heatMapTileOverlay = [[MAHeatMapTileOverlay alloc] init];
    
    //构造热力图数据，从locations.json中读取经纬度
    NSMutableArray* data = [NSMutableArray array];
    
    NSData *jsdata = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"locations" ofType:@"json"]];
    
    @autoreleasepool {
        
        if (jsdata)
        {
            NSArray *dicArray = [NSJSONSerialization JSONObjectWithData:jsdata options:NSJSONReadingAllowFragments error:nil];
            
            for (NSDictionary *dic in dicArray)
            {
                MAHeatMapNode *node = [[MAHeatMapNode alloc] init];
                CLLocationCoordinate2D coordinate;
                coordinate.latitude = [dic[@"lat"] doubleValue];
                coordinate.longitude = [dic[@"lng"] doubleValue];
                node.coordinate = coordinate;
                
                node.intensity = 1;//设置权重
                [data addObject:node];
            }
        }
        heatMapTileOverlay.data = data;
        
        //构造渐变色对象
        MAHeatMapGradient *gradient = [[MAHeatMapGradient alloc] initWithColor:@[[UIColor blueColor],[UIColor greenColor], [UIColor redColor]] andWithStartPoints:@[@(0.2),@(0.5),@(0.9)]];
        heatMapTileOverlay.gradient = gradient;
        
        //将热力图添加到地图上
        [_mapView addOverlay:heatMapTileOverlay];
    }
}
#pragma mark - 获取开放酒店城市数据
- (void)getOpenHotelCityData
{
    [RTHttpTool get:GET_COUNT_BY_PROVINCE_CITY addHUD:NO param:nil success:^(id responseObj) {
        RTLog(@"%@",responseObj);
        if ([responseObj[SUCCESS] intValue] == 1) {
            self.openCityArray = [Xzb_OpenCityModel mj_objectArrayWithKeyValuesArray:responseObj[ENTITIES][LIST]];
            self.provinceArray = [self provinceArrayWithGetDataArray:self.openCityArray];
            self.cityArray = [self cityArrayWithGetDataArray:self.openCityArray];
        }
    } failure:^(NSError *error) {
        
    }];
}
#pragma mark - 从json中的数据筛选出自己需要的开放城市数据
- (NSMutableArray *)provinceArrayWithGetDataArray:(NSArray *)array
{
    NSMutableArray *tempArray = [NSMutableArray array];
    NSMutableArray *tempProvinceArray = [NSMutableArray array];
    [tempProvinceArray removeAllObjects];
    [tempProvinceArray addObjectsFromArray:self.provinceArray];
    for (int i = 0; i<self.openCityArray.count; i++) {
        Xzb_OpenCityModel *model = self.openCityArray[i];
        for (int j = 0; j<tempProvinceArray.count; j++) {
            ProvinceModel *provinceModel = tempProvinceArray[j];
            //判读相等则将数据取出作为展示
            if ([provinceModel.ProvinceID intValue] == [model.province intValue]) {
                [tempArray addObject:provinceModel];
                [tempProvinceArray removeObject:provinceModel];
            }
        }
    }
    return tempArray;
}
- (NSMutableArray *)cityArrayWithGetDataArray:(NSArray *)array
{
    NSMutableArray *tempArray = [NSMutableArray array];
    for (int i = 0; i<self.openCityArray.count; i++) {
        Xzb_OpenCityModel *model = self.openCityArray[i];
        for (int j = 0; j<self.cityArray.count; j++) {
            CityModel *cityModel = self.cityArray[j];
            //判读相等则将数据取出作为展示
            if ([cityModel.CityID intValue] == [model.city intValue]) {
                [tempArray addObject:cityModel];
            }
        }
    }
    return tempArray;
}
#pragma mark - 坐标搜索Poi
/* 根据中心点坐标来搜周边的POI. */
- (void)searchPoiByCenterCoordinate:(CLLocationCoordinate2D )coord
{
    AMapPOIAroundSearchRequest*request = [[AMapPOIAroundSearchRequest alloc] init];
    
    request.location = [AMapGeoPoint locationWithLatitude:coord.latitude  longitude:coord.longitude];
    
    request.radius   = 1000;
    
    request.sortrule = 1;
    request.page     = self.searchPage;
    
    [self.search AMapPOIAroundSearch:request];
}
#pragma mark - 输入提示查询搜索
/* 输入提示查询接口 */
- (void)searchTipByKeyWords:(NSString *)keywords
{
    AMapInputTipsSearchRequest *request = [[AMapInputTipsSearchRequest alloc] init];
    request.keywords = keywords;
    request.city = self.addressBtn.titleLabel.text;
//    request.types = @"住宿服务";
    [self.search AMapInputTipsSearch:request];
}
#pragma mark - 输入提示查询搜索回调
/* 输入提示回调接口 */
- (void)onInputTipsSearchDone:(AMapInputTipsSearchRequest *)request response:(AMapInputTipsSearchResponse *)response
{
    if (response.count != 0) {
        self.tipsArray = (NSMutableArray *)response.tips;
        if (self.tipsTableView == nil) {
            UIButton *cover = [[UIButton alloc] init];
            cover.frame = CGRectMake(0, 0, SCREEN_Width, SCREEN_Height);
            cover.alpha = 0.1;
            cover.backgroundColor = [UIColor grayColor];
            [cover addTarget:self action:@selector(coverClicked:) forControlEvents:UIControlEventTouchUpInside];
            [self.view insertSubview:cover aboveSubview:self.navigationController.navigationBar];
            self.cover = cover;

            self.tipsTableView = [[UITableView alloc] init];
            self.tipsTableView.delegate = self;
            self.tipsTableView.dataSource = self;
            self.tipsTableView.frame = CGRectMake(100, 0, 230, 200);
            [self.view addSubview:self.tipsTableView];
        }
        
        [self.tipsTableView reloadData];
    }
}
#pragma mark - Poi关键字搜索
/* POI关键字搜索 */
- (void)searchPoiByKeywords:(NSString *)keywords andCity:(NSString *)city
{
    AMapPOIKeywordsSearchRequest *request = [[AMapPOIKeywordsSearchRequest alloc] init];
    request.keywords = keywords;
    if (city) {
        request.city = city;
    }else
    {
        request.city = self.addressBtn.titleLabel.text;
    }
//    request.cityLimit = YES;
    
    [self.search AMapPOIKeywordsSearch:request];
}
#pragma mark - Poi搜索回调
//poi搜索回调
- (void)onPOISearchDone:(AMapPOISearchBaseRequest *)request response:(AMapPOISearchResponse *)response
{
    if (response.count == 0) {
        return;
    }
    // 先移除掉上次搜索的大头针  不然上一次的大头针会一直存在
    [self.mapView removeAnnotations:self.annotationArr];
    //清空数组
    [self.annotationArr removeAllObjects];
    NSString *responseCount = [NSString stringWithFormat:@"%lu",(long)response.count];;
    NSLog(@"responseCount = %@",responseCount);
    
    AMapPOI *poi = response.pois[0];
    MAPointAnnotation *annotation = [[MAPointAnnotation alloc] init];
    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(poi.location.latitude, poi.location.longitude);
    annotation.coordinate = coordinate;
    annotation.title = poi.name;
    annotation.subtitle = poi.address;
    [self.annotationArr addObject:annotation];
    [self.mapView addAnnotation:annotation];
    //城市搜索回调
    [self.mapView setCenterCoordinate:coordinate animated:YES];
}
#pragma mark - 地理编码
//通过经纬度实现逆地理编码
- (void)searchReGeocodeWithCoordinate:(CLLocationCoordinate2D)coordinate
{
    AMapReGeocodeSearchRequest *regeo = [[AMapReGeocodeSearchRequest alloc] init];
    
    regeo.location = [AMapGeoPoint locationWithLatitude:coordinate.latitude longitude:coordinate.longitude];
    regeo.requireExtension = YES;
    
    [self.search AMapReGoecodeSearch:regeo];
}
#pragma mark - 地理编码回调
//实现地理编码的回调函数
- (void)onGeocodeSearchDone:(AMapGeocodeSearchRequest *)request response:(AMapGeocodeSearchResponse *)response
{
    if (response.count != 0) {
    }
}
#pragma mark - 地理反编码
//通过地理位置名称和城市名称进行地理反编码
- (void)searchGeocodeWithAddressName:(NSString *)name city:(NSString *)cityName
{
    AMapGeocodeSearchRequest *geo = [[AMapGeocodeSearchRequest alloc] init];
    geo.address = name;
    geo.city = cityName;
    [self.search AMapGeocodeSearch:geo];
}
#pragma mark - 地理反编码回调
//实现逆地理编码的回调函数
- (void)onReGeocodeSearchDone:(AMapReGeocodeSearchRequest *)request response:(AMapReGeocodeSearchResponse *)response
{
    if(response.regeocode != nil)
    {
        self.userAddress = response.regeocode.formattedAddress;
        self.townShip = response.regeocode.addressComponent.township;
        
        if ([response.regeocode.addressComponent.city isEqualToString:@""]) {
            [self.addressBtn setTitle:response.regeocode.addressComponent.province forState:UIControlStateNormal];
        }else
        {
            [self.addressBtn setTitle:response.regeocode.addressComponent.city forState:UIControlStateNormal];
        }
        //通过AMapReGeocodeSearchResponse对象处理搜索结果
        NSString *result = [NSString stringWithFormat:@"ReGeocode: %@", response.regeocode.formattedAddress];
        NSLog(@"ReGeo: %@", result);
        if (self.isSelectedLocation) {
            [self.navigationController popViewControllerAnimated:YES];
        }
        if (self.mapView.userTrackingMode != MAUserTrackingModeFollow) {
            [self clearTips];
        }
        CGSize formattedAddressSize = [response.regeocode.formattedAddress boundingRectWithSize:CGSizeMake(SCREEN_WIDTH, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.moveAddressLabel.font} context:nil].size;
        self.moveAddressLabel.text = response.regeocode.formattedAddress;
        [UIView animateWithDuration:0.5 animations:^{
            self.moveAddressLabel.height = 17 + formattedAddressSize.height;
        }];
    }
}
#pragma mark - 数据数组初始化
- (NSArray *)annotationArr
{
    if (_annotationArr == nil) {
        _annotationArr = [NSMutableArray array];
    }
    return _annotationArr;
}
- (NSArray *)poisArray
{
    if (_poisArray == nil) {
        _poisArray = [NSMutableArray array];
    }
    return _poisArray;
}
- (NSArray *)tipsArray
{
    if (_tipsArray == nil) {
        _tipsArray = [NSMutableArray array];
    }
    return _tipsArray;
}
- (NSArray *)citys
{
    if (_citys == nil) {
        _citys = [NSMutableArray array];
    }
    return _citys;
}
- (NSArray *)provinceArray
{
    if (_provinceArray == nil) {
        _provinceArray = [NSMutableArray array];
        //读取本地json文件
        NSString *path = [[NSBundle mainBundle] pathForResource:@"s_province" ofType:@"json"];
        
        NSData *jsonData = [NSData dataWithContentsOfFile:path options:NSDataReadingMappedIfSafe error:nil];
        
        id json = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
        
        _provinceArray = [ProvinceModel mj_objectArrayWithKeyValuesArray:json[@"RECORDS"]];
    }
    return _provinceArray;
}
- (NSArray *)cityArray
{
    if (_cityArray == nil) {
        _cityArray = [NSMutableArray array];
        //读取本地json文件
        NSString *path = [[NSBundle mainBundle] pathForResource:@"s_city" ofType:@"json"];
        
        NSData *jsonData = [NSData dataWithContentsOfFile:path options:NSDataReadingMappedIfSafe error:nil];
        
        id json = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
        
        _cityArray = [CityModel mj_objectArrayWithKeyValuesArray:json[@"RECORDS"]];
    }
    return _cityArray;
}
//更新城市数据数组
- (void)setupCityData
{
    [self.citys removeAllObjects];
    for (CityModel *model in self.cityArray) {
        if ([model.ProvinceID intValue] == [self.ProvinceID intValue]) {
            [self.citys addObject:model];
        }
    }
}

#pragma mark - 初始化方法
- (void)initRedWaterView
{
    UIImage *image = [UIImage imageNamed:@"wateRedBlank"];
    self.redWaterView = [[UIImageView alloc] initWithImage:image];
    
    self.redWaterView.frame = CGRectMake(self.view.bounds.size.width/2-image.size.width/2, self.mapView.bounds.size.height/2-image.size.height, image.size.width, image.size.height);
    
    self.redWaterView.center = CGPointMake(CGRectGetWidth(self.view.bounds) / 2, CGRectGetHeight(self.mapView.bounds) / 2 - CGRectGetHeight(self.redWaterView.bounds) * 1.5);
    
    [self.view insertSubview:self.redWaterView aboveSubview:self.mapView];
    self.centerY = self.redWaterView.center.y;
}

- (void)initChooseLocationBtnAndUserLocationBtn
{
    //选择位置按钮
    UIButton *chooseLocationBtn = [[UIButton alloc] init];
    [chooseLocationBtn setTitle:@"选择位置" forState:UIControlStateNormal];
    chooseLocationBtn.backgroundColor = AppGreenTextColor;
    chooseLocationBtn.layer.cornerRadius = 5;
    chooseLocationBtn.frame = CGRectMake(SCREEN_Width *0.25,SCREEN_Height - 80 - 64,SCREEN_Width * 0.5, 50);
    [chooseLocationBtn addTarget:self action:@selector(chooseLocationBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.mapView addSubview:chooseLocationBtn];
    
    UIButton *userLocationBtn = [[UIButton alloc] init];
    [userLocationBtn setBackgroundImage:[UIImage imageNamed:@"导航－未点击"] forState:UIControlStateNormal];
    userLocationBtn.frame = CGRectMake((SCREEN_Width * 0.25 - 46) * 0.5, chooseLocationBtn.y + 2, 46, 46);
    [userLocationBtn addTarget:self action:@selector(actionLocation) forControlEvents:UIControlEventTouchUpInside];
    [self.mapView addSubview:userLocationBtn];
    self.userLocationBtn = userLocationBtn;
    
    UILabel *moveAddressLabel = [[UILabel alloc] init];
    moveAddressLabel.alpha = 0.65;
    moveAddressLabel.numberOfLines = 0;
    moveAddressLabel.backgroundColor = [UIColor whiteColor];
    moveAddressLabel.frame = CGRectMake(0, 0, SCREEN_Width, 30);
    moveAddressLabel.font = [UIFont systemFontOfSize:13];
    moveAddressLabel.textAlignment = NSTextAlignmentCenter;
    [self.mapView addSubview:moveAddressLabel];
    self.moveAddressLabel = moveAddressLabel;
}
#pragma mark - 初始化地图
- (void)initMapView
{
    self.mapView = [[MAMapView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, SCREEN_Height)];
    self.mapView.delegate = self;
    self.mapView.showsCompass = NO;
    self.mapView.showsScale = NO;
    self.mapView.rotateCameraEnabled = NO;
    //minZoomLevel-maxZoomLevel:3-19
    self.mapView.zoomLevel = 14.0;
    self.mapView.showsUserLocation = YES;
    self.mapView.mapType = MAMapTypeStandard;
    self.mapView.userTrackingMode = MAUserTrackingModeFollow;
    [self.view addSubview:self.mapView];
    
    self.isLocated = NO;
}

- (void)initSearch
{
    self.searchPage = 1;
    self.search = [[AMapSearchAPI alloc] init];
    self.search.delegate = self;
}

- (void)back_clicked
{
    [self.selectedLocationView removeFromSuperview];
    [self clearTips];
    [self.cover removeFromSuperview];
    [self.navigationController popViewControllerAnimated:YES];
}
//选择位置按钮点击
- (void)chooseLocationBtnClicked
{
    //获取选中经纬度
    NSLog(@"lontitude : %.15f latitute : %.15f",self.mapView.centerCoordinate.longitude,self.mapView.centerCoordinate.latitude);
    Xzb_ApplicationData *data = [Xzb_ApplicationDataTool account];
    data.user_x = [NSString stringWithFormat:@"%f",self.mapView.centerCoordinate.longitude];
    data.user_y = [NSString stringWithFormat:@"%f",self.mapView.centerCoordinate.latitude];
    data.userAddress = self.userAddress;
    data.township = self.townShip;
    [Xzb_ApplicationDataTool saveWithAccount:data];
    
    self.isSelectedLocation = YES;
    
    if ([self.delegate respondsToSelector:@selector(chooseLocationWithString:)]) {
        [self.delegate chooseLocationWithString:[NSString stringWithFormat: @"%@  %@",self.userAddress,self.townShip]];
    }
    
    [self searchReGeocodeWithCoordinate:self.mapView.centerCoordinate];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:ChooseLocationNotification object:nil];
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//点击左上角位置按钮
- (void)addressBtnClicked
{
    NSLog(@"%d",self.isAlert);
    if (!self.isAlert) {
        UIView *selectedLocationView = [[UIView alloc] init];
        selectedLocationView.backgroundColor = AppLightLineColor;
        selectedLocationView.frame = CGRectMake(0, 64, SCREEN_Width * 0.6, 9 * 50);
        [self.view.window addSubview:selectedLocationView];
        self.selectedLocationView = selectedLocationView;
        
        UITableView *provinceTableView = [[UITableView alloc] init];
        provinceTableView.frame = CGRectMake(0, 0, selectedLocationView.width * 0.5, selectedLocationView.height);
        provinceTableView.delegate = self;
        provinceTableView.dataSource = self;
        provinceTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [selectedLocationView addSubview:provinceTableView];
        self.provinceTableView = provinceTableView;
        
        UIView *devider = [[UIView alloc] init];
        devider.backgroundColor = AppLineColor;
        devider.frame = CGRectMake(SCREEN_Width * 0.3 - 1, 0, 1, 10000);
        [provinceTableView addSubview:devider];
        
        UITableView *cityTableView = [[UITableView alloc] init];
        cityTableView.frame = CGRectMake(selectedLocationView.width * 0.5, 0, selectedLocationView.width * 0.5, selectedLocationView.height);
        cityTableView.delegate = self;
        cityTableView.dataSource = self;
        cityTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [selectedLocationView addSubview:cityTableView];
        self.cityTableView = cityTableView;
        
        
        UIView *deviderTwo = [[UIView alloc] init];
        deviderTwo.backgroundColor = AppLineColor;
        deviderTwo.frame = CGRectMake(SCREEN_Width * 0.6 - 1, 0, 1, 10000);
        [selectedLocationView addSubview:deviderTwo];
        
        UIButton *cover = [[UIButton alloc] init];
        cover.frame = CGRectMake(0, 0, SCREEN_Width, SCREEN_Height);
        cover.alpha = 0.1;
        cover.backgroundColor = [UIColor grayColor];
        [cover addTarget:self action:@selector(coverClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.view.window insertSubview:cover belowSubview:selectedLocationView];
        self.cover = cover;
        
        self.isAlert = YES;
    }else
    {
        [self.selectedLocationView removeFromSuperview];
        self.isAlert = NO;
    }
}
- (void)coverClicked:(UIButton *)btn
{
    [self.selectedLocationView removeFromSuperview];
    [self clearTips];
    [btn removeFromSuperview];
}
#pragma mark - MapViewDelegate
- (void)mapView:(MAMapView *)mapView mapDidMoveByUser:(BOOL)wasUserAction
{
    [self searchReGeocodeWithCoordinate:self.mapView.centerCoordinate];
    if (self.mapView.userTrackingMode == MAUserTrackingModeNone)
    {
        [self redWaterAnimimate];
    }
}
- (void)mapView:(MAMapView *)mapView regionDidChangeAnimated:(BOOL)animated
{
    
    [self searchReGeocodeWithCoordinate:self.mapView.centerCoordinate];
    if (self.mapView.userTrackingMode == MAUserTrackingModeNone)
    {
        [self redWaterAnimimate];
    }
}
- (MAOverlayRenderer *)mapView:(MAMapView *)mapView rendererForOverlay:(id<MAOverlay>)overlay
{
    if ([overlay isKindOfClass:[MATileOverlay class]])
    {
        MATileOverlayRenderer *tileOverlayRenderer = [[MATileOverlayRenderer alloc] initWithTileOverlay:(MATileOverlay *)overlay];
        
        return tileOverlayRenderer;
    }
    
    return nil;
}
#pragma mark - 定位用户位置

- (void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation updatingLocation:(BOOL)updatingLocation
{
    if(!updatingLocation)
        return ;
    
    if (userLocation.location.horizontalAccuracy < 0)
    {
        return ;
    }
    
    // only the first locate used.
    if (!self.isLocated)
    {
        [_mapView setCenterCoordinate:_mapView.userLocation.coordinate];
        
        self.isLocated = YES;
        Xzb_ApplicationData *data = [Xzb_ApplicationDataTool account];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if (data.user_x && data.user_y) {
                CLLocationCoordinate2D center = CLLocationCoordinate2DMake(data.user_y.doubleValue, data.user_x.doubleValue);
                [self.mapView setCenterCoordinate:center animated:NO];
                [self searchReGeocodeWithCoordinate:center];
            }else{
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.5 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                    // 因为下面这句的动画有bug，所以要延迟0.5s执行，动画由上一句产生
                    [self.mapView setUserTrackingMode:MAUserTrackingModeFollow animated:YES];
                });
                [self searchReGeocodeWithCoordinate:self.mapView.centerCoordinate];
            }
        });
    }
}
- (void)mapView:(MAMapView *)mapView  didChangeUserTrackingMode:(MAUserTrackingMode)mode animated:(BOOL)animated
{
    if (mode == MAUserTrackingModeNone)
    {
        [self.userLocationBtn setBackgroundImage:[UIImage imageNamed:@"导航－未点击"] forState:UIControlStateNormal];
    }
    else
    {
        [self.userLocationBtn setBackgroundImage:[UIImage imageNamed:@"导航－点击"] forState:UIControlStateNormal];
    }
}
- (void)mapView:(MAMapView *)mapView didFailToLocateUserWithError:(NSError *)error
{
    NSLog(@"error = %@",error);
}

#pragma mark - 点击定位自己的位置

- (void)actionLocation
{
    if (self.mapView.userTrackingMode == MAUserTrackingModeFollow)
    {
        [self.mapView setUserTrackingMode:MAUserTrackingModeNone animated:YES];
        [self.userLocationBtn setBackgroundImage:[UIImage imageNamed:@"导航－未点击"] forState:UIControlStateNormal];
    }
    else
    {
        self.searchPage = 1;
        [self.userLocationBtn setBackgroundImage:[UIImage imageNamed:@"导航－点击"] forState:UIControlStateNormal];
        
        [self.mapView setCenterCoordinate:self.mapView.userLocation.coordinate animated:YES];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.5 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
            // 因为下面这句的动画有bug，所以要延迟0.5s执行，动画由上一句产生
            [self.mapView setUserTrackingMode:MAUserTrackingModeFollow animated:YES];
        });
    }
}
/* 移动窗口弹一下的动画 */
- (void)redWaterAnimimate
{
    [UIView animateWithDuration:0.2
                          delay:0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         CGPoint center = self.redWaterView.center;
                         center.y = self.centerY - 10;
                         [self.redWaterView setCenter:center];}
                     completion:^(BOOL finished) {
                         [UIView animateWithDuration:0.2
                                               delay:0
                                             options:UIViewAnimationOptionCurveEaseIn
                                          animations:^{
                                              CGPoint center = self.redWaterView.center;
                                              center.y = self.centerY;
                                              [self.redWaterView setCenter:center];}
                                          completion:nil];
                     }];
    
    
}

#pragma mark - table view datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([tableView isEqual:self.provinceTableView]) {
        
        return self.provinceArray.count;
    }else if ([tableView isEqual:self.tipsTableView]) {
        
        return self.tipsArray.count;
    }else{
        [self setupCityData];
        return self.citys.count;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([tableView isEqual:self.provinceTableView]) {
        AreaTableViewCell *cell = [AreaTableViewCell cellWithTableView:tableView];
        ProvinceModel *model = self.provinceArray[indexPath.row];
        cell.titleLabel.text = model.ProvinceName;
        return cell;
    }else if ([tableView isEqual:self.tipsTableView]) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"tipcell"];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"tipcell"];
        }
        AMapTip *model = self.tipsArray[indexPath.row];
        cell.textLabel.text = model.name;
        
        return cell;
    }else
    {
        AreaTableViewCell *cell = [AreaTableViewCell cellWithTableView:tableView];
        CityModel *model = self.citys[indexPath.row];
        cell.titleLabel.text = model.CityName;
        return cell;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([tableView isEqual:self.provinceTableView]) {
        ProvinceModel *model = self.provinceArray[indexPath.row];
        self.ProvinceID = model.ProvinceID;
        [self setupCityData];
        [self.cityTableView reloadData];
    }else if ([tableView isEqual:self.tipsTableView]) {
        AMapTip *model = self.tipsArray[indexPath.row];
        [self searchGeocodeWithAddressName:model.name city:self.addressBtn.titleLabel.text];
        [self searchPoiByKeywords:model.name andCity:self.addressBtn.titleLabel.text];
        [self clearTips];
    }else
    {
        CityModel *model = self.citys[indexPath.row];
        [self searchGeocodeWithAddressName:model.CityName city:model.CityName];
        [self searchPoiByKeywords:model.CityName andCity:model.CityName];
        
        [self.selectedLocationView removeFromSuperview];
        [self.cover removeFromSuperview];
        self.isAlert = NO;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}
- (void)clearTips
{
    [self.searchBar resignFirstResponder];
    [self.tipsTableView removeFromSuperview];
    self.tipsTableView = nil;
    self.searchBar.text = nil;
    [self.cover removeFromSuperview];
}
#pragma mark - textfield delegate
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField.text != nil) {
        [self searchGeocodeWithAddressName:textField.text city:self.addressBtn.titleLabel.text];
    }
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (![textField.text isEqualToString:@""]) {
        [self searchGeocodeWithAddressName:textField.text city:self.addressBtn.titleLabel.text];
        [self searchPoiByKeywords:textField.text andCity:self.addressBtn.titleLabel.text];
        [self.searchBar resignFirstResponder];
        [self clearTips];
    }
    return YES;
}
- (void)textDidChange:(NSNotification *)note
{
    UITextField *textField = note.object;
    NSLog(@"textDidChange:%@",textField.text);
    [self searchTipByKeyWords:textField.text];
}
- (void)dealloc
{
    NSLog(@"dealloc---Xzb_MapViewController");
}
@end
