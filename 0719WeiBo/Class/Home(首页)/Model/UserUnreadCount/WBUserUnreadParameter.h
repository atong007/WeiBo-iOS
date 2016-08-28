//
//  WBUserUnreadParameter.h
//  0719WeiBo
//
//  Created by 洪龙通 on 16/8/4.
//  Copyright © 2016年 洪龙通. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WBParameterBase.h"

@interface WBUserUnreadParameter : WBParameterBase
/*
*  需要查询的用户ID
*/
@property (nonatomic, strong) NSNumber *uid;

@end
