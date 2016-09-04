//
//  WBStatus.h
//  0719WeiBo
//
//  Created by 洪龙通 on 16/7/26.
//  Copyright © 2016年 洪龙通. All rights reserved.
//

#import <Foundation/Foundation.h>

@class WBUser;
@interface WBStatus : NSObject

/**
 *  微博的文字
 */
@property (nonatomic, copy) NSString *text;
/**
 *  微博的来源
 */
@property (nonatomic, copy) NSString *source;
/**
 *  微博的ID
 */
@property (nonatomic, copy) NSString *idstr;

/**
 *  微博的创建时间
 */
@property (nonatomic, copy) NSString *created_at;
@property (nonatomic, copy, readonly) NSString *createdTime;
/**
 *  微博的视频地址
 */
@property (nonatomic, copy) NSString *videoStr;
/**
 *  微博的视频缩略图地址
 */
@property (nonatomic, copy) NSString *videoImage;
/**
 *  微博配图的缩略图地址(没有不返回此字段)
 */
//@property (nonatomic, copy) NSString *thumbnail_pic;
@property (nonatomic, copy) NSArray *pic_urls;
/**
 *  微博的转发数
 */
@property (nonatomic, assign) int reposts_count;
/**
 *  微博的评论数
 */
@property (nonatomic, assign) int comments_count;
/**
 *  微博的表态数(被赞数)
 */
@property (nonatomic, assign) int attitudes_count;
/**
 *  微博的作者
 */
@property (nonatomic, strong) WBUser *user;
/**
 *  被转发的原微博信息字段
 */
@property (nonatomic, strong) WBStatus *retweeted_status;

@end
