//
//  WBArrowSettingItem.m
//  0719WeiBo
//
//  Created by 洪龙通 on 16/8/8.
//  Copyright © 2016年 洪龙通. All rights reserved.
//

#import "WBArrowSettingItem.h"

@implementation WBArrowSettingItem


+ (instancetype)setItemWithTitle:(NSString *)title icon:(NSString *)iconStr andDestViewController:(Class)destClass {
	
    WBArrowSettingItem *item = [self setItemWithTitle:title icon:iconStr];
    item.destClass = destClass;
    return item;
}

+ (instancetype)setItemWithTitle:(NSString *)title andDestViewController:(Class)destClass {
    WBArrowSettingItem *item = [self setItemWithTitle:title icon:nil];
    item.destClass = destClass;
    return item;
}

- (UIView *)accessoryView
{
    return [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"common_icon_arrow"]];
}


@end
