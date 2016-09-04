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
                if ([longUrl containsString:@"video.weibo.com"] ||
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

+ (void)getRealVideoUrlFromOriginalUrl:(NSString *)originalUrl WithBlock:(void (^)(NSString *, NSString *))complete
{
    if ([originalUrl length] <= 1) {
        complete(@"", @"");
    }
    WBLog(@"originalUrl:%@", originalUrl);
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSString *string = [NSString stringWithContentsOfURL:[NSURL URLWithString:originalUrl] encoding:NSUTF8StringEncoding error:NULL];
        if ([originalUrl containsString:@"video.weibo.com"]) {
            NSRange lelfRange  = [string rangeOfString:@"flashvars=\"list="];
            NSRange rightRange = [string rangeOfString:@"&fid="];
            if (lelfRange.location != NSNotFound && rightRange.location != NSNotFound) {
                NSString *videoUrl = [string substringWithRange:NSMakeRange(lelfRange.location + lelfRange.length, rightRange.location - lelfRange.location - lelfRange.length)];
                
                NSRange imageLeftRange  = [string rangeOfString:@"img src = \""];
                NSRange imageRightRange  = [string rangeOfString:@"jpg"];
                if (imageRightRange.location == NSNotFound) {
                    imageRightRange  = [string rangeOfString:@"png"];
                }
                NSString *imageString = @"";
                if (imageLeftRange.location != NSNotFound && imageRightRange.location != NSNotFound) {
                    imageString = [string substringWithRange:NSMakeRange(imageLeftRange.location + imageLeftRange.length, imageRightRange.location + 3 - imageLeftRange.location - imageLeftRange.length)];
                }
                
                complete([videoUrl stringByRemovingPercentEncoding], imageString);
            }else{
                complete(@"", @"");
            }
        }else if ([originalUrl containsString:@"miaopai.com"]){
            NSRange lelfRange = [string rangeOfString:@"scid = \""];
            if (lelfRange.location != NSNotFound) {
                NSString *url = @"http://gslb.miaopai.com/stream/#.mp4";
                NSString *scid = [string substringWithRange:NSMakeRange(lelfRange.location + lelfRange.length, 24)];
                NSRange imageLeftRange  = [string rangeOfString:@"image\" content=\""];
                NSRange imageRightRange  = [string rangeOfString:@"jpg\"/>"];
                if (imageRightRange.location == NSNotFound) {
                    imageRightRange  = [string rangeOfString:@"png\"/>"];
                }
                NSString *imageString = @"";
                if (imageLeftRange.location != NSNotFound && imageRightRange.location != NSNotFound) {
                    imageString = [string substringWithRange:NSMakeRange(imageLeftRange.location + imageLeftRange.length, imageRightRange.location + 3 - imageLeftRange.location - imageLeftRange.length)];
                }
                complete([url stringByReplacingOccurrencesOfString:@"#" withString:scid], imageString);
            }else {
                complete(@"", @"");
            }
        }else {
            complete(@"", @"");
        }
    });
    
}


@end
