//
//  UIBarButtonItem+WB.h
//  0719WeiBo
//
//  Created by 洪龙通 on 16/7/24.
//  Copyright © 2016年 洪龙通. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (WB)

+ (instancetype)initWithIcon:(NSString *)icon highlightedIcon:(NSString *)highlightedIcon target:(id)target action:(SEL)action;

@end