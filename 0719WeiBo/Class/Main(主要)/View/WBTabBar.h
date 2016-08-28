//
//  WBTabBar.h
//  0719WeiBo
//
//  Created by 洪龙通 on 16/7/19.
//  Copyright © 2016年 洪龙通. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol WBTabBarDelegate <NSObject>

- (void)changeViewControllerFrom:(NSInteger)from to:(NSInteger)to;
- (void)sendNewStatus;
@end

@interface WBTabBar : UIView

- (void)addTabButtonWithTabBarItem:(UITabBarItem *)tabBarItem;

@property (nonatomic, weak) id<WBTabBarDelegate> delegate;

@end
