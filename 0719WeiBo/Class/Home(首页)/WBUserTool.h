//
//  WBUserTool.h
//  0719WeiBo
//
//  Created by 洪龙通 on 16/8/4.
//  Copyright © 2016年 洪龙通. All rights reserved.
//

#import <Foundation/Foundation.h>

@class WBUserParameter, WBUserResult, WBUserUnreadParameter, WBUserUnreadResult;
@interface WBUserTool : NSObject

/**
 *  加载用户的个人信息
 *
 *  @param param   请求参数
 *  @param success 请求成功后的回调
 *  @param failure 请求失败后的回调
 */
+ (void)getUserDataWithParams:(WBUserParameter *)parameters success:(void (^)(WBUserResult *responseObject))success failure:(void (^)(NSError *error))failure;

/**
 *  加载用户的未读数据
 *
 *  @param param   请求参数
 *  @param success 请求成功后的回调
 *  @param failure 请求失败后的回调
 */
+ (void)getUnreadDataWithParams:(WBUserUnreadParameter *)parameters success:(void (^)(WBUserUnreadResult *responseObject))success failure:(void (^)(NSError *error))failure;

@end
