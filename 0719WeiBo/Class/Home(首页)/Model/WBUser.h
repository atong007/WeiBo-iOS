//
//  WBUser.h
//  0719WeiBo
//
//  Created by 洪龙通 on 16/7/26.
//  Copyright © 2016年 洪龙通. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WBUser : NSObject

/**
 *  用户的ID
 */
@property (nonatomic, copy) NSString *idstr;
/**
 *  用户的昵称
 */
@property (nonatomic, copy) NSString *name;
/**
 *  用户的头像
 */
@property (nonatomic, copy) NSString *profile_image_url;

/**
 *  会员标识
 */
@property (nonatomic, assign) int mbrank;
@end
