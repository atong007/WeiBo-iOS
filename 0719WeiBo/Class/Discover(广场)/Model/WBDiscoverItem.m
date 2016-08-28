//
//  WBDiscoverItem.m
//  0719WeiBo
//
//  Created by 洪龙通 on 16/8/10.
//  Copyright © 2016年 洪龙通. All rights reserved.
//

#import "WBDiscoverItem.h"

@implementation WBDiscoverItem

- (UIView *)accessoryView
{
    return [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"common_icon_arrow"]];
}

+ (instancetype)setItemWithTitle:(NSString *)title subTitle:(NSString *)subTitle icon:(NSString *)iconStr andDestViewController:(Class)destClass
{
    WBDiscoverItem *item = [[WBDiscoverItem alloc] init];
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

+ (instancetype)setItemWithTitle:(NSString *)title andDestViewController:(Class)destClass
{
    return [self setItemWithTitle:title subTitle:nil icon:nil andDestViewController:destClass];
}
@end
