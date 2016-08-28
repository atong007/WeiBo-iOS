//
//  WBTweetImageView.h
//  0719WeiBo
//
//  Created by 洪龙通 on 16/8/2.
//  Copyright © 2016年 洪龙通. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol WBTweetImageViewDelegate <NSObject>

- (void)imageTap:(int)tag;

@end
@interface WBTweetImageView : UIView

@property (nonatomic, weak) id<WBTweetImageViewDelegate> delegate;
- (void)addImage:(UIImage *)image;
- (void)replaceImageInNumber:(int)tag withImage:(UIImage *)image;
- (NSArray *)totalImage;

@end
