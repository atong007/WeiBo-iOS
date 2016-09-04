//
//  WBVideoView.m
//  0719WeiBo
//
//  Created by 洪龙通 on 16/8/9.
//  Copyright © 2016年 洪龙通. All rights reserved.
//

#import "WBVideoView.h"
#import <AVKit/AVKit.h>
#import "WBHttpTool.h"
#import <AVFoundation/AVFoundation.h>
#import "UIImageView+WebCache.h"

@interface WBVideoView() <UIWebViewDelegate>

//@property (nonatomic, strong) AVPlayerLayer *playerLayer;
@property (weak, nonatomic) IBOutlet UIImageView *backImageView;

@end

@implementation WBVideoView

//- (void)capatureImageWithURL:(NSString *)url
//{
//    self.backImageView.image = nil;
//    if (!url) return;
//    
//    AVURLAsset *urlAsset = [AVURLAsset assetWithURL:[NSURL URLWithString:url]];
//    AVAssetImageGenerator *imageGenerator = [AVAssetImageGenerator assetImageGeneratorWithAsset:urlAsset];
//    CMTime time = CMTimeMake(3.0, 1);
//    CMTime actualTime;
//    NSError *error = nil;
//    CGImageRef imageRef = [imageGenerator copyCGImageAtTime:time actualTime:&actualTime error:&error];
//    if (error) {
//        WBLog(@"error:%@", error);
//        return;
//    }
//    CMTimeShow(actualTime);
//    self.backImageView.image = [UIImage imageWithCGImage:imageRef];
//}

- (void)setVideoImage:(NSString *)videoImage
{
    if (videoImage) {
        [self.backImageView sd_setImageWithURL:[NSURL URLWithString:videoImage] placeholderImage:[UIImage imageNamed:@"logo"]];
        [self sendSubviewToBack:self.backImageView];
    }
}

+ (instancetype)videoView {
	
    return [[[NSBundle mainBundle] loadNibNamed:@"WBVideoView" owner:nil options:nil] firstObject];
}

@end
