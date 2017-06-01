//
//  Xzb_CommentViewController.m
//  xzb
//
//  Created by 张荣廷 on 16/5/30.
//  Copyright © 2016年 xuwk. All rights reserved.
//

#import "Xzb_CommentViewController.h"
#import "CommentImageView.h"

#define PHOTO_W 100
@interface Xzb_CommentViewController ()<HMComposePhotosViewDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate,JKImagePickerControllerDelegate,RatingBarDelegate,UITextViewDelegate>

@property (nonatomic,weak)  UIImageView *photoView;
@property (nonatomic,weak)  UILabel *nameLabel;
@property (nonatomic,weak)  UILabel *roomTypeBtn;
@property (nonatomic,weak)  UILabel *timeLabel;
@property (nonatomic,weak)  UILabel *priceLabel;
@property (nonatomic,weak)  RatingBar *gradeBar;
@property (nonatomic,weak)  IWTextView *textView;
@property (nonatomic , weak) HMComposePhotosView *photosView;
@property (nonatomic,weak)   UIView *commentView;
@property (nonatomic,weak)  UILabel *scoreLabel;

@property (nonatomic, strong) NSMutableArray   *assetsArray;
@property (nonatomic , strong) NSMutableArray *imageArray;
//房间类型ID 名称 写死数据
@property (nonatomic,strong) NSArray *roomTypeArray;
@property (nonatomic,strong) NSArray *roomTypeIDArray;

@property (nonatomic,strong) NSMutableArray *photoPathArray;
@end

