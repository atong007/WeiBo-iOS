//
//  WBStatusTool.m
//  0719WeiBo
//
//  Created by 洪龙通 on 16/8/4.
//  Copyright © 2016年 洪龙通. All rights reserved.
//

#import "WBStatusTool.h"
#import "WBHttpTool.h"
#import "WBStatusParameter.h"
#import "WBStatusResult.h"
#import "MJExtension.h"
#import "WBTweetStatusParameter.h"
#import "WBTweetStatusResult.h"
#import "WBStatusCacheTool.h"
#import "WBStatus.h"
#import "WBVideoUrlAnalysisTool.h"

@implementation WBStatusTool

+ (void)loadStatusWithParams:(WBStatusParameter *)parameters success:(void (^)(WBStatusResult *))success failure:(void (^)(NSError *))failure {
    
//    NSArray *cache = [WBStatusCacheTool loadLocalStatusCacheWithParams:parameters];
//    
//    if (cache.count) {
//        if (success) {
//            WBStatusResult *result = [[WBStatusResult alloc] init];
//            result.statuses = cache;
//            success(result);
//        }
//        
//    }else{
        [WBHttpTool GETHttpWithURL:@"https://api.weibo.com/2/statuses/home_timeline.json" parameters:parameters.keyValues success:^(id responseObject) {
//            NSLog(@"responseObject:%@", responseObject);
            WBStatusResult *result = [WBStatusResult objectWithKeyValues:responseObject];
            if (result.statuses.count) {
                [self setupVideoURLWith:result.statuses complete:^(NSArray *newStatuses) {
                    result.statuses = newStatuses;
                    
                    [WBStatusCacheTool storeStatusesToLocalCache:result.statuses];
                    success(result);
                }];
            }else {
                success(result);
            }
            
        } failure:^(NSError *error) {
            failure(error);
        }];
//    }
    
}

+ (void)setupVideoURLWith:(NSArray *)statuses complete:(void (^)(NSArray *newStatuses))success
{
    NSString *urlString = @"";
    for (WBStatus *status in statuses) {
        if (status.videoStr) {
            urlString = [urlString stringByAppendingString:[NSString stringWithFormat: @"&url_short=%@",status.videoStr]];
        }
    }
    if ([urlString length] > 1)
    {
        NSMutableArray *newStatuses = [NSMutableArray array];
        [WBVideoUrlAnalysisTool getLongUrlsFromShortUrls:urlString WithBlock:^(NSArray *array)
         {
             int i = 0;
             for (WBStatus *newStatus in statuses) {
                 if ([newStatus.videoStr length] > 1) {
                     newStatus.videoStr = array[i++];
                     if ([newStatus.videoStr length] > 1) {
                         [WBVideoUrlAnalysisTool getRealVideoUrlFromOriginalUrl:newStatus.videoStr WithBlock:^(NSString *realVideoUrl, NSString *newVideoImage) {
                                newStatus.videoStr = realVideoUrl;
                                newStatus.videoImage = newVideoImage;
                         }];
                     }
                 }
                 
                 [newStatuses addObject:newStatus];
             }
             success(newStatuses);
         }];
    }else {
        success(statuses);
    }
}
    
//    {
//        NSString *urlString = @"";
//        for (WBStatus *status in result.statuses) {
//            if (status.videoStr) {
//                urlString = [urlString stringByAppendingString:[NSString stringWithFormat: @"&url_short=%@",status.videoStr]];
//            }
//        }
//        if ([urlString length] > 1)
//        {
//            NSMutableArray *newStatuses = [NSMutableArray array];
//            [WBVideoUrlAnalysisTool getLongUrlsFromShortUrls:urlString WithBlock:^(NSArray *array)
//             {
//                 int i = 0;
//                 for (WBStatus *newStatus in result.statuses) {
//                     if ([newStatus.videoStr length] > 1) {
//                         newStatus.videoStr = array[i++];
//                         if ([newStatus.videoStr length] > 1) {
//                             [WBVideoUrlAnalysisTool getRealVideoUrlFromOriginalUrl:newStatus.videoStr WithBlock:^(NSString *realVideoUrl, NSString *videoImage) {
//                                 newStatus.videoStr = realVideoUrl;
//                                 newStatus.videoImage = videoImage;
//                             }];
//                         }
//                     }
//                     [newStatuses addObject:newStatus];
//                 }
//                 result.statuses = newStatuses;
//                 [WBStatusCacheTool storeStatusesToLocalCache:result.statuses];
//                 success(result);
//             }];
//        }
+ (void)postStatusWithoutPicture:(WBTweetStatusParameter *)parameters success:(void (^)(WBTweetStatusResult *))success failure:(void (^)(NSError *))failure
{
    [WBHttpTool POSTHttpWithURL:@"https://api.weibo.com/2/statuses/update.json" parameters:parameters.keyValues success:^(id responseObject) {
        WBTweetStatusResult *result = [WBTweetStatusResult objectWithKeyValues:responseObject];
        success(result);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

+ (void)postStatusWithPicture:(WBTweetStatusParameter *)parameters formDataArray:(NSArray *)formArray success:(void (^)(WBTweetStatusResult *))success failure:(void (^)(NSError *))failure
{
    [WBHttpTool POSTHttpWithURL:@"https://upload.api.weibo.com/2/statuses/upload.json" parameters:parameters.keyValues formDataArray:formArray success:^(id responseObject) {
        WBTweetStatusResult *result = [WBTweetStatusResult objectWithKeyValues:responseObject];
        success(result);
    } failure:^(NSError *error) {
        failure(error);
    }];
}
@end
