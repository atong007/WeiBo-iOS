//
//  WBStatusTopView.m
//  0719WeiBo
//
//  Created by 洪龙通 on 16/7/31.
//  Copyright © 2016年 洪龙通. All rights reserved.
//

#import "WBStatusTopView.h"
#import "WBStatusFrame.h"
#import "WBStatus.h"
#import "WBUser.h"
#import "WBThumbnailPic.h"
#import "UIImageView+WebCache.h"
#import "WBPicturesView.h"
#import "WBVideoView.h"

@interface WBStatusTopView()

/** 头像 */
@property (nonatomic, weak) UIImageView *iconView;
/** 会员图标 */
@property (nonatomic, weak) UIImageView *vipView;
/** 配图 */
@property (nonatomic, weak) WBPicturesView *pictureView;
/** 昵称 */
@property (nonatomic, weak) UILabel *nameLabel;
/** 时间 */
@property (nonatomic, weak) UILabel *timeLabel;
/** 来源 */
@property (nonatomic, weak) UILabel *sourceLabel;
/** 正文\内容 */
@property (nonatomic, weak) UILabel *contentLabel;
/** 视频 */
//@property (nonatomic, weak) WBVideoView *videoView;

/** 被转发微博的view(父控件) */
@property (nonatomic, weak) UIImageView *retweetView;
/** 被转发微博作者的昵称 */
@property (nonatomic, weak) UILabel *retweetNameLabel;
/** 被转发微博的正文 */
@property (nonatomic, weak) UILabel *retweetContentLabel;
/** 被转发微博的视频 */
@property (nonatomic, weak) WBVideoView *retweetVideoView;
/** 被转发微博的配图 */
@property (nonatomic, weak) WBPicturesView *retweetPictureView;

@end
@implementation WBStatusTopView


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.userInteractionEnabled = YES;
        // 设置背景图片
        self.image = [UIImage resizeImageWithName:@"timeline_card_top_background_os7"];
        self.highlightedImage = [UIImage resizeImageWithName:@"timeline_card_top_background_highlighted_os7"];
        
        // 设置原创微博的子控件
        [self setupOriginalStatusSubViews];
        
        // 设置转发微博的子控件
        [self setupRetweetViewSubviews];
    }
    return self;
}

/**
 *  设置原创微博的子控件
 */
- (void)setupOriginalStatusSubViews
{
    // 头像
    UIImageView *iconView = [[UIImageView alloc] init];
    [self addSubview:iconView];
    self.iconView = iconView;
    
    
    /** 会员图标 */
    UIImageView *vipView = [[UIImageView alloc] init];
    [self addSubview:vipView];
    self.vipView = vipView;
    
    /** 配图 */
    WBPicturesView *pictureView = [[WBPicturesView alloc] init];
    [self addSubview:pictureView];
    self.pictureView = pictureView;
    
    /** 昵称 */
    UILabel *nameLabel = [[UILabel alloc] init];
    nameLabel.font = WBFontOfName;
    nameLabel.backgroundColor = [UIColor clearColor];
    [self addSubview:nameLabel];
    self.nameLabel = nameLabel;
    
    /** 时间 */
    UILabel *timeLabel = [[UILabel alloc] init];
    timeLabel.font = WBFontOfTime;
    timeLabel.textColor = RGBCOLOR(135, 135, 135);
    timeLabel.backgroundColor = [UIColor clearColor];
    [self addSubview:timeLabel];
    self.timeLabel = timeLabel;
    
    /** 来源 */
    UILabel *sourceLabel = [[UILabel alloc] init];
    sourceLabel.font = WBFontOfTime;
    sourceLabel.textColor = RGBCOLOR(135, 135, 135);
    sourceLabel.backgroundColor = [UIColor clearColor];
    [self addSubview:sourceLabel];
    self.sourceLabel = sourceLabel;
    
    /** 正文 */
    UILabel *contentLabel = [[UILabel alloc] init];
    contentLabel.numberOfLines = 0;
    contentLabel.font = WBFontOfContent;
    contentLabel.textColor = RGBCOLOR(39, 39, 39);
    contentLabel.backgroundColor = [UIColor clearColor];
    [self addSubview:contentLabel];
    self.contentLabel = contentLabel;
    
    WBVideoView *videoView = [WBVideoView videoView];
    [self addSubview:videoView];
    self.videoView = videoView;
}

/**
 * 添加中间的View的子控件(转发微博的组成部分)
 */
