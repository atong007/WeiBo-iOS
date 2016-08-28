
//
//  WBNavigationController.m
//  0719WeiBo
//
//  Created by 洪龙通 on 16/7/24.
//  Copyright © 2016年 洪龙通. All rights reserved.
//

#import "WBNavigationController.h"

@implementation WBNavigationController

/**
 *  只在类创建时调用一次
 */
+ (void)initialize
{
    // 1.设置navigationBar的样式
    [self setupNaviBarTheme];
    
    // 2.设置barButton的样式
    [self setupBarButtonTheme];
}

+ (void)setupNaviBarTheme
{
    UIBarButtonItem *buttonItem = [UIBarButtonItem appearance];
    
    buttonItem.tintColor = [UIColor orangeColor];
    NSDictionary *textAttributes = @{NSFontAttributeName: [UIFont systemFontOfSize:15.0]};
    [buttonItem setTitleTextAttributes:textAttributes forState:UIControlStateNormal];
}

+ (void)setupBarButtonTheme
{
    UINavigationBar *naviBar = [UINavigationBar appearance];
    
    NSDictionary *textAttributes = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:18.0]};
    naviBar.titleTextAttributes = textAttributes;
}
@end
