//
//  Xzb_myOrderHandler.h
//  xzb
//
//  Created by rainze on 16/7/20.
//  Copyright © 2016年 xuwk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Xzb_myOrderHandler : NSObject<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) UINavigationController *navigationController;
@property (nonatomic, strong) UIViewController *viewController;

- (instancetype)initWithTableView:(UITableView *)tableView orderType:(NSInteger )orderType;

- (void)beginRefresh;

@end
