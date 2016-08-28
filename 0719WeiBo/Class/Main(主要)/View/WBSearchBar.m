//
//  WBSearchBar.m
//  0719WeiBo
//
//  Created by 洪龙通 on 16/7/24.
//  Copyright © 2016年 洪龙通. All rights reserved.
//

#import "WBSearchBar.h"
#import "UIImage+Extension.h"

@implementation WBSearchBar


+ (instancetype)searchBar {
    return [[self alloc] init];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.background = [UIImage resizeImageWithName:@"searchbar_textfield_background"];

        // 添加左边放大镜图标
        UIImageView *searchIcon = [[UIImageView alloc] init];
        searchIcon.image = [UIImage imageNamed:@"searchbar_textfield_search_icon"];
        searchIcon.contentMode = UIViewContentModeCenter;
        self.leftView = searchIcon;
        
        self.font = [UIFont systemFontOfSize:12.0];
        self.leftViewMode = UITextFieldViewModeAlways;
        self.clearButtonMode = UITextFieldViewModeWhileEditing;

        // 设置提示文字
        NSDictionary *attributeDict = @{NSForegroundColorAttributeName: [UIColor grayColor]};
        self.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"  搜索" attributes:attributeDict];
        
        // 设置键盘属性
        self.returnKeyType = UIReturnKeySearch;
        self.enablesReturnKeyAutomatically = YES;
    }
    return self;
}

// 重写这个方法是为了调整Placeholder的初始显示位置，如果不写会出现文字和左边icon重叠
- (void)drawPlaceholderInRect:(CGRect)rect {
    CGRect currentRect = rect;
    CGFloat pointX = 20;
    currentRect.origin.x = pointX;
//    [super drawPlaceholderInRect:CGRectMake(0, self.frame.size.height * 0.5 - 1, 0, 0)];
    [super drawPlaceholderInRect:currentRect];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.leftView.frame = CGRectMake(0, 0, self.frame.size.height, self.frame.size.height);
}
@end
