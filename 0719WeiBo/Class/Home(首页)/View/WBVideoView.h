//
//  WBVideoView.h
//  0719WeiBo
//
//  Created by 洪龙通 on 16/8/9.
//  Copyright © 2016年 洪龙通. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WBVideoView : UIView

@property (weak, nonatomic) IBOutlet UIButton *playOrPauseBtn;
@property (nonatomic, strong) NSString *videoUrl;
+ (instancetype)videoView;
@end
