//
//  WBMessageItem.m
//  0719WeiBo
//
//  Created by 洪龙通 on 16/8/26.
//  Copyright © 2016年 洪龙通. All rights reserved.
//

#import "WBMessageItem.h"

@implementation WBMessageItem

- (UIView *)accessoryView
{
    return [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"common_icon_arrow"]];
}

+ (instancetype)setItemWithTitle:(NSString *)title subTitle:(NSString *)subTitle icon:(NSString *)iconStr andDestViewController:(Class)destClass
{
    WBMessageItem *item = [[WBMessageItem alloc] init];
    item.title           = title;
    item.subTitle        = subTitle;
    item.iconStr         = iconStr;
    item.destClass       = destClass;
    return item;
}

+ (instancetype)setItemWithTitle:(NSString *)title icon:(NSString *)iconStr andDestViewController:(Class)destClass
{
    return [self setItemWithTitle:title subTitle:nil icon:iconStr andDestViewController:destClass];
}

@end
