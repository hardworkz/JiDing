//
//  Xzb_MyOrderMetaModel.h
//  xzb
//
//  Created by rainze on 16/7/25.
//  Copyright © 2016年 xuwk. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 "meta":{"total":14
 ,"totalPage":2
 }
 */

@interface Xzb_MyOrderMetaModel : NSObject

@property(nonatomic, copy) NSString *total;
@property(nonatomic, copy) NSString *totalPage;

@end
