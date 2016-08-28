//
//  WBStatusParameter.h
//  0719WeiBo
//
//  Created by 洪龙通 on 16/8/4.
//  Copyright © 2016年 洪龙通. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WBParameterBase.h"

@interface WBStatusParameter : WBParameterBase

/**
 *  若指定此参数，则返回ID比since_id大的微博（即比since_id时间晚的微博），默认为0
 */
@property (nonatomic, strong) NSNumber *since_id;
/**
 *  若指定此参数，则返回ID小于或等于max_id的微博，默认为0
 */
@property (nonatomic, strong) NSNumber *max_id;
/**
 *  返回结果的页码，默认为1
 */
@property (nonatomic, strong) NSNumber *count;
/**
 *  过滤类型ID，0：全部、1：原创、2：图片、3：视频、4：音乐，默认为0。
 */
//@property (nonatomic, strong) NSNumber *feature;

@end
