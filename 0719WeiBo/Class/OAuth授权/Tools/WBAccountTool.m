//
//  WBAccountTool.m
//  0719WeiBo
//
//  Created by 洪龙通 on 16/7/26.
//  Copyright © 2016年 洪龙通. All rights reserved.
//

#import "WBAccountTool.h"

#define WBAccountFilePath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"account.data"]
@implementation WBAccountTool

+ (void)saveAccount:(WBAccount *)account {
    
    [NSKeyedArchiver archiveRootObject:account toFile:WBAccountFilePath];
}

+ (WBAccount *)getAccount {
    return [NSKeyedUnarchiver unarchiveObjectWithFile:WBAccountFilePath];
}
@end
