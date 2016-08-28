//
//  WBStatusTool.h
//  0719WeiBo
//
//  Created by 洪龙通 on 16/8/4.
//  Copyright © 2016年 洪龙通. All rights reserved.
//

#import <Foundation/Foundation.h>

@class WBStatusParameter, WBStatusResult, WBTweetStatusParameter, WBTweetStatusResult;
@interface WBStatusTool : NSObject

/**
 *  加载微博数据
 *
 *  @param param   请求参数
 *  @param success 请求成功后的回调
 *  @param failure 请求失败后的回调
 */
+ (void)loadStatusWithParams:(WBStatusParameter *)parameters success:(void (^)(WBStatusResult *responseObject))success failure:(void (^)(NSError *error))failure;

/**
*  发送不带图片微博数据
*
*  @param param   请求参数
*  @param success 请求成功后的回调
*  @param failure 请求失败后的回调
*/
+ (void)postStatusWithoutPicture:(WBTweetStatusParameter *)parameters success:(void (^)(WBTweetStatusResult *responseObject))success failure:(void (^)(NSError *error))failure;

/**
 *  发送带有图片的微博数据
 *
 *  @param param   请求参数
 *  @param success 请求成功后的回调
 *  @param failure 请求失败后的回调
 */
+ (void)postStatusWithPicture:(WBTweetStatusParameter *)parameters formDataArray:(NSArray *)formArray  success:(void (^)(WBTweetStatusResult *responseObject))success failure:(void (^)(NSError *error))failure;
@end
