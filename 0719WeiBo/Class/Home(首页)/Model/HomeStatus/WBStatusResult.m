//
//  WBStatusResult.m
//  0719WeiBo
//
//  Created by 洪龙通 on 16/8/4.
//  Copyright © 2016年 洪龙通. All rights reserved.
//

#import "WBStatusResult.h"
#import "MJExtension.h"
#import "WBStatus.h"

@implementation WBStatusResult

/**
 *  指定array数组里面存储的数据类型,用于将里面的数据转为该数据类型
 *
 */
- (NSDictionary *)objectClassInArray
{
    return @{@"statuses" : [WBStatus class]};
}
@end
