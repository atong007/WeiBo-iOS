//
//  WBAccountTool.h
//  0719WeiBo
//
//  Created by 洪龙通 on 16/7/26.
//  Copyright © 2016年 洪龙通. All rights reserved.
//

#import <Foundation/Foundation.h>

@class WBAccount;

@interface WBAccountTool : NSObject

/**
 *  将account数据存入文件
 */
+ (void)saveAccount:(WBAccount *)account;

/**
 *  从文件中提取出存储的account数据
 */
+ (WBAccount *)getAccount;
@end
