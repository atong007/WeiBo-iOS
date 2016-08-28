//
//  WBParameterBase.m
//  0719WeiBo
//
//  Created by 洪龙通 on 16/8/4.
//  Copyright © 2016年 洪龙通. All rights reserved.
//

#import "WBParameterBase.h"
#import "WBAccountTool.h"
#import "WBAccount.h"

@implementation WBParameterBase

- (instancetype)init
{
    if (self = [super init]) {
        _access_token = [WBAccountTool getAccount].access_token;
    }
    return self;
}

+ (instancetype)parameter {
    return [[self alloc] init];
}
@end
