//
//  WBHttpTool.m
//  0719WeiBo
//
//  Created by 洪龙通 on 16/8/2.
//  Copyright © 2016年 洪龙通. All rights reserved.
//

#import "WBHttpTool.h"
#import "AFHTTPSessionManager.h"

@implementation WBHttpTool
static AFHTTPSessionManager *_manager = nil;
+ (void)initialize
{
    _manager = [AFHTTPSessionManager manager];
}

+ (void)GETHttpWithURL:(NSString *)URLString parameters:(id)parameters success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    // 网络请求参数
    [_manager GET:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * task, id responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * task, NSError * error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)getVideoAddressWithURL:(NSString *)URLString parameters:(id)parameters success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    [manager POST:URLString parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)POSTHttpWithURL:(NSString *)URLString parameters:(id)parameters success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    [_manager POST:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * task, NSError * error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)POSTHttpWithURL:(NSString *)URLString parameters:(id)parameters formDataArray:(NSArray *)formArray success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    [_manager POST:URLString parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        for (WBFormData *uploadData in formArray) {
            [formData appendPartWithFileData:uploadData.data name:uploadData.name fileName:uploadData.filename mimeType:uploadData.mimeType];
            NSLog(@"name:%@", uploadData.name);
        }
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * task, NSError * error) {
        if (failure) {
            failure(error);
        }
    }];
}
@end


@implementation WBFormData

@end
