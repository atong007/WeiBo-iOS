//
//  WBStatusFrame.h
//  0719WeiBo
//
//  Created by 洪龙通 on 16/7/28.
//  assign, readonlyright © 2016年 洪龙通. All rights reserved.
//

#import <Foundation/Foundation.h>

@class WBStatus;

#define WBStatusMargin 5
/** cell的边框宽度 */
#define WBStatusCellBorder 10


#define WBFontOfName [UIFont           systemFontOfSize:17.0]
#define WBFontOfContent [UIFont        systemFontOfSize:16.0]
#define WBFontOfRetweetContent [UIFont systemFontOfSize:15.0]
#define WBFontOfRetweetName            WBFontOfRetweetContent
#define WBFontOfTime [UIFont           systemFontOfSize:12.0]

@interface WBStatusFrame : NSObject

/** 顶部的view */
@property (nonatomic, assign, readonly) CGRect topViewF;
/** 头像 */
@property (nonatomic, assign, readonly) CGRect iconViewF;
/** 会员图标 */
@property (nonatomic, assign, readonly) CGRect vipViewF;
/** 配图 */
@property (nonatomic, assign, readonly) CGRect pictureViewF;
/** 昵称 */
@property (nonatomic, assign, readonly) CGRect nameLabelF;
/** 时间 */
@property (nonatomic, assign, readonly) CGRect timeLabelF;
/** 来源 */
@property (nonatomic, assign, readonly) CGRect sourceLabelF;
/** 正文\内容 */
@property (nonatomic, assign, readonly) CGRect contentLabelF;
/** 微博视频 */
@property (nonatomic, assign, readonly) CGRect videoViewF;
/** 被转发微博的view(父控件) */
@property (nonatomic, assign, readonly) CGRect retweetViewF;
/** 被转发微博作者的昵称 */
@property (nonatomic, assign, readonly) CGRect retweetNameLabelF;
/** 被转发微博的正文\内容 */
@property (nonatomic, assign, readonly) CGRect retweetContentLabelF;
/** 被转发微博的配图 */
@property (nonatomic, assign, readonly) CGRect retweetPictureViewF;

/** 微博的工具条 */
@property (nonatomic, assign, readonly) CGRect statusToolbarF;

/** cell的高度 */
@property (nonatomic, assign, readonly) CGFloat cellHeight;

/**
 *  微博数据模型
 */
@property (nonatomic, strong) WBStatus *status;

@end
