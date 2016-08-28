//
//  WBDiscoverHeaderView.m
//  0719WeiBo
//
//  Created by 洪龙通 on 16/8/10.
//  Copyright © 2016年 洪龙通. All rights reserved.
//

#import "WBDiscoverHeaderView.h"
#import "WBDiscoverHeaderItem.h"

@interface WBDiscoverHeaderView()

@property (weak, nonatomic) IBOutlet UIImageView *adImageView;
@property (weak, nonatomic) IBOutlet UIView      *topicView;

@end
@implementation WBDiscoverHeaderView

- (instancetype)init
{
    return [[[NSBundle mainBundle] loadNibNamed:@"WBDiscoverHeaderView" owner:nil options:nil] lastObject];
}

- (void)setItem:(WBDiscoverHeaderItem *)item
{
    _item = item;
    
    self.adImageView.image = [UIImage imageNamed:item.adPicture];
    int i = 0;
    for (int index = 0; index < self.topicView.subviews.count; index++) {
        
        if ([self.topicView.subviews[index] isKindOfClass:[UIButton class]]) {
            UIButton *button = self.topicView.subviews[index];
            [button setTitle:item.topicArray[i++] forState:UIControlStateNormal];
        }
    }
}
@end
