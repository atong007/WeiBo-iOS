//
//  WBDiscoverItem.h
//  0719WeiBo
//
//  Created by 洪龙通 on 16/8/10.
//  Copyright © 2016年 洪龙通. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WBDiscoverItem : NSObject

/**
 *  图标
 */
@property (nonatomic, copy) NSString *iconStr;
/**
 *  标题
 */
@property (nonatomic, copy) NSString *title;
/**
 *  子标题
 */
@property (nonatomic, copy) NSString *subTitle;
/**
 *  cell右侧的view
 */
@property (nonatomic, strong, readonly) UIView *accessoryView;
/**
 *  cell跳转后的目标控制器
 */
@property (nonatomic, assign) Class destClass;

+ (instancetype)setItemWithTitle:(NSString *)title subTitle:(NSString *)subTitle icon:(NSString *)iconStr andDestViewController:(Class)destClass;
+ (instancetype)setItemWithTitle:(NSString *)title icon:(NSString *)iconStr andDestViewController:(Class)destClass;
+ (instancetype)setItemWithTitle:(NSString *)title andDestViewController:(Class)destClass;
@end
