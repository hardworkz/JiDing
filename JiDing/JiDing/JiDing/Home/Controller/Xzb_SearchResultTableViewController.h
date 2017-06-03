//
//  Xzb_SearchResultTableViewController.h
//  xzb
//
//  Created by 张荣廷 on 16/6/6.
//  Copyright © 2016年 xuwk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Xzb_SearchResultTableViewController : RootTableViewController
@property (nonatomic,strong) NSString *orderID;
@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic,strong) NSString *addressTimeTypeString;
@end
