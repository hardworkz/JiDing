//
//  Xzb_MyorderHeadView.m
//  xzb
//
//  Created by rainze on 16/7/20.
//  Copyright © 2016年 xuwk. All rights reserved.
//

#import "Xzb_MyorderHeadView.h"

@interface Xzb_MyorderHeadView ()

@property (nonatomic, strong) NSMutableArray *buttons;
@property (nonatomic, strong) UIView *bottomLine;
@property (nonatomic, weak) UIButton *currentButton;
@property (nonatomic, strong) UIView *line;

@end

@implementation Xzb_MyorderHeadView

- (instancetype)initWithTitles:(NSArray *)titles
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.buttons = [NSMutableArray arrayWithCapacity:titles.count];
        NSUInteger index = 0;
        CGFloat buttonW = self.width / titles.count;
        
        for (NSString *buttonTitle in titles) {
            UIButton *button = [UIButton new];
            [button setTitle:buttonTitle forState:UIControlStateNormal];
            button.titleLabel.font = [UIFont systemFontOfSize:14];
            [button setTitleColor:AppGrayTextColor forState:UIControlStateNormal];
            [button setTitleColor:AppGreenTextColor forState:UIControlStateHighlighted];
            [button setTitleColor:AppGreenTextColor forState:UIControlStateSelected];
            button.frame = CGRectMake(index * buttonW, 0, buttonW, self.height);
//            button.titleLabel.font = [UIFont systemFontOfSize:R_H(16)];
            button.tag = index;
            button.titleLabel.textAlignment = NSTextAlignmentCenter;
            [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
            
            
            [self addSubview:button];
            [self.buttons addObject:button];
            index++;
        }
        //设置默认选中的按钮
        self.selectIndex = 0;
        //添加底部线
        [self addSubview:self.line];
        [self addSubview:self.bottomLine];
        
    }
    return self;
}

- (UIView *)bottomLine
{
    if (!_bottomLine) {
        _bottomLine  = [UIView new];
        _bottomLine.backgroundColor = AppGreenTextColor;
    }
    return _bottomLine;
}

- (UIView *)line
{
    if (!_line) {
        _line  = [UIView new];
        _line.backgroundColor = AppLightLineColor;
    }
    return _line;
}

- (void)setSelectIndex:(NSUInteger)selectIndex
{
    if (selectIndex > 4) {
        return;
    }
    _selectIndex = selectIndex;
    UIButton *button = self.buttons[_selectIndex];
    if (_currentButton != button) {
        _currentButton.selected = NO;
        _currentButton = button;
        _currentButton.selected = YES;
        //移动底部view
        [self animationMoveBottomLine];
        if (self.buttonSelect) {
            self.buttonSelect(button.tag);
        }
    }
}

- (void)buttonClick:(UIButton *)button {
    if (self.selectIndex != button.tag) {
        self.selectIndex = button.tag;
    }
    UIButton *selectButton = _buttons[button.tag];
    if (_currentButton != selectButton) {
        _currentButton.selected = NO;
        _currentButton.selected = NO;
        _currentButton = selectButton;
        _currentButton.selected = YES;
        //移动底部view
        [self animationMoveBottomLine];
        if (self.buttonSelect) {
            self.buttonSelect(button.tag);
        }
    }
    
}

- (void)animationMoveBottomLine
{
    [UIView animateWithDuration:0.25 animations:^{
        self.bottomLine.centerX = _currentButton.centerX;
    }];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    for (NSInteger index = 0; index < self.buttons.count; index++) {
        UIButton *button = self.buttons[index];
        button.frame = CGRectMake(index * ScreenWidth / self.buttons.count, 0, ScreenWidth / self.buttons.count, self.height);
    }
    _line.frame = CGRectMake(0, self.height - 1, SCREEN_Width, 1);
    self.bottomLine.size = CGSizeMake(ScreenWidth / self.buttons.count, 2);
    self.bottomLine.bottom = self.bottom;
    self.bottomLine.centerX = _currentButton.centerX;
}

@end
