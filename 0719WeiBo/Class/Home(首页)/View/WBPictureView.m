//
//  WBPictureView.m
//  0719WeiBo
//
//  Created by 洪龙通 on 16/7/31.
//  Copyright © 2016年 洪龙通. All rights reserved.
//

#import "WBPictureView.h"
#import "WBThumbnailPic.h"
#import "UIImageView+WebCache.h"

@interface WBPictureView()

@property (nonatomic, weak) UIImageView *gifView;
@end
@implementation WBPictureView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.userInteractionEnabled = YES;
        // 添加gif图标
        UIImage *image = [UIImage imageNamed:@"timeline_image_gif"];
        UIImageView *gifView = [[UIImageView alloc] initWithImage:image];
        [self addSubview:gifView];
        self.gifView = gifView;
    }
    return self;
}

- (void)setPicture:(WBThumbnailPic *)picture
{
    _picture = picture;
    
    self.gifView.hidden = ![picture.thumbnail_pic hasSuffix:@"gif"];

    
    [self sd_setImageWithURL:[NSURL URLWithString:picture.thumbnail_pic] placeholderImage:[UIImage imageWithName:@"timeline_image_placeholder"]];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // anchorPoint(取值0~1)决定的是position在父类中的位置
    self.gifView.layer.anchorPoint = CGPointMake(1, 1);
    self.gifView.layer.position = CGPointMake(self.frame.size.width, self.frame.size.height);
}
@end
