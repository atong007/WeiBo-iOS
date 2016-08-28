//
//  WBTweetToolBar.h
//  0719WeiBo
//
//  Created by 洪龙通 on 16/8/3.
//  Copyright © 2016年 洪龙通. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    WBTweetToolbarButtonTypeCamera,
    WBTweetToolbarButtonTypePicture,
    WBTweetToolbarButtonTypeMention,
    WBTweetToolbarButtonTypeTrend,
    WBTweetToolbarButtonTypeEmotion
} WBTweetToolbarButtonType;

@protocol WBTweetToolBarDelegate <NSObject>

- (void)toolBarButtonClicked:(WBTweetToolbarButtonType)tag;
@end

@interface WBTweetToolBar : UIView

@property (nonatomic, weak) id<WBTweetToolBarDelegate> delegate;
@end
