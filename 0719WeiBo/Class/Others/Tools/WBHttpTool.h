//
//  WBHttpTool.h
//  0719WeiBo
//
//  Created by 洪龙通 on 16/8/2.
//  Copyright © 2016年 洪龙通. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WBHttpTool : NSObject

+ (void)GETHttpWithURL:(NSString *)URLString
            parameters:(id)parameters
               success:(void (^)(id responseObject))success
               failure:(void (^)(NSError *error))failure;

+ (void)getVideoAddressWithURL:(NSString *)URLString
            parameters:(id)parameters
               success:(void (^)(id responseObject))success
               failure:(void (^)(NSError *error))failure;

+ (void)POSTHttpWithURL:(NSString *)URLString
             parameters:(id)parameters
                success:(void (^)(id responseObject))success
                failure:(void (^)(NSError *error))failure;

+ (void)POSTHttpWithURL:(NSString *)URLString
             parameters:(id)parameters
          formDataArray:(NSArray *)formArray
                success:(void (^)(id responseObject))success
                failure:(void (^)(NSError *error))failure;
@end

/**
 *  用来封装文件数据的模型
 */
@interface WBFormData : NSObject
/** 文件数据 */
@property (nonatomic, strong) NSData *data;

/** 参数名 */
@property (nonatomic, copy) NSString *name;

/** 文件名 */
@property (nonatomic, copy) NSString *filename;

/** 文件类型 */
@property (nonatomic, copy) NSString *mimeType;
@end