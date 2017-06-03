//
//  Xzb_BusinessFacilitiesModel.h
//  xzb
//
//  Created by 张荣廷 on 16/7/27.
//  Copyright © 2016年 xuwk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Xzb_BusinessFacilitiesModel : NSObject
@property (nonatomic,strong) NSString *facilitiesID;/**<酒店设施ID*/
@property (nonatomic,strong) NSString *facilitiesImage;/**<酒店设施图片名称*/
@property (nonatomic,strong) NSString *facilitiesImage_no;/**<酒店设施名称-不可用*/
@property (nonatomic,strong) NSString *facilitiesName;/**<酒店设施标题名称*/
@property (nonatomic,assign) BOOL status;/**<酒店设施是否支持状态*/
@end
