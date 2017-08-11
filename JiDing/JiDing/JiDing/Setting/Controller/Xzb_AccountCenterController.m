//
//  Xzb_AccountCenterController.m
//  xzb
//
//  Created by 张荣廷 on 16/9/13.
//  Copyright © 2016年 xuwk. All rights reserved.
//

#import "Xzb_AccountCenterController.h"

@interface Xzb_AccountCenterController ()

@end

@implementation Xzb_AccountCenterController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }else{
        return 2;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    UserAccount *account = [UserAccountTool account];
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"payPassCell"];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    [cell.textLabel setAppFontWithSize:15];
    if (indexPath.section == 0) {
//        if (indexPath.row == 0) {
//            cell.textLabel.text = @"修改手机号";
//        }else
//        {
//            
//        }
        cell.textLabel.text = @"修改登录密码";
    }else{
        UILabel *bandLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 40)];
        bandLabel.text = @"已绑定";
        bandLabel.textAlignment = NSTextAlignmentRight;
        bandLabel.textColor = [UIColor blackColor];
        
        UILabel *bandLabelB = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 40)];
        bandLabelB.text = @"未绑定";
        bandLabelB.textAlignment = NSTextAlignmentRight;
        bandLabelB.textColor = [UIColor lightGrayColor];
        
        UserAccount *account = [UserAccountTool account];
        
        if (indexPath.row == 0) {
            cell.textLabel.text = @"微信";
            if (account.webchatid.length) {
                cell.accessoryView = bandLabel;
            }else {
                cell.accessoryView = bandLabelB;
            }
        }else if (indexPath.row == 1)
        {
            cell.textLabel.text = @"腾讯QQ";
            if (account.qqid.length) {
                cell.accessoryView = bandLabel;
            }else {
                cell.accessoryView = bandLabelB;
            }
        }
        cell.userInteractionEnabled = NO;
    }
    
    return cell;
}
#pragma mark - table delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
//        if (indexPath.row == 0) {
//            //修改手机号
//            Xzb_AccountSetNewPhoneController *phoneVC = [[Xzb_AccountSetNewPhoneController alloc] init];
//            phoneVC.title = @"修改手机号";
//            phoneVC.view.backgroundColor = AppMainBgColor;
//            [self.navigationController pushViewController:phoneVC animated:YES];
//        }else
//        {
            Xzb_AccountSetNewPwdController *pwdVC = [[Xzb_AccountSetNewPwdController alloc] init];
            pwdVC.title = @"修改登录密码";
            pwdVC.view.backgroundColor = AppMainBgColor;
            [self.navigationController pushViewController:pwdVC animated:YES];
//        }
    }else{
        if (indexPath.row == 0) {
            
        }else if (indexPath.row == 1)
        {
            
        }else{
            
        }
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10.0;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return [[UIView alloc] init];
}
@end
