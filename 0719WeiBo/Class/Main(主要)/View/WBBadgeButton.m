//
//  WBBadgeButton.m
//  0719WeiBo
//
//  Created by 洪龙通 on 16/7/20.
//  Copyright © 2016年 洪龙通. All rights reserved.
//

#import "WBBadgeButton.h"
#import "UIImage+Extension.h"

@implementation WBBadgeButton

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.titleLabel.font = [UIFont systemFontOfSize:11.0];
        [self setBackgroundImage:[UIImage resizeImageWithName:@"main_badge_os7"] forState:UIControlStateNormal];
        self.userInteractionEnabled = NO;
        self.hidden = YES;
    }
    return self;
}

- (void)setBadgeValue:(NSString *)badgeValue
{
    _badgeValue = [badgeValue copy];
    
    if (badgeValue && [badgeValue intValue]!= 0) {
        self.hidden = NO;
        CGFloat badgeW = self.currentBackgroundImage.size.width;
        CGFloat badgeH = self.currentBackgroundImage.size.height;
        if (badgeValue.length > 1) {
            NSDictionary *attributeDict = @{NSFontAttributeName: self.titleLabel.font};
            badgeW = [badgeValue sizeWithAttributes:attributeDict].width + 10;
        }
        
        CGRect badgeF = self.frame;
        badgeF.size.width = badgeW;
        badgeF.size.height = badgeH;
        self.frame = badgeF;
        
        [self setTitle:badgeValue forState:UIControlStateNormal];
    }else{
        self.hidden = YES;
    }
    
}

@end
