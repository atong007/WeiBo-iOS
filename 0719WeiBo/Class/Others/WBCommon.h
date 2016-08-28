//
//  WBCommon.h
//  0719WeiBo
//
//  Created by 洪龙通 on 16/8/2.
//  Copyright © 2016年 洪龙通. All rights reserved.
//

#ifndef WBCommon_h
#define WBCommon_h

// 账号相关
#define WBAppKey @"759865578"
#define WBAppSecret @"f0ccb34fb7bb6d68a462339d68320e01"
#define WBRedirectURI @"https://api.weibo.com/oauth2/default.html"
#define WBLoginURL [NSString stringWithFormat:@"https://api.weibo.com/oauth2/authorize?client_id=%@&redirect_uri=%@", WBAppKey, WBRedirectURI]

// 判断设备系统为IOS7及以上
#define IOS7 ([[UIDevice currentDevice].systemVersion doubleValue] >= 7.0)

// 设置RGB颜色
#define RGBCOLOR(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

// 自定义Log
#ifdef DEBUG
#define WBLog(...) NSLog(__VA_ARGS__)
#else
#define WBLog(...)
#endif

#endif /* WBCommon_h */
