//
//  WBTweetToolBar.m
//  0719WeiBo
//
//  Created by 洪龙通 on 16/8/3.
//  Copyright © 2016年 洪龙通. All rights reserved.
//

#import "WBTweetToolBar.h"

#define WBTweetToolBarCount 5

@implementation WBTweetToolBar

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        // 1.设置背景
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageWithName:@"compose_toolbar_background"]];
        
        // 2.添加按钮
        [self addButtonWithIcon:@"compose_camerabutton_background" highlightedIcon:@"compose_camerabutton_background_highlighted" tag:WBTweetToolbarButtonTypeCamera];
        [self addButtonWithIcon:@"compose_toolbar_picture" highlightedIcon:@"compose_toolbar_picture_highlighted" tag:WBTweetToolbarButtonTypePicture];
        [self addButtonWithIcon:@"compose_mentionbutton_background" highlightedIcon:@"compose_mentionbutton_background_highlighted" tag:WBTweetToolbarButtonTypeMention];
        [self addButtonWithIcon:@"compose_trendbutton_background" highlightedIcon:@"compose_trendbutton_background_highlighted" tag:WBTweetToolbarButtonTypeTrend];
        [self addButtonWithIcon:@"compose_emoticonbutton_background" highlightedIcon:@"compose_emoticonbutton_background_highlighted" tag:WBTweetToolbarButtonTypeEmotion];
    }
    return self;
}

- (void)addButtonWithIcon:(NSString *)iconName highlightedIcon:(NSString *)highlightedIcon tag:(int)tag
{
    UIButton *barBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [barBtn setImage:[UIImage imageWithName:iconName] forState:UIControlStateNormal];
    [barBtn setImage:[UIImage imageWithName:highlightedIcon] forState:UIControlStateHighlighted];
    barBtn.tag = tag;
    [barBtn addTarget:self action:@selector(barButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:barBtn];
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    for (int index = 0; index < self.subviews.count; index++) {
        UIButton *button = self.subviews[index];
        
        CGFloat buttonW = self.frame.size.width / self.subviews.count;
        CGFloat buttonH = self.frame.size.height;
        CGFloat buttonX = buttonW * index;
        CGFloat buttonY = 0;
        button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
    }
}

- (void)barButtonClicked:(UIButton *)button
{
    if ([self.delegate respondsToSelector:@selector(toolBarButtonClicked:)]) {
        [self.delegate toolBarButtonClicked:button.tag];
    }
}
@end
