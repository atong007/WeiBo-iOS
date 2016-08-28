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

@interface WBVideoView() <UIWebViewDelegate>

@property (nonatomic, strong) AVPlayerLayer *playerLayer;
@property (nonatomic, copy) NSString *url;
@property (weak, nonatomic) IBOutlet UIImageView *backImageView;

@end

@implementation WBVideoView
@synthesize videoUrl = _videoUrl;

- (void)capatureImageWithURL:(NSString *)url
{
    self.backImageView.image = nil;
    if (!url) return;
    
    AVURLAsset *urlAsset = [AVURLAsset assetWithURL:[NSURL URLWithString:url]];
    AVAssetImageGenerator *imageGenerator = [AVAssetImageGenerator assetImageGeneratorWithAsset:urlAsset];
    CMTime time = CMTimeMake(3.0, 1);
    CMTime actualTime;
    NSError *error = nil;
    CGImageRef imageRef = [imageGenerator copyCGImageAtTime:time actualTime:&actualTime error:&error];
    if (error) {
        WBLog(@"error:%@", error);
        return;
    }
    CMTimeShow(actualTime);
    self.backImageView.image = [UIImage imageWithCGImage:imageRef];
}

- (IBAction)playOrPauseVideo:(UIButton *)sender
{
    
}

//- (void)setupAvPlayer:(NSString *)url
//{
//    [self capatureImageWithURL:url];
//    AVAsset *asset         = [AVAsset assetWithURL:[NSURL URLWithString:url]];
//    AVPlayerItem *item     = [AVPlayerItem playerItemWithAsset:asset];
//    AVPlayer *player       = [AVPlayer playerWithPlayerItem:item];
////    player.volume          = 0;
//    AVPlayerLayer *avLayer = [AVPlayerLayer playerLayerWithPlayer:player];
//    avLayer.frame          = self.bounds;
//    avLayer.videoGravity   = AVLayerVideoGravityResizeAspect;
//    [self.layer addSublayer:avLayer];
//    [player play];
//    self.playerLayer = avLayer;
//}

//- (void)startPlay
//{
//    [self setupAvPlayer:self.url];
//}
//
//- (void)stopPlay
//{
//    [self.playerLayer.player pause];
//    [self.playerLayer removeFromSuperlayer];
//    self.playerLayer = nil;
//}

- (void)setVideoUrl:(NSString *)videoUrl
{
//    _videoUrl = videoUrl;
//    [self capatureImageWithURL:videoUrl];
}

+ (instancetype)videoView {
	
    return [[[NSBundle mainBundle] loadNibNamed:@"WBVideoView" owner:nil options:nil] firstObject];
}

@end
