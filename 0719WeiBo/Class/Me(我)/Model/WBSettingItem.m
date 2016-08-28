//
//  WBSettingItem.m
//  0719WeiBo
//
//  Created by 洪龙通 on 16/8/8.
//  Copyright © 2016年 洪龙通. All rights reserved.
//

#import "WBSettingItem.h"

@implementation WBSettingItem

+ (instancetype)setItemWithTitle:(NSString *)title icon:(NSString *)iconStr {
    
    WBSettingItem *item = [[self alloc] init];
    item.title = title;
    item.iconStr = iconStr;
    return item;
}

@end
