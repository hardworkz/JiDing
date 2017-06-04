//
//  HotelOfferModel.m
//  xzb
//
//  Created by 张荣廷 on 16/6/9.
//  Copyright © 2016年 xuwk. All rights reserved.
//

#import "HotelOfferModel.h"

@interface HotelOfferModel ()
{
    NSInteger _index;
}
@end
@implementation HotelOfferModel
- (void)setStarAction:(BOOL)starAction
{
    _starAction = starAction;
    if (starAction) {
        [self attAction];
    }else
    {
        [self.timer invalidate];
        self.timer = nil;
    }
}
- (NSString *)distanceStr
{
    float distanceM = [_distance floatValue] * 1000;
    NSString *string;
    if (distanceM < 1000) {
        string = [NSString stringWithFormat:@"%dm",(int)distanceM];
    }else
    {
        string = [NSString stringWithFormat:@"%.1fkm",[_distance floatValue]];
    }
    
    return string;
}
- (NSString *)name
{
    return [_name stringByRemovingPercentEncoding];
}
- (NSString *)image
{
    return [RTHttpTool returnPhotoStringWithString:_image];
}
- (NSString *)countDown
{
    if ([_countDown integerValue]<=0) {
        _countDown = @"0";
    }
    return _countDown;
}
- (void)attAction
{
    //先停止定时器，防止cell重用问题
    [self.timer invalidate];
    self.timer = nil;
        
    _index = [_countDown intValue] * 60;
    //启动定时器
    NSTimer *testTimer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                                          target:self
                                                        selector:@selector(timeAction:)
                                                        userInfo:nil
                                                         repeats:YES];
    [testTimer fire];//
    [[NSRunLoop currentRunLoop] addTimer:testTimer forMode:NSRunLoopCommonModes];
    self.timer = testTimer;
}
//每隔1秒 调用一次
- (void)timeAction:(NSTimer *)timer
{
    _index--;
    RTLog(@"HotelOfferModel_index = %ld",(long)_index);
    if (_index <= 0) {
        //invalidate  终止定时器
        _countDown = @"0";
        [timer invalidate];
        _timer = nil;
        _index = 0;
    }else{
        _countDown = [NSString stringWithFormat:@"%ld",(long)_index];
    }
}
- (NSString *)seconds
{
    return [NSString stringWithFormat:@"%ld",(long)_index<0?0:_index];
}
@end
