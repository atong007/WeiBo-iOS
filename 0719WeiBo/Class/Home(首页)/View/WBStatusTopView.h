//
//  WBStatusTopView.h
//  0719WeiBo
//
//  Created by 洪龙通 on 16/7/31.
//  Copyright © 2016年 洪龙通. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WBStatusFrame, WBVideoView;
@interface WBStatusTopView : UIImageView

@property (nonatomic, strong) WBStatusFrame *statusFrames;
@property (nonatomic, weak) WBVideoView *videoView;
@end
