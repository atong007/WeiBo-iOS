//
//  WBParameterBase.h
//  0719WeiBo
//
//  Created by 洪龙通 on 16/8/4.
//  Copyright © 2016年 洪龙通. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WBParameterBase : NSObject

/**
 *  采用OAuth授权方式为必填参数，OAuth授权后获得
 */
@property (nonatomic, copy) NSString *access_token;

+ (instancetype)parameter;
@end
