//
//  WBStatusResult.h
//  0719WeiBo
//
//  Created by 洪龙通 on 16/8/4.
//  Copyright © 2016年 洪龙通. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WBStatusResult : NSObject

/**
 *  微博消息集合
 */
@property (nonatomic, copy) NSArray *statuses;
/**
 *  暂不支持
 */
@property (nonatomic, assign) long long previous_cursor;
/**
 *  暂不支持
 */
@property (nonatomic, assign) long long  next_cursor;
/**
 *  微博总条数
 */
@property (nonatomic, assign) long long  total_number;
@end
