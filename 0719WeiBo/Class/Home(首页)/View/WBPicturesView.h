//
//  WBPicturesView.h
//  0719WeiBo
//
//  Created by 洪龙通 on 16/7/31.
//  Copyright © 2016年 洪龙通. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WBPicturesView : UIView

@property (nonatomic, copy) NSArray *picUrls;

+ (CGSize)sizeOfPicturesViewWithCount:(int)count;
@end
