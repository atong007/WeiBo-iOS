//
//  WBAccount.h
//  0719WeiBo
//
//  Created by 洪龙通 on 16/7/26.
//  Copyright © 2016年 洪龙通. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WBAccount : NSObject <NSCoding>

/**
 *  用户授权的唯一票据，用于调用微博的开放接口
 */
@property (nonatomic, copy) NSString *access_token;
/**
 *  access_token的生命周期，单位是秒数
 */
@property (nonatomic, assign) long long remind_in;
/**
 *  access_token的生命周期（该参数即将废弃，开发者请使用expires_in）
 */
@property (nonatomic, assign) long long expires_in;
/**
 *  授权用户的UID
 */
@property (nonatomic, assign) long long uid;
/**
 *  微博用户名
 */
@property (nonatomic, copy) NSString *name;

+ (instancetype)accountWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
@end
