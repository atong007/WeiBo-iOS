//
//  WBPicturesView.m
//  0719WeiBo
//
//  Created by 洪龙通 on 16/7/31.
//  Copyright © 2016年 洪龙通. All rights reserved.
//

#import "WBPicturesView.h"
#import "UIImageView+WebCache.h"
#import "WBThumbnailPic.h"
#import "MJPhotoBrowser.h"
#import "MJPhoto.h"
#import "WBPictureView.h"

#define WBImageWH 92
#define WBImageMargin 5
#define WBImageMaxCount 9


@implementation WBPicturesView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        // 初始化9个子控件
        for (int index = 0; index < WBImageMaxCount; index++) {
            WBPictureView *pictureView = [[WBPictureView alloc] init];
            pictureView.tag = index;
            UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageTap:)];
            [pictureView addGestureRecognizer:tapGesture];
            [self addSubview:pictureView];
        }
        
    }
    return self;
}

- (void)imageTap:(UITapGestureRecognizer *)gesture
{
    int count = self.picUrls.count;
    // 设置图片数据
    NSMutableArray *myphotos = [NSMutableArray arrayWithCapacity:count];
    for (int index = 0; index < count; index++) {
        
        MJPhoto *photo = [[MJPhoto alloc] init];
        photo.srcImageView = self.subviews[index];
        
        WBThumbnailPic *image = self.picUrls[index];
        NSString *imageString = [image.thumbnail_pic stringByReplacingOccurrencesOfString:@"thumbnail" withString:@"bmiddle"];
        
        photo.url = [NSURL URLWithString:imageString];
        [myphotos addObject:photo];
    }
    
    MJPhotoBrowser *browser = [[MJPhotoBrowser alloc] init];
    browser.currentPhotoIndex = gesture.view.tag;
    browser.photos = myphotos;
    [browser show];
}

- (void)setPicUrls:(NSArray *)picUrls
{
    _picUrls = picUrls;
    
    int count = (int)picUrls.count;
    
    // 一列最多个数
    int maxColumn = (count == 4)? 2:3;
    
    for (int index = 0; index < self.subviews.count; index++) {
        WBPictureView *pictureView = self.subviews[index];
        // 判断imageView是否需要显示数据
        if (index < count) {
            // 显示图片
            pictureView.hidden = NO;
            pictureView.picture = picUrls[index];
            
            CGFloat imageWH = WBImageWH;
            int column = index % maxColumn;
            int row = index / maxColumn;
            CGFloat imageX = column * (imageWH + WBImageMargin);
            CGFloat imageY = row * (imageWH + WBImageMargin);
            
            pictureView.frame = CGRectMake(imageX, imageY, imageWH, imageWH);
            
            if (count == 1) {
                pictureView.contentMode = UIViewContentModeScaleAspectFit;
                pictureView.clipsToBounds = NO;
            }else{
                pictureView.contentMode = UIViewContentModeScaleAspectFill;
                pictureView.clipsToBounds = YES;
            }
        }else {
            pictureView.hidden = YES;
        }
    }
}

+ (CGSize)sizeOfPicturesViewWithCount:(int)count {
    
    // 一行最多个数
    int maxColumn = (count == 4)? 2 : 3;
    // 总行数
    int row = (count + maxColumn - 1) / maxColumn;
    // 总列数
    int column = (count < 3)? count : maxColumn;
    
    CGFloat pictureW = WBImageWH * column + WBImageMargin * (column - 1);
    CGFloat pictureH = WBImageWH * row + WBImageMargin * (maxColumn - 1);
    return CGSizeMake(pictureW, pictureH);
}
@end