@implementation Xzb_CommentViewController
- (NSArray *)roomTypeArray
{
    if (_roomTypeArray == nil) {
        _roomTypeArray = @[@"标准房",@"大床房",@"家庭房",@"商务房"];
    }
    return _roomTypeArray;
}
- (NSArray *)roomTypeIDArray
{
    if (_roomTypeIDArray == nil) {
        _roomTypeIDArray = @[@"2",@"1",@"4",@"3"];
    }
    return _roomTypeIDArray;
}
- (NSArray *)photoPathArray
{
    if (_photoPathArray == nil) {
        _photoPathArray = [NSMutableArray array];
    }
    return _photoPathArray;
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.keyboardDistanceFromTextField = 20;
    
    //设置导航栏标题
    self.title = @"评价";
    //初始化子控件
    [self setupSubView];
    //设置订单数据
    [self setupOrderData];
}
- (void)setupOrderData
{
    UserAccount *account = [UserAccountTool account];
    [RTHttpTool get:GET_ORDER_BY_ID addHUD:YES param:@{USERID:account.userId,TOKEN:account.loginToken,ORDERID:self.orderID} success:^(id responseObj) {
        id json = [RTHttpTool jsonWithResponseObj:responseObj];
        NSLog(@"%@",json);
        if ([json[SUCCESS] intValue] == 1) {
            self.nameLabel.text = json[ENTITIES][@"orderInfo"][@"businessName"];
            self.roomTypeBtn.text = [self roomTypeByRoomTypeID:[NSString stringWithFormat:@"%@",json[ENTITIES][@"orderInfo"][@"roomType"]]];
            self.priceLabel.text = [NSString stringWithFormat:@"¥%@",json[ENTITIES][@"orderInfo"][@"price"]];
            NSString *timeStr = json[ENTITIES][@"orderInfo"][@"orderDate"];
            self.timeLabel.text = [NSString stringWithFormat:@"下单时间:%@",[timeStr substringToIndex:16]];
        }
    } failure:^(NSError *error) {
        
    }];
}
- (NSString *)roomTypeByRoomTypeID:(NSString *)ID
{
    NSString *roomTypeStr;
    for (int i = 0; i<self.roomTypeIDArray.count; i++) {
        if ([self.roomTypeIDArray[i] intValue] == [ID intValue]) {
            roomTypeStr = self.roomTypeArray[i];
            break;
        }
    }
    return roomTypeStr;
}
- (void)setupSubView
{
    UIScrollView *contentScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    contentScrollView.backgroundColor = AppLightLineColor;
    [self.view addSubview:contentScrollView];
    
    UIView *messageView = [[UIView alloc] init];
    messageView.backgroundColor = [UIColor whiteColor];
    messageView.frame = CGRectMake(0, 0, SCREEN_Width, 120);
    [contentScrollView addSubview:messageView];
    
    UIImageView *photoView = [[UIImageView alloc] init];
    photoView.backgroundColor = AppMainColor;
    photoView.contentMode = UIViewContentModeScaleAspectFill;
    photoView.frame = CGRectMake(20, 10, PHOTO_W, PHOTO_W);
//    [messageView addSubview:photoView];
    self.photoView = photoView;
    
    UILabel *nameLabel = [[UILabel alloc] init];
    nameLabel.text = @"";
    nameLabel.frame = CGRectMake(10,15, SCREEN_Width, 20);
    nameLabel.font = [UIFont systemFontOfSize:17];
    [messageView addSubview:nameLabel];
    self.nameLabel = nameLabel;
    
    CGSize roomTypeBtnSize = [@"标准房" boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size;
    
    UILabel *roomTypeBtn = [[UILabel alloc] init];
//    roomTypeBtn.backgroundColor = AppMainColor;
    roomTypeBtn.frame = CGRectMake(photoView.x, CGRectGetMaxY(nameLabel.frame) + 15, roomTypeBtnSize.width, 20);
    roomTypeBtn.font = [UIFont systemFontOfSize:15];
    roomTypeBtn.textAlignment = NSTextAlignmentLeft;
    roomTypeBtn.text = @"";
    [messageView addSubview:roomTypeBtn];
    self.roomTypeBtn = roomTypeBtn;
    
    UILabel *timeLabel = [[UILabel alloc] init];
    timeLabel.text = @"下单时间:";
    timeLabel.frame = CGRectMake(photoView.x, CGRectGetMaxY(roomTypeBtn.frame) + 15, 200, 20);
    timeLabel.font = [UIFont systemFontOfSize:14];
    timeLabel.textColor = [UIColor lightGrayColor];
    [messageView addSubview:timeLabel];
    self.timeLabel = timeLabel;
    
    UILabel *priceLabel = [[UILabel alloc] init];
    priceLabel.text = @"¥0";
    priceLabel.textColor = AppMainColor;
    priceLabel.textAlignment = NSTextAlignmentLeft;
    priceLabel.frame = CGRectMake(CGRectGetMaxX(roomTypeBtn.frame) + 10, CGRectGetMaxY(nameLabel.frame) + 10, 100, 30);
    priceLabel.font = [UIFont systemFontOfSize:17];
    [messageView addSubview:priceLabel];
    self.priceLabel = priceLabel;
    
    UIView *devider = [[UIView alloc] init];
    devider.backgroundColor = AppLineColor;
    devider.frame = CGRectMake(10, CGRectGetMaxY(photoView.frame) + 10, SCREEN_Width - 20, 1);
    [messageView addSubview:devider];
    
    //下方第二块view
    UIView *commentView = [[UIView alloc] init];
    commentView.frame = CGRectMake(0, CGRectGetMaxY(messageView.frame) + 10, SCREEN_Width, 400);
    commentView.backgroundColor = [UIColor whiteColor];
    [contentScrollView addSubview:commentView];
    self.commentView = commentView;
    
    
    UILabel *commentTitleLabel = [[UILabel alloc] init];
    commentTitleLabel.text = @"酒店评分";
    commentTitleLabel.font = [UIFont systemFontOfSize:15];
    commentTitleLabel.frame = CGRectMake(20, 10, 70, 20);
    [commentView addSubview:commentTitleLabel];
    
    //星级评分
    RatingBar *gradeBar = [[RatingBar alloc] initWithFrame:CGRectMake(CGRectGetMaxX(commentTitleLabel.frame), 5, 120, 30)];
    gradeBar.backgroundColor = [UIColor clearColor];
    gradeBar.delegate = self;
    gradeBar.starNumber = 5.0;
    [commentView addSubview:gradeBar];
    gradeBar.enable = YES;
    self.gradeBar = gradeBar;
    
    UILabel *scoreLabel = [[UILabel alloc] init];
    scoreLabel.text = @"5分";
    scoreLabel.textColor = [UIColor lightGrayColor];
    scoreLabel.frame = CGRectMake(CGRectGetMaxX(gradeBar.frame) + 5, 10, 60, 20);
    [commentView addSubview:scoreLabel];
    self.scoreLabel = scoreLabel;
    
    UIView *deviderTwo = [[UIView alloc] init];
    deviderTwo.backgroundColor = AppLineColor;
    deviderTwo.frame = CGRectMake(10, CGRectGetMaxY(commentTitleLabel.frame) + 10, SCREEN_Width - 20, 1);
    [commentView addSubview:deviderTwo];
    
    IWTextView *textView = [[IWTextView alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(deviderTwo.frame) + 10, SCREEN_Width - 40, 120)];
    textView.placeholder = @"请输入评价内容";
    textView.font = [UIFont systemFontOfSize:15];
    textView.placeholderColor = [UIColor lightGrayColor];
    textView.placeholderLabel.font = [UIFont systemFontOfSize:15];
    textView.tintColor = AppMainColor;
    textView.returnKeyType = UIReturnKeyDone;
    textView.delegate = self;
    [commentView addSubview:textView];
    self.textView = textView;

    UIView *deviderThree = [[UIView alloc] init];
    deviderThree.backgroundColor = AppLineColor;
    deviderThree.frame = CGRectMake(10, CGRectGetMaxY(textView.frame) + 10, SCREEN_Width - 20, 1);
    [commentView addSubview:deviderThree];
    
//    UIButton *addPhotoBtn = [[UIButton alloc] init];
//    addPhotoBtn.backgroundColor = AppMainColor;
//    addPhotoBtn.frame = CGRectMake(20, CGRectGetMaxY(deviderThree.frame) + 10, 30, 30);
//    [addPhotoBtn addTarget:self action:@selector(addPhotoBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    
    HMComposePhotosView *photosViewChatu = [[HMComposePhotosView alloc] init];
    photosViewChatu.imageLimit = 4;
    photosViewChatu.width = SCREEN_Width;
    photosViewChatu.height = 150;
    photosViewChatu.y = CGRectGetMaxY(deviderThree.frame) + 10;
    photosViewChatu.x = 0;
    photosViewChatu.delegate = self;
    photosViewChatu.addOption = ^{
        //        self.isFirstPhoto = NO;
        [self.view endEditing:YES];
        PhotoLibraryView *view = [[PhotoLibraryView alloc] init];
        [view.buttonOne setTitle:@"拍照" forState:UIControlStateNormal];
        [view.buttonOne setTitleColor:Color(68, 68, 68) forState:UIControlStateNormal];
        [view.buttonTwo setTitle:@"从相册中选取" forState:UIControlStateNormal];
        [view.buttonTwo setTitleColor:Color(68, 68, 68) forState:UIControlStateNormal];
        [view.cancle setTitleColor:Color(68, 68, 68) forState:UIControlStateNormal];
        __weak typeof(view) weakView = view;
        view.PhotoOption = ^{
            [weakView coverClick];
            [self openCrema];
        };
        view.LibraryOption = ^{
            [weakView coverClick];
            [self openPictureLibrary];
        };
        [view show];
    };
    self.photosView = photosViewChatu;
    [commentView addSubview:photosViewChatu];
    
    commentView.height = CGRectGetMaxY(deviderThree.frame) + 100;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        contentScrollView.contentSize = CGSizeMake(ScreenWidth, 550);
    });
    
    //提交评价
    UIButton *commitBtn = [[UIButton alloc] init];
    [commitBtn setTitle:@"提交评价" forState:UIControlStateNormal];
    commitBtn.frame = CGRectMake(0, SCREEN_Height - 64 - 60, SCREEN_Width, 60);
    [commitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [commitBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    commitBtn.backgroundColor = AppMainColor;
    commitBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    [commitBtn addTarget:self action:@selector(commitBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:commitBtn];
}
/**
 *  提交评价
 */
- (void)commitBtnClicked
{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    UserAccount *account = [UserAccountTool account];
    [param setObject:account.userId forKey:USERID];
    [param setObject:account.loginToken forKey:TOKEN];
    [param setObject:self.orderID forKey:@"orderId"];
    [param setObject:[NSString stringWithFormat:@"%ld",(long)self.gradeBar.starNumber] forKey:@"startLevel"];
    if (![self.textView.text isEqualToString:@""]) {
        [param setObject:self.textView.text forKey:@"content"];
    }else
    {
        [[Toast makeText:@"请填写评价内容"] show];
        return;
    }
    
    NSMutableArray *imageViewsArray = [self.photosView imageViews];
    if (imageViewsArray.count == 0) {
        [param setObject:@"" forKey:@"photos"];
    }else{
        CommentImageView *firstmageView = imageViewsArray[0];
        NSString *photoPathString = firstmageView.photoPath;
        for (int i = 0; i<imageViewsArray.count; i++) {
            if (i != 0) {
                CommentImageView *imageView = imageViewsArray[i];
                photoPathString = [photoPathString stringByAppendingString:[NSString stringWithFormat:@",%@",imageView.photoPath]];
            }
        }
        
        [param setObject:photoPathString forKey:@"photos"];
    }
    
    
    RTLog(@"param---%@",param);
    
    [RTHttpTool post:ADD_NEW_COMMENT_INFO addHUD:YES param:param success:^(id responseObj) {
        RTLog(@"%@",responseObj);
        if ([responseObj[SUCCESS] intValue] == 1) {
            [[Toast makeText:@"评价上传成功"] show];
            if (self.commentSuccess) {
                self.commentSuccess();
            }
            [self back_clicked];
        }else
        {
            [[Toast makeText:@"评价上传失败"] show];
        }
    } failure:^(NSError *error) {
        
    }];
}
- (void)back_clicked
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/** 打开照相机 */
- (void)openCrema
{
    DJCameraViewController *vc = [DJCameraViewController new];
    vc.operationCancel = ^(UIImage *image){
        
        [RTHttpTool post:UPDATE_COMMENT_PHOTO addHUD:NO param:@{@"orderId":[NSString stringWithFormat:@"%@",self.orderID]} dataBlock:image fileName:@"photo.jpg" success:^(id responseObject) {
            NSLog(@"%@",responseObject);
            if ([responseObject[SUCCESS] intValue] == 1) {
                NSString *string = responseObject[ENTITIES][@"photoPath"];
                [self.photosView addImage:image withPath:string];
                
                [[Toast makeText:@"图片上传成功"] show];
            }else{
                [[Toast makeText:@"图片上传失败"] show];
            }
        } failure:^(NSError *error) {
            NSLog(@"%@",error);
//            [[Toast makeText:@"网络错误"] show];
        }];
    };
    [self presentViewController:vc animated:YES completion:nil];
    
}
/** 打开相册 */
- (void)openPictureLibrary
{
    [self.assetsArray removeAllObjects];
    JKImagePickerController *imagePickerController = [[JKImagePickerController alloc] init];
    //    [imagePickerController.navigationController.navigationBar setBarTintColor:AppMainColor];
    imagePickerController.delegate = self;
    imagePickerController.showsCancelButton = YES;
    imagePickerController.allowsMultipleSelection = YES;
    imagePickerController.minimumNumberOfSelection = 1;
    imagePickerController.maximumNumberOfSelection = 1;
    imagePickerController.selectedAssetArray = self.assetsArray;
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:imagePickerController];
    
    [self presentViewController:navigationController animated:YES completion:NULL];
    
}
- (void)imagePickerController:(JKImagePickerController *)imagePicker didSelectAsset:(JKAssets *)asset isSource:(BOOL)source
{
    [imagePicker dismissViewControllerAnimated:YES completion:^{
        
    }];
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:^{
        
    }];
}
- (void)imagePickerController:(JKImagePickerController *)imagePicker didSelectAssets:(NSArray *)assets isSource:(BOOL)source
{
    
    //    [self.assetsArray removeAllObjects];
    //    imageArray = [NSMutableArray array];
    for (int i = 0; i < assets.count; i++)
    {
        JKAssets  *images = assets[i];
        NSLog(@"%@",images);
        ALAssetsLibrary   *lib = [[ALAssetsLibrary alloc] init];
        [lib assetForURL:images.assetPropertyURL resultBlock:^(ALAsset *asset)
         {
             if (asset)
             {
                 ALAssetRepresentation* representation = [asset defaultRepresentation];
                 int thefx = [representation orientation];
                 NSLog(@"%d",thefx);
                 
                 UIImage *imag = [UIImage imageWithCGImage:[[asset defaultRepresentation] fullResolutionImage]];
                 
                 CGFloat degree = 0;
                 if (thefx == 0) {
                     degree = 0;
                 }
                 else if (thefx == 1) {
                     degree = 180;// M_PI;
                 }
                 else if (thefx == 2) {
                     degree = -90;// -M_PI_2;
                 }
                 else if (thefx == 3) {
                     degree = 90;// M_PI_2;
                 }
                 
                 imag = [imag rotatedByDegrees:degree];
                 
                 
                 
                 CGSize imageSize = imag.size;
                 CGFloat width = imageSize.width;
                 CGFloat height = imageSize.height;
                 
                 CGFloat targetWidth;
                 CGFloat targetHeight;
                 if (width > 1080) {
                     targetWidth = 1080;
                     targetHeight = (targetWidth / width) * height;
                 }
                 else
                 {
                     targetWidth = width;
                     targetHeight = height;
                 }
                 UIGraphicsBeginImageContext(CGSizeMake(targetWidth, targetHeight));
                 [imag drawInRect:CGRectMake(0,0,targetWidth, targetHeight)];
                 UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
                 UIGraphicsEndImageContext();
                 
                 [self.assetsArray addObject:newImage];
             }
         } failureBlock:^(NSError *error)
         {
             
         }];
    }
    assets = nil;
    //    self.getimageArray = [NSMutableArray arrayWithArray:imageArray];
    self.assetsArray = [NSMutableArray arrayWithArray:assets];
    [imagePicker dismissViewControllerAnimated:YES completion:^{
        //上传用户评论头像
        if (self.assetsArray.count ==0) {
            [[Toast makeText:@"本地图片获取失败"] show];
            return;
        }
        UIImage *commentImages = self.assetsArray[0];
        if (commentImages == nil) {
            [[Toast makeText:@"本地图片获取失败"] show];
            return;
        }
        [RTHttpTool post:UPDATE_COMMENT_PHOTO addHUD:NO param:@{@"orderId":[NSString stringWithFormat:@"%@",self.orderID]} dataBlock:commentImages fileName:@"photo.jpg" success:^(id responseObject) {
            NSLog(@"%@",responseObject);
            if ([responseObject[SUCCESS] intValue] == 1) {
                
                NSString *string = responseObject[ENTITIES][@"photoPath"];
                
                [self.photosView addImage:commentImages withPath:string];
                
                NSString *photoPath = [RTHttpTool returnPhotoStringWithString:string];
                NSLog(@"%@",photoPath);
                [[Toast makeText:@"图片上传成功"] show];
                
            }else{
                [[Toast makeText:@"图片上传失败"] show];
            }
        } failure:^(NSError *error) {
            NSLog(@"%@",error);
//            [[Toast makeText:@"网络错误"] show];
        }];
    }];
}
#pragma mark - RatingBarDelegate 
- (void)ratingBar:(RatingBar *)bar didPanToNumber:(NSInteger)number
{
    self.scoreLabel.text = [NSString stringWithFormat:@"%ld分",(long)number];
}
- (void)ratingBar:(RatingBar *)bar didTapToNumber:(NSInteger)number
{
    self.scoreLabel.text = [NSString stringWithFormat:@"%ld分",(long)number];
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@"\n"]){ //判断输入的字是否是回车，即按下return
        //在这里做你响应return键的代码
        [textView resignFirstResponder];
        return NO; //这里返回NO，就代表return键值失效，即页面上按下return，不会出现换行，如果为yes，则输入页面会换行
    }
    return YES;
}
@end
