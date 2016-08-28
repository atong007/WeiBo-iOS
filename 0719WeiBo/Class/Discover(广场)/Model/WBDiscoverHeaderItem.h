//
//  WBDiscoverHeaderItem.h
//  0719WeiBo
//
//  Created by 洪龙通 on 16/8/10.
//  Copyright © 2016年 洪龙通. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WBDiscoverHeaderItem : NSObject

/**
 *  广告图
 */
@property (nonatomic, copy) NSString *adPicture;
/**
 *  四个热门话题
 */
@property (nonatomic, copy) NSArray *topicArray;

+ (instancetype)itemWithAdPicture:(NSString *)picture andTopicArray:(NSArray *)topic;

@end
