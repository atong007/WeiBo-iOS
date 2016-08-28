//
//  WBUserTool.m
//  0719WeiBo
//
//  Created by 洪龙通 on 16/8/4.
//  Copyright © 2016年 洪龙通. All rights reserved.
//

#import "WBUserTool.h"
#import "WBUserParameter.h"
#import "WBUserResult.h"
#import "WBHttpTool.h"
#import "MJExtension.h"
#import "WBUserUnreadParameter.h"
#import "WBUserUnreadResult.h"

@implementation WBUserTool

+ (void)getUserDataWithParams:(WBUserParameter *)parameters success:(void (^)(WBUserResult *))success failure:(void (^)(NSError *))failure {
	
    [WBHttpTool GETHttpWithURL:@"https://api.weibo.com/2/users/show.json" parameters:parameters.keyValues success:^(id responseObject) {
        WBUserResult *result = [WBUserResult objectWithKeyValues:responseObject];
        success(result);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

+ (void)getUnreadDataWithParams:(WBUserUnreadParameter *)parameters success:(void (^)(WBUserUnreadResult *))success failure:(void (^)(NSError *))failure
{
    [WBHttpTool GETHttpWithURL:@"https://rm.api.weibo.com/2/remind/unread_count.json" parameters:parameters.keyValues success:^(id responseObject) {
        WBUserUnreadResult *result = [WBUserUnreadResult objectWithKeyValues:responseObject];
        success(result);
    } failure:^(NSError *error) {
        failure(error);
    }];
}


@end
