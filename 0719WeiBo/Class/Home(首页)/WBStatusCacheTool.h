//
//  WBStatusCacheTool.h
//  0719WeiBo
//
//  Created by 洪龙通 on 16/8/6.
//  Copyright © 2016年 洪龙通. All rights reserved.
//

#import <Foundation/Foundation.h>

@class WBStatusParameter, WBStatus;
@interface WBStatusCacheTool : NSObject

/**
 *  缓存一条微博
 *
 *  @param status 微博数据
 */
+ (void)storeStatusToLocalCache:(WBStatus *)status;

/**
 *  缓存多条微博
 *
 *  @param statusArray 多条微博数据
 */
+ (void)storeStatusesToLocalCache:(NSArray *)statusArray;

/**
 *  获取本地缓存微博
 */
+ (NSArray *)loadLocalStatusCacheWithParams:(WBStatusParameter *)params;
@end
