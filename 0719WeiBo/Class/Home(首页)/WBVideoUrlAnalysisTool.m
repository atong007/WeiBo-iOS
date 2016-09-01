//
//  WBVideoUrlAnalysisTool.m
//  0719WeiBo
//
//  Created by 洪龙通 on 16/8/23.
//  Copyright © 2016年 洪龙通. All rights reserved.
//

#import "WBVideoUrlAnalysisTool.h"
#import "WBHttpTool.h"
#import "AFNetworking.h"


@interface WBVideoUrlAnalysisTool() <UIWebViewDelegate>

@property (nonatomic, strong) NSString *loadedUrl;

@end
@implementation WBVideoUrlAnalysisTool

+ (void)getLongUrlsFromShortUrls:(NSString *)shortlUrls WithBlock:(void(^)(NSArray *))complete
{
    NSString *urlString = [NSString stringWithFormat:@"https://api.weibo.com/2/short_url/expand.json?access_token=2.00lrCmxB07k_7pc685aae2ff0V9yee%@", shortlUrls];
    
    [WBHttpTool GETHttpWithURL:urlString parameters:nil success:^(id responseObject) {
        
        NSMutableArray *videoUrlsArray = [NSMutableArray array];
        for (NSDictionary *dict in responseObject[@"urls"]) {
            if ([dict[@"result"] boolValue] == YES && [dict[@"type"] intValue] == 39){
                NSString *longUrl = dict[@"url_long"];
                if ([longUrl containsString:@"weibo.com"] ||
                    [longUrl containsString:@"miaopai.com"] ||
                    [longUrl containsString:@"vlook"] ||
                    [longUrl containsString:@"xiaokaxiu"]) {
                    [videoUrlsArray addObject:longUrl];
                }else{
                    [videoUrlsArray addObject:@""];
                }
            }else {
                [videoUrlsArray addObject:@""];
            }
        }
        complete(videoUrlsArray);
        
    } failure:^(NSError *error) {
        complete(nil);
        NSLog(@"GET long Url error:%@", error);
    }];
}

+ (NSString *)getRealVideoUrlFromOriginalUrl:(NSString *)originalUrl
{
    if ([originalUrl length] <= 1) {
        return @"";
    }
    NSString *string = [NSString stringWithContentsOfURL:[NSURL URLWithString:originalUrl] encoding:NSUTF8StringEncoding error:NULL];
    
    NSRange lelfRange  = [string rangeOfString:@"flashvars=\"list="];
    NSRange rightRange = [string rangeOfString:@"&fid="];
    if (lelfRange.location != NSNotFound && rightRange.location != NSNotFound) {
        NSString *videoUrl = [string substringWithRange:NSMakeRange(lelfRange.location + lelfRange.length, rightRange.location - lelfRange.location - lelfRange.length)];
        return [videoUrl stringByRemovingPercentEncoding];
    }else{
        return @"";
    }
    
}

@end
