//
//  SettingViewController.m
//  JiDing
//
//  Created by 泡果 on 2017/5/27.
//  Copyright © 2017年 zhangrongting. All rights reserved.
//

#import "SettingViewController.h"
#import <UserNotifications/UserNotifications.h>

@interface SettingViewController ()<UITableViewDelegate,UITableViewDataSource,DQAlertViewDelegate,UIViewControllerTransitioningDelegate>
@property (nonatomic,weak)  UITableView *tableView;
@property (nonatomic,assign)  BOOL isOpenPush;//是否打开消息推送
@end

@implementation SettingViewController
-(instancetype)init{
    if(self = [super init]){
        self.transitioningDelegate = self;
    }
    return self;
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if ([[UIDevice currentDevice].systemVersion floatValue]>=8.0f) {
        UIUserNotificationSettings *setting = [[UIApplication sharedApplication] currentUserNotificationSettings];
        if (UIUserNotificationTypeNone == setting.types) {
            RTLog(@"推送关闭");
            self.isOpenPush = NO;
        }else{
            RTLog(@"推送打开");
            self.isOpenPush = YES;
        }
    }else{
        UIRemoteNotificationType type = [[UIApplication sharedApplication] enabledRemoteNotificationTypes];
        if(UIRemoteNotificationTypeNone == type){
            RTLog(@"推送关闭");
            self.isOpenPush = NO;
        }else{
            RTLog(@"推送打开");
            self.isOpenPush = YES;
        }
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.fd_interactivePopDisabled = YES;
    
    self.title = @"设置";
    
    UITableView *tableView = [[UITableView alloc] init];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 49);
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    UIButton *logoutBtn = [[UIButton alloc] init];
    logoutBtn.title = @"退出";
    logoutBtn.frame = CGRectMake(0, SCREEN_Height - 49 - 64, SCREEN_Width, 49);
    logoutBtn.backgroundColor = AppDeepGrayTextColor;
    [logoutBtn addTarget:self action:@selector(logoutBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:logoutBtn];
    
    //侧滑手势
    UISwipeGestureRecognizer *rightSwipe = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(actionAutoBack:)];
    [rightSwipe setDirection:UISwipeGestureRecognizerDirectionRight];
    [self.view addGestureRecognizer:rightSwipe];
}
- (void)actionAutoBack:(UIBarButtonItem *)barItem
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
//退出登录
- (void)logoutBtnClick
{
    //弹窗提示
    DQAlertView *alertView = [[DQAlertView alloc] initWithTitle:@"提示" message:@"确认退出当前的账号？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
    [alertView.otherButton setTitleColor:AppMainColor forState:UIControlStateNormal];
    [alertView show];
}


#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 7;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    SettingCell *cell = [[SettingCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[SettingCell ID]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.row == 0) {
        cell.titleLabel.text = @"账户中心";
        cell.iconView.image = [UIImage imageNamed:@"账户中心"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }else if (indexPath.row == 1) {
        cell.titleLabel.text = @"消息推送";
        cell.iconView.image = [UIImage imageNamed:@"消息推送"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }else if (indexPath.row == 2) {
        cell.titleLabel.text = @"意见反馈";
        cell.iconView.image = [UIImage imageNamed:@"意见反馈"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }else if(indexPath.row == 3){
        cell.titleLabel.text = @"关于我们";
        cell.iconView.image = [UIImage imageNamed:@"关于我们"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }else if(indexPath.row == 4){
        cell.titleLabel.text = @"服务协议";
        cell.iconView.image = [UIImage imageNamed:@"服务协议"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }else if(indexPath.row == 5){
        cell.titleLabel.text = @"帮助中心";
        cell.iconView.image = [UIImage imageNamed:@"帮助中心"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }else if(indexPath.row == 6){
        cell.titleLabel.text = @"清除缓存";
        cell.iconView.image = [UIImage imageNamed:@"清除缓存"];
    }else if(indexPath.row == 7){
        UILabel *version = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
        version.textAlignment = NSTextAlignmentRight;
        version.textColor = [UIColor lightGrayColor];
        version.font = [UIFont systemFontOfSize:15];
        version.text =  [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
        cell.accessoryView = version;
        cell.titleLabel.text = @"软件更新";
        cell.iconView.image = [UIImage imageNamed:@"软件更新"];
    }
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        //账号中心
        Xzb_AccountCenterController *accountCenterVC = [[Xzb_AccountCenterController alloc] init];
        accountCenterVC.title = @"账户中心";
        accountCenterVC.view.backgroundColor = AppLightLineColor;
        [self.navigationController pushViewController:accountCenterVC animated:YES];
    }else if (indexPath.row == 1) {
        //消息推送
        if ([[UIDevice currentDevice].systemVersion floatValue] >= 10.0) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
        }else
        {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"prefs:root=NOTIFICATIONS_ID&path=org.china.xzb"]];
        }
    }else if (indexPath.row == 2) {
        Xzb_FeedBackViewController *feedBack = [[Xzb_FeedBackViewController alloc] init];
        [self.navigationController pushViewController:feedBack animated:YES];
    }else if(indexPath.row == 3){
        //关于我们
//        Xzb_AboutUsViewController *aboutUs = [[Xzb_AboutUsViewController alloc] init];
//        aboutUs.path = [NSString stringWithFormat:@"http://www.chinaxzb.com/static/aboutus.html"];
//        NSLog(@"%@",aboutUs.path);
//        aboutUs.view.backgroundColor = AppMainBgColor;
//        [self.navigationController pushViewController:aboutUs animated:YES];
    }else if(indexPath.row == 4){
        //服务协议
//        Xzb_ServiceAgreementViewController *serviceAgreement = [[Xzb_ServiceAgreementViewController alloc] init];
//        serviceAgreement.path = [NSString stringWithFormat:@"http://www.chinaxzb.com/static/server.html"];
//        serviceAgreement.view.backgroundColor = AppMainBgColor;
//        [self.navigationController pushViewController:serviceAgreement animated:YES];
    }else if(indexPath.row == 5){
        //帮助中心
    }else if(indexPath.row == 6){
        //清理缓存
        [self clearBuffer];
    }
}
#pragma mark - DQAlertViewDelegate
- (void)otherButtonClickedOnAlertView:(DQAlertView *)alertView
{
    if ([alertView.titleLabel.text isEqualToString:@"提示"]) {
        //删除账号
        [UserAccountTool deleteAccountSuccess:^{
            [[NSNotificationCenter defaultCenter] postNotificationName:UserUpdateMessageNotification object:nil];
            [[NSNotificationCenter defaultCenter] postNotificationName:LogoutBySelfNotification object:nil];
            [[Toast makeText:@"退出登录成功~"] show];
            
            LoginViewController *loginVC = [[LoginViewController alloc] init];
            loginVC.view.backgroundColor = [UIColor whiteColor];
            APPDELEGATE.window.rootViewController = [[LoginNavigationController alloc] initWithRootViewController:loginVC];
        } failuer:^{
            [[Toast makeText:@"退出登录失败~"] show];
        }];
    }else if ([alertView.titleLabel.text isEqualToString:@"缓存清理"]) {
        dispatch_async(
                       dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
                       , ^{
                           
                           [[SDImageCache sharedImageCache] cleanDisk];
                           NSString *cachPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
                           NSLog(@"%@", cachPath);
                           
                           NSArray *files = [[NSFileManager defaultManager] subpathsAtPath:cachPath];
                           NSLog(@"files :%lu",(unsigned long)[files count]);
                           for (NSString *p in files) {
                               NSError *error;
                               NSString *path = [cachPath stringByAppendingPathComponent:p];
                               if ([[NSFileManager defaultManager] fileExistsAtPath:path])
                               {
                                   [[NSFileManager defaultManager] removeItemAtPath:path error:&error];
                                   
                               }
                           }
                           [self performSelectorOnMainThread:@selector(clearCacheSuccess) withObject:nil waitUntilDone:YES];});
    }
}

- (void)clearBuffer
{
    NSString *alertViewCtr_str = @"根据缓存文件的大小，清理时间从几秒到几分钟不等，请耐心等待。\n";
    DQAlertView *alert = [[DQAlertView alloc] initWithTitle:@"缓存清理" message:alertViewCtr_str delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定"];
    [alert show];
}
-(void)clearCacheSuccess
{
    NSLog(@"清理成功");
    NSString *alertViewCtr_str = @"缓存清理已完成";
    XWAlerLoginView *xw = [[XWAlerLoginView alloc]initWithTitle:alertViewCtr_str];
    [xw show];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}
#pragma -mark UIViewControllerTransitioningDelegate
-(id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
    return [FourPingTransition transitionWithTransitionType:XWPresentOneTransitionTypePresent];
}

-(id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{
    return [FourPingTransition transitionWithTransitionType:XWPresentOneTransitionTypeDismiss];
}
@end
