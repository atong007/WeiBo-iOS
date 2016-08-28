//
//  WBTitleView.m
//  0719WeiBo
//
//  Created by 洪龙通 on 16/7/24.
//  Copyright © 2016年 洪龙通. All rights reserved.
//

#import "WBTitleView.h"
#import "UIImage+Extension.h"

#define WBTitleButtonImageW 20

@implementation WBTitleView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        // 高亮时不要调整图标
        self.adjustsImageWhenHighlighted = NO;
        
        self.imageView.contentMode = UIViewContentModeCenter;
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.titleLabel.textAlignment = NSTextAlignmentRight;
        
        [self setBackgroundImage:[UIImage resizeImageWithName:@"navigationbar_filter_background_highlighted"] forState:UIControlStateHighlighted];
    }
    return self;
}

/**
 *  重写button内部image图片显示位置
 *
 *  @return 最终的显示位置
 */
- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGFloat imageW = WBTitleButtonImageW;
    CGFloat imageH = self.frame.size.height;
    CGFloat imageX = self.frame.size.width - imageW;
    
    return CGRectMake(imageX, 0, imageW, imageH);
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGFloat titleW = contentRect.size.width - WBTitleButtonImageW;
    CGFloat titleH = contentRect.size.height;
    
    return CGRectMake(0, 0, titleW, titleH);
}

/**
 *  设置title时调用,通过title的内容来确定长度
 */
- (void)setTitle:(NSString *)title forState:(UIControlState)state
{
    CGRect frame = self.frame;
    NSDictionary *attribute = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:18.0]};
    frame.size.width = [title sizeWithAttributes:attribute].width + WBTitleButtonImageW + 5;
    self.frame = frame;
    [super setTitle:title forState:state];
}

@end
