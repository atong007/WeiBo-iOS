//
//  WBCommonTool.m
//  0719WeiBo
//
//  Created by 洪龙通 on 16/7/26.
//  Copyright © 2016年 洪龙通. All rights reserved.
//

#import "WBCommonTool.h"
#import <UIKit/UIKit.h>
#import "WBNewFeatureViewController.h"
#import "WBTabBarController.h"
#import "MBProgressHUD.h"

@implementation WBCommonTool

/**
 *  选择跳转下一控制器
 */
+ (void)chooseRootViewController {
    NSString *key = @"CFBundleShortVersionString";
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[key];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *lastVersion = [userDefaults objectForKey:key];
    
    if ([currentVersion isEqualToString:lastVersion]) {
        [UIApplication sharedApplication].keyWindow.rootViewController = [[WBTabBarController alloc] init];
    }else{
        [UIApplication sharedApplication].keyWindow.rootViewController = [[WBNewFeatureViewController alloc] init];
        [userDefaults setObject:currentVersion forKey:key];
        [userDefaults synchronize];
    }
}

@end
