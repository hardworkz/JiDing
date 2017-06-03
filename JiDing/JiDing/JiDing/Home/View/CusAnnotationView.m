//
//  CusAnnotationView.m
//  MAMapKit_static_demo
//
//  Created by songjian on 13-10-16.
//  Copyright (c) 2013年 songjian. All rights reserved.
//

#import "CusAnnotationView.h"
#import "CustomCalloutView.h"

#define kWidth  150.f
#define kHeight 60.f

#define kHoriMargin 5.f
#define kVertMargin 5.f

#define kPortraitWidth  50.f
#define kPortraitHeight 50.f

#define kCalloutWidth   200.0
#define kCalloutHeight  54.0

@interface CusAnnotationView ()

@property (nonatomic, strong) UIImageView *portraitImageView;

@end

@implementation CusAnnotationView

@synthesize calloutView;
@synthesize portraitImageView   = _portraitImageView;
@synthesize nameLabel           = _nameLabel;

#pragma mark - Handle Action

- (void)btnAction
{
    CLLocationCoordinate2D coorinate = [self.annotation coordinate];
    
    NSLog(@"coordinate = {%f, %f}", coorinate.latitude, coorinate.longitude);
}

#pragma mark - Override

- (NSString *)name
{
    return self.nameLabel.text;
}

- (void)setName:(NSString *)name
{
    self.nameLabel.text = name;
}

- (UIImage *)portrait
{
    return self.portraitImageView.image;
}

- (void)setPortrait:(UIImage *)portrait
{
    self.portraitImageView.image = portrait;
}

- (void)setSelected:(BOOL)selected
{
    [self setSelected:selected animated:NO];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    if (self.selected == selected)
    {
        return;
    }
    
    if (selected)
    {
        
        if (self.calloutView == nil)
        {
            /* Construct custom callout. */
            self.calloutView = [[CustomCalloutView alloc] initWithFrame:CGRectMake(0, 0, kCalloutWidth, kCalloutHeight)];
            self.calloutView.center = CGPointMake(CGRectGetWidth(self.bounds) / 2.f + self.calloutOffset.x,
                                                  -CGRectGetHeight(self.calloutView.bounds) / 2.f + self.calloutOffset.y);
            
            //添加气泡子控件
            [self.calloutView addSubview:self.leftBtn];
            [self.calloutView addSubview:self.rightBtn];
            [self.calloutView addSubview:self.nameLabel];
           
        }
        if ([self.annotation.title isEqualToString:@"用户搜索位置"]) {
        }else{
            [self addSubview:self.calloutView];
        }
    }
    else
    {
        [self.calloutView removeFromSuperview];
    }
    
    [super setSelected:selected animated:animated];
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
{
    BOOL inside = [super pointInside:point withEvent:event];
    /* Points that lie outside the receiver’s bounds are never reported as hits, 
     even if they actually lie within one of the receiver’s subviews. 
     This can occur if the current view’s clipsToBounds property is set to NO and the affected subview extends beyond the view’s bounds.
     */
    if (!inside && self.selected)
    {
        inside = [self.calloutView pointInside:[self convertPoint:point toView:self.calloutView] withEvent:event];
    }
    
    return inside;
}

#pragma mark - Life Cycle

- (id)initWithAnnotation:(id<MAAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
    
    if (self)
    {
        self.bounds = CGRectMake(0.f, 0.f, kWidth, kHeight);
//        self.backgroundColor = [UIColor grayColor];
        
        /* Create portrait image view and add to view hierarchy. */
        self.portraitImageView = [[UIImageView alloc] initWithFrame:CGRectMake(kHoriMargin, kVertMargin, kPortraitWidth, kPortraitHeight)];
        [self addSubview:self.portraitImageView];
        
        /* Create name label. */
        UITapGestureRecognizer *Tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(nameLabelTap)];
        
        self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(45,0,110,40)];
        self.nameLabel.backgroundColor  = [UIColor clearColor];
        self.nameLabel.textAlignment    = NSTextAlignmentCenter;
        self.nameLabel.textColor        = [UIColor blackColor];
        self.nameLabel.font             = [UIFont systemFontOfSize:14.f];
        self.nameLabel.textAlignment = NSTextAlignmentCenter;
        self.nameLabel.numberOfLines = 0;
        self.nameLabel.userInteractionEnabled = YES;
        [self.nameLabel addGestureRecognizer:Tap];
        
        _leftBtn = [[UIButton alloc] initWithFrame:CGRectMake(2, 2, 40, 40)];
        _leftBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        _leftBtn.titleLabel.numberOfLines = 0;
        _leftBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        _leftBtn.backgroundColor = AppMainColor;
        _leftBtn.layer.cornerRadius = 20;
        
        _rightBtn = [[Xzb_AnnnotationRightBtn alloc] initWithFrame:CGRectMake(200 - 40 - 2, 2, 40, 40)];
        [_rightBtn setTitle:@"详情" forState:UIControlStateNormal];
        _rightBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        _rightBtn.backgroundColor = AppGreenTextColor;
        _rightBtn.layer.cornerRadius = 20;
        _rightBtn.contentEdgeInsets = UIEdgeInsetsMake(15, 0, 0, 0);
        
        UIImageView *detaionIcon = [[UIImageView alloc] init];
        detaionIcon.image = [UIImage imageNamed:@"酒店列表地图详情"];
        detaionIcon.frame = CGRectMake(0, 1, 40, 20);
        detaionIcon.contentMode = UIViewContentModeCenter;
        [_rightBtn addSubview:detaionIcon];
    }
    
    return self;
}
- (void)nameLabelTap
{
    [[NSNotificationCenter defaultCenter] postNotificationName:TitleLabelTapNotification object:nil userInfo:@{@"rightBtn":self.rightBtn}];
}
@end
