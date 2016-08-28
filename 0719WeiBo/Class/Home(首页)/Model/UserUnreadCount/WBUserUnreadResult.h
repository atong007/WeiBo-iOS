//
//  WBUserUnreadResult.h
//  0719WeiBo
//
//  Created by 洪龙通 on 16/8/4.
//  Copyright © 2016年 洪龙通. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WBUserUnreadResult : NSObject

/**
 *  新微博未读数
 */
@property (nonatomic, assign) int status;
/**
 *  新粉丝数
 */
@property (nonatomic, assign) int follower;
/**
 *  新评论数
 */
@property (nonatomic, assign) int cmt;
/**
 *  新私信数
 */
@property (nonatomic, assign) int dm;
/**
 *  新提及我的微博数
 */
@property (nonatomic, assign) int mention_cmt;

/**
 *  新提及我的评论数
 */
@property (nonatomic, assign) int mention_status;

/**
 *  消息的总数
 */
- (int)messageCount;
/**
 *  总数
 */
- (int)count;
@end
