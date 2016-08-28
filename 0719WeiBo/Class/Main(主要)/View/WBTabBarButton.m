//
//  WBTabBarButton.m
//  0719WeiBo
//
//  Created by 洪龙通 on 16/7/19.
//  Copyright © 2016年 洪龙通. All rights reserved.
//

#import "WBTabBarButton.h"
#import "WBBadgeButton.h"

#define WBTabBarButtonScale 0.6

@interface WBTabBarButton()

@property (nonatomic, strong) WBBadgeButton *badgeButton;

@end
@implementation WBTabBarButton

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.imageView.contentMode = UIViewContentModeCenter;
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = [UIFont systemFontOfSize:11.0];
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
        
        WBBadgeButton *badgeBtn = [[WBBadgeButton alloc] init];
        badgeBtn.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleBottomMargin;
        [self addSubview:badgeBtn];
        self.badgeButton = badgeBtn;
    }
    return self;
}

- (void)setHighlighted:(BOOL)highlighted{};

- (void)setTabBarItem:(UITabBarItem *)tabBarItem
{
    _tabBarItem = tabBarItem;
    
    // KVO 监听属性改变
    [tabBarItem addObserver:self forKeyPath:@"badgeValue" options:0 context:nil];
    [tabBarItem addObserver:self forKeyPath:@"title" options:0 context:nil];
    [tabBarItem addObserver:self forKeyPath:@"image" options:0 context:nil];
    [tabBarItem addObserver:self forKeyPath:@"selectedImage" options:0 context:nil];
    
    [self observeValueForKeyPath:nil ofObject:nil change:nil context:nil];
}

/**
 *  监听到某个对象的属性改变了,就会调用
 *
 *  @param keyPath 属性名
 *  @param object  哪个对象的属性被改变
 *  @param change  属性发生的改变
 */
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    [self setTitle:self.tabBarItem.title forState:UIControlStateNormal];
    [self setImage:self.tabBarItem.image forState:UIControlStateNormal];
    [self setImage:self.tabBarItem.selectedImage forState:UIControlStateSelected];
    
    self.badgeButton.badgeValue = self.tabBarItem.badgeValue;
    
    CGFloat badgeX = self.frame.size.width - self.badgeButton.frame.size.width - 5;
    CGFloat badgeY = 5;
    CGRect badgeF = self.badgeButton.frame;
    badgeF.origin.x = badgeX;
    badgeF.origin.y = badgeY;
    self.badgeButton.frame = badgeF;
}

/**
 *  重写button内部image图片显示位置
 *
 *  @return 最终的显示位置
 */
- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGFloat imageW = self.frame.size.width;
    CGFloat imageH = self.frame.size.height * WBTabBarButtonScale;
    
    return CGRectMake(0, 0, imageW, imageH);
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGFloat titleY = contentRect.size.height * WBTabBarButtonScale;
    CGFloat titleW = contentRect.size.width;
    CGFloat titleH = contentRect.size.height - titleY;
    
    return CGRectMake(0, titleY, titleW, titleH);
}

@end
