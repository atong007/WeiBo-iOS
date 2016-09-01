//
//  WBVideoUrlAnalysisTool.h
//  0719WeiBo
//
//  Created by 洪龙通 on 16/8/23.
//  Copyright © 2016年 洪龙通. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WBVideoUrlAnalysisTool : UIView

//+ (void)getRealVideoUrlFromOriginalUrl:(NSString *)originalUrl WithBlock:(void(^)(NSString *realVideoUrl))complete;
+ (NSString *)getRealVideoUrlFromOriginalUrl:(NSString *)originalUrl;
+ (void)getLongUrlsFromShortUrls:(NSString *)shortlUrls WithBlock:(void(^)(NSArray *array))complete;

@end
