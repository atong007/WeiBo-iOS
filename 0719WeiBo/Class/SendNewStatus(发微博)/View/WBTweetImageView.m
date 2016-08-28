//
//  WBTweetImageView.m
//  0719WeiBo
//
//  Created by 洪龙通 on 16/8/2.
//  Copyright © 2016年 洪龙通. All rights reserved.
//

#import "WBTweetImageView.h"

#define WBImageMargin 5

@implementation WBTweetImageView

//- (instancetype)initWithFrame:(CGRect)frame
//{
//    if (self = [super initWithFrame:frame]) {
//        
//        self.backgroundColor = [UIColor redColor];
//    }
//    return self;
//}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    int maxColumn = 3;
    CGFloat imageW = (self.frame.size.width - WBImageMargin * (maxColumn -1)) / maxColumn;
    CGFloat imageH = imageW;
    for (int index = 0; index < self.subviews.count; index++) {
        UIButton *imageView = self.subviews[index];
        
        int column = index % maxColumn;
        int row = index / maxColumn;
        CGFloat imageX = (imageW + WBImageMargin) * column;
        CGFloat imageY = (imageH + WBImageMargin) * row;
        imageView.frame = CGRectMake(imageX, imageY, imageW, imageH);
        imageView.tag = index;
    }
}

- (void)addImage:(UIImage *)image {
	
    if (image) {
        UIButton *imageView = [[UIButton alloc] init];
        [imageView setBackgroundImage:image forState:UIControlStateNormal];
        [imageView addTarget:self action:@selector(imageTap:) forControlEvents:UIControlEventTouchDown];
        [self addSubview:imageView];
    }
}

- (void)replaceImageInNumber:(int)tag withImage:(UIImage *)image {
    
    UIButton *button = self.subviews[tag];
    button.selected = NO;
    [button setBackgroundImage:image forState:UIControlStateNormal];
}

- (void)imageTap:(UIButton *)image
{
    NSLog(@"view:%d", image.tag);
    if ([self.delegate respondsToSelector:@selector(imageTap:)]) {
        image.selected = YES;
        [self.delegate imageTap:image.tag];
    }
}

- (NSArray *)totalImage {
	
    NSMutableArray *images = [NSMutableArray array];
    for (UIButton *imageView in self.subviews) {
        [images addObject:imageView.currentBackgroundImage];
    }
    return [images copy];
}
@end
