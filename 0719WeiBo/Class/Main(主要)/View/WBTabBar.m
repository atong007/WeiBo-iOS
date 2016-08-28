//
//  WBTabBar.m
//  0719WeiBo
//
//  Created by 洪龙通 on 16/7/19.
//  Copyright © 2016年 洪龙通. All rights reserved.
//

#import "WBTabBar.h"
#import "WBTabBarButton.h"

@interface WBTabBar()

@property (nonatomic, strong) WBTabBarButton *previousButton;
@property (nonatomic, strong) UIButton *addButton;
@property (nonatomic, strong) NSMutableArray *wbButtonArray;
@end

@implementation WBTabBar

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        UIButton *addButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [addButton setImage:[UIImage imageNamed:@"tabbar_compose_icon_add_os7"] forState:UIControlStateNormal];
        [addButton setImage:[UIImage imageNamed:@"tabbar_compose_icon_add_highlighted_os7"] forState:UIControlStateHighlighted];
        [addButton setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button_os7"] forState:UIControlStateNormal];
        [addButton setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button_highlighted_os7"] forState:UIControlStateHighlighted];
        addButton.bounds = (CGRect){CGPointZero, addButton.currentBackgroundImage.size};
        [addButton addTarget:self action:@selector(addButtonClicked:) forControlEvents:UIControlEventTouchDown];
        [self addSubview:addButton];
        self.addButton = addButton;
    }
    return self;
}

- (NSMutableArray *)wbButtonArray
{
    if (!_wbButtonArray) {
        _wbButtonArray = [NSMutableArray array];
    }
    return _wbButtonArray;
}

- (void)addTabButtonWithTabBarItem:(UITabBarItem *)tabBarItem
{
    WBTabBarButton *button = [[WBTabBarButton alloc] init];
    button.tabBarItem = tabBarItem;
    [button addTarget:self action:@selector(tabBarButtonClicked:) forControlEvents:UIControlEventTouchDown];
    [self addSubview:button];
    [self.wbButtonArray addObject:button];
    
    if (self.wbButtonArray.count == 1) {
        [self tabBarButtonClicked:button];
    }
}

- (void)layoutSubviews
{
    // 一定要加这句！！
    [super layoutSubviews];
    
    /**
     *  调整add按钮的位置
     */
    CGFloat centerX = self.frame.size.width * 0.5;
    CGFloat centerY = self.frame.size.height * 0.5;
    self.addButton.center = CGPointMake(centerX, centerY);
    
    
    CGFloat buttonW = self.frame.size.width / self.subviews.count;
    CGFloat buttonH = self.frame.size.height;
    for (int i = 0; i < self.wbButtonArray.count; i++) {
        WBTabBarButton *button = self.wbButtonArray[i];
        
        CGFloat buttonX = i * buttonW;
        if (i > 1) {
            buttonX += buttonW;
        }
        CGFloat buttonY = 0;
        button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        button.tag = i;
    }
    
}

/**
 *  tabBar栏的四个功能模块按钮
 */
- (void)tabBarButtonClicked:(WBTabBarButton *)button
{
    if ([self.delegate respondsToSelector:@selector(changeViewControllerFrom:to:)]) {
        [self.delegate changeViewControllerFrom:self.previousButton.tag to:button.tag];
    }
    
    button.selected = YES;
    if (button != self.previousButton) {
        self.previousButton.selected = NO;
    }
    self.previousButton = button;
}

/**
 *  底部加号按钮点击
 */
- (void)addButtonClicked:(UIButton *)button
{
    if ([self.delegate respondsToSelector:@selector(sendNewStatus)]) {
        [self.delegate sendNewStatus];
    }
}
@end
