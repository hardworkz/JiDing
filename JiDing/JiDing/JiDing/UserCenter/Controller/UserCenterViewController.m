//
//  UserCenterViewController.m
//  JiDing
//
//  Created by 泡果 on 2017/5/27.
//  Copyright © 2017年 zhangrongting. All rights reserved.
//

#import "UserCenterViewController.h"

@interface UserCenterViewController ()<UITableViewDelegate,UITableViewDataSource,UIViewControllerTransitioningDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) UIImageView *headerView;
@end

@implementation UserCenterViewController
-(instancetype)init{
    if(self = [super init]){
        self.transitioningDelegate = self;
    }
    return self;
}
- (UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.fd_interactivePopDisabled = YES;
    
    self.title = @"我的";
    
    [self.view addSubview:self.tableView];
    
    //侧滑手势
    UISwipeGestureRecognizer *rightSwipe = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(actionAutoBack:)];
    [rightSwipe setDirection:UISwipeGestureRecognizerDirectionRight];
    [self.view addGestureRecognizer:rightSwipe];
}
- (void)actionAutoBack:(UIBarButtonItem *)barItem
{
    [self dismissViewControllerAnimated:YES completion:nil];
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
        DefineWeakSelf
        cell.changeHeader = ^(UIImageView *imageView) {
            weakSelf.headerView = imageView;
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"上传靓照" message:nil preferredStyle: UIAlertControllerStyleActionSheet];
            
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
            UIAlertAction *deleteAction = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
                //打开照相机
                [weakSelf openCrema];
            }];
            UIAlertAction *archiveAction = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                //打开相册
                [weakSelf openPictureLibrary];
            }];
            [alertController addAction:cancelAction];
            [alertController addAction:deleteAction];
            [alertController addAction:archiveAction];
            [weakSelf presentViewController:alertController animated:YES completion:nil];

        };
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else if (indexPath.row == 1) {
        UserCenterOrderCell *cell = [UserCenterOrderCell cellWithTableView:tableView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else {
        UserCenterMessageCell *cell = [UserCenterMessageCell cellWithTableView:tableView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 180;
    }else if (indexPath.row == 1) {
        return 210;
    }else {
        return 200;
    }
}
#pragma mark - table delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        
    }else if (indexPath.row == 1) {
        Xzb_MyOrderViewController *myOrderVC = [[Xzb_MyOrderViewController alloc] init];
        [self.navigationController pushViewController:myOrderVC animated:YES];
    }else {
        
    }
}
#pragma -mark UIViewControllerTransitioningDelegate
-(id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
    return [FourPingTransition transitionWithTransitionType:XWPresentOneTransitionTypePresent];
}

-(id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{
    return [FourPingTransition transitionWithTransitionType:XWPresentOneTransitionTypeDismiss];
}
/** 打开照相机 */
- (void)openCrema
{
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) return;
    
    UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
    ipc.sourceType = UIImagePickerControllerSourceTypeCamera;
    ipc.delegate = self;
    ipc.allowsEditing = YES;
    [self presentViewController:ipc animated:YES completion:nil];
    
}
/** 打开相册 */
- (void)openPictureLibrary
{
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) return;
    
    Xzb_ImagePickerController *ipc = [[Xzb_ImagePickerController alloc] init];
    ipc.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    ipc.delegate = self;
    ipc.allowsEditing = YES;
    [self presentViewController:ipc animated:YES completion:nil];
}
#pragma mark - UIImagePickerController的代理方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    // 0.退出图片选择器
    [picker dismissViewControllerAnimated:YES completion:nil];
    // 1.取出选中的图片
    UIImage *image = info[UIImagePickerControllerEditedImage];
    
    // 2.把图片设置到loginView
    self.headerView.image = image;
    
    UserAccount *account = [UserAccountTool account];
    
    NSString *ID = [NSString stringWithFormat:@"%@",account.userId];
    [RTHttpTool post:UPDATE_PHOTO addHUD:NO param:@{USERID:ID} dataBlock:image fileName:@"photo.jpg" success:^(id responseObject) {
        NSLog(@"%@",responseObject);
        if ([responseObject[SUCCESS] intValue] == 1) {
            account.userPhoto = responseObject[ENTITIES][@"photoPath"];
            [UserAccountTool saveWithAccount:account];
            [[Toast makeText:@"头像上传成功"] show];
            
            //通知替换头像
            [[NSNotificationCenter defaultCenter] postNotificationName:UserUpdateHeadImageNotification object:nil];
        }
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}
@end
