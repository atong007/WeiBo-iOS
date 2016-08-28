//
//  WBStatusCacheTool.m
//  0719WeiBo
//
//  Created by 洪龙通 on 16/8/6.
//  Copyright © 2016年 洪龙通. All rights reserved.
//

#import "WBStatusCacheTool.h"
#import "FMDB.h"
#import "WBStatusParameter.h"
#import "WBAccountTool.h"
#import "WBAccount.h"
#import "WBStatus.h"

@implementation WBStatusCacheTool

static FMDatabaseQueue *queue;
+ (void)initialize
{
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    path = [path stringByAppendingPathComponent:@"status.sqlite"];
    queue = [FMDatabaseQueue databaseQueueWithPath:path];
    [queue inDatabase:^(FMDatabase *db) {
        BOOL result = [db executeUpdate:@"create table if not exists t_status (id integer primary key autoincrement, idstr text, access_token text, statuses blob)"];
        if (!result) {
            NSLog(@"创建表失败!");
        }
    }];
}

+ (NSArray *)loadLocalStatusCacheWithParams:(WBStatusParameter *)params {
	
    __block NSMutableArray *array;
    [queue inDatabase:^(FMDatabase *db) {
        array = [NSMutableArray array];
        FMResultSet *result = nil;
        if (params.since_id) {
            result = [db executeQuery:@"select statuses from t_status where idstr > ? order by idstr desc limit 0, ?", params.since_id, params.count];
        }else if(params.max_id){
            result = [db executeQuery:@"select statuses from t_status where idstr < ? order by idstr desc limit 0, ?", params.max_id, params.count];
        }else {
            result = [db executeQuery:@"select statuses from t_status order by idstr desc limit 0,?", params.count];
        }
        while (result.next) {
            NSData *data = [result dataForColumn:@"statuses"];
            WBStatus *status = [NSKeyedUnarchiver unarchiveObjectWithData:data];
            [array addObject:status];
        }
    }];
    return array;
}

+ (void)storeStatusToLocalCache:(WBStatus *)status {
	
    [queue inDatabase:^(FMDatabase *db) {
        NSString *accessToken = [WBAccountTool getAccount].access_token;
        NSString *idstr = status.idstr;
        NSData *statusData = [NSKeyedArchiver archivedDataWithRootObject:status];
        BOOL result = [db executeUpdate:@"insert into t_status (idstr, access_token, statuses) values (?, ?, ?)", idstr, accessToken, statusData];
        if (!result) {
            NSLog(@"插入数据失败!");
        }
    }];
}

+ (void)storeStatusesToLocalCache:(NSArray *)statusArray {
	
    for (WBStatus *status in statusArray)
    {
        [self storeStatusToLocalCache:status];
    }
}
@end