- (void)setupRetweetViewSubviews
{
    /** 被转发微博的view(父控件) */
    UIImageView *retweetView = [[UIImageView alloc] init];
    retweetView.userInteractionEnabled = YES;
    retweetView.image = [UIImage resizeImageWithName:@"timeline_retweet_background" leftScale:0.9 topScale:0.5];
    [self addSubview:retweetView];
    self.retweetView = retweetView;
    
    /** 被转发微博作者的昵称 */
    UILabel *retweetNameLabel = [[UILabel alloc] init];
    retweetNameLabel.font = WBFontOfRetweetName;
    retweetNameLabel.textColor = RGBCOLOR(67, 107, 163);
    retweetNameLabel.backgroundColor = [UIColor clearColor];
    [self.retweetView addSubview:retweetNameLabel];
    self.retweetNameLabel = retweetNameLabel;
    
    /** 被转发微博的正文 */
    UILabel *retweetContentLabel = [[UILabel alloc] init];
    retweetContentLabel.font = WBFontOfRetweetContent;
    retweetContentLabel.textColor = RGBCOLOR(90, 90, 90);
    retweetContentLabel.backgroundColor = [UIColor clearColor];
    retweetContentLabel.numberOfLines = 0;
    [self.retweetView addSubview:retweetContentLabel];
    self.retweetContentLabel = retweetContentLabel;
    
    /** 被转发微博的视频 */
    WBVideoView *retweetVideoView = [[WBVideoView alloc] init];
    [self.retweetView addSubview:retweetVideoView];
    self.retweetVideoView = retweetVideoView;
    
    /** 被转发微博的配图 */
    WBPicturesView *retweetPictureView = [[WBPicturesView alloc] init];
    [self.retweetView addSubview:retweetPictureView];
    self.retweetPictureView = retweetPictureView;
}

- (void)setStatusFrames:(WBStatusFrame *)statusFrames
{
    _statusFrames = statusFrames;
    
    [self setupTopViewFrames];
    
    [self setupRetweetViewFrames];
}

/**
 *  设置topView内部的Frame
 */
- (void)setupTopViewFrames
{
    WBStatus *status = self.statusFrames.status;
    
    self.iconView.frame = self.statusFrames.iconViewF;
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:status.user.profile_image_url] placeholderImage:[UIImage imageNamed:@"avatar_default"]];
    
    self.nameLabel.frame = self.statusFrames.nameLabelF;
    self.nameLabel.text = status.user.name;
    
    if (status.user.mbrank > 2) {
        self.vipView.hidden = NO;
        self.vipView.frame = self.statusFrames.vipViewF;
        NSString *imageName = [NSString stringWithFormat:@"common_icon_membership_level%d",status.user.mbrank];
        [self.vipView setImage:[UIImage imageNamed:imageName]];
        self.nameLabel.textColor = [UIColor orangeColor];
    }else{
        self.nameLabel.textColor = [UIColor blackColor];
        self.vipView.hidden = YES;
    }
    
    
    self.timeLabel.frame = self.statusFrames.timeLabelF;
    self.timeLabel.text = status.createdTime;
    
    self.sourceLabel.frame = self.statusFrames.sourceLabelF;
    self.sourceLabel.text = status.source;
    
    self.contentLabel.frame = self.statusFrames.contentLabelF;
    self.contentLabel.text = status.text;
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:self.contentLabel.text];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:2];//调整行间距
    
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [self.contentLabel.text length])];
    self.contentLabel.attributedText = attributedString;
    [self.contentLabel sizeToFit];
    
    if ([status.videoStr length] > 0) {
        self.videoView.hidden = NO;
        self.videoView.frame = self.statusFrames.videoViewF;
        self.videoView.videoUrl = status.videoStr;
    }else {
        self.videoView.hidden = YES;
    }
    
    if (status.pic_urls.count) {
        self.pictureView.hidden = NO;
        self.pictureView.frame = self.statusFrames.pictureViewF;
        self.pictureView.picUrls = status.pic_urls;
    }else{
        self.pictureView.hidden = YES;
    }
}

/**
 *  设置转发微博的View的Frame
 */
- (void)setupRetweetViewFrames
{
    WBStatus *retweetStatus = self.statusFrames.status.retweeted_status;
    
    if (retweetStatus) {
        self.retweetView.hidden = NO;
        self.retweetView.frame = self.statusFrames.retweetViewF;
        self.retweetNameLabel.frame = self.statusFrames.retweetNameLabelF;
        self.retweetNameLabel.text = [NSString stringWithFormat:@"@%@", retweetStatus.user.name];
        
        self.retweetContentLabel.frame = self.statusFrames.retweetContentLabelF;
        self.retweetContentLabel.text = retweetStatus.text;
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:self.retweetContentLabel.text];
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        [paragraphStyle setLineSpacing:2];//调整行间距
        
        [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [retweetStatus.text length])];
        self.retweetContentLabel.attributedText = attributedString;
        [self.retweetContentLabel sizeToFit];
        
        if (retweetStatus.pic_urls.count) {
            self.retweetPictureView.hidden = NO;
            self.retweetPictureView.frame = self.statusFrames.retweetPictureViewF;
            self.retweetPictureView.picUrls = retweetStatus.pic_urls;
        }else{
            self.retweetPictureView.hidden = YES;
        }
    }else{
        self.retweetView.hidden = YES;
    }
}

@end
