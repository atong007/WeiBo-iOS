//
//  WBSwitchSettingItem.m
//  0719WeiBo
//
//  Created by 洪龙通 on 16/8/8.
//  Copyright © 2016年 洪龙通. All rights reserved.
//

#import "WBSwitchSettingItem.h"

@implementation WBSwitchSettingItem

- (UIView *)accessoryView
{
    return [[UISwitch alloc] init];
}

+ (instancetype)setItemWithTitle:(NSString *)title {
    return [self setItemWithTitle:title icon:nil];
}
@end
