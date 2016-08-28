//
//  WBDiscoverHeaderItem.m
//  0719WeiBo
//
//  Created by 洪龙通 on 16/8/10.
//  Copyright © 2016年 洪龙通. All rights reserved.
//

#import "WBDiscoverHeaderItem.h"

@implementation WBDiscoverHeaderItem


+ (instancetype)itemWithAdPicture:(NSString *)picture andTopicArray:(NSArray *)topic {
    
    WBDiscoverHeaderItem *item = [[self alloc] init];
    item.adPicture              = picture;
    item.topicArray             = topic;
    return item;
}
@end
