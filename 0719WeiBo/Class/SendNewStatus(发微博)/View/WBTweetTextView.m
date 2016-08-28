//
//  WBTweetTextView.m
//  0719WeiBo
//
//  Created by 洪龙通 on 16/8/2.
//  Copyright © 2016年 洪龙通. All rights reserved.
//

#import "WBTweetTextView.h"

@interface WBTweetTextView()

@property (nonatomic, weak) UILabel *placeLabel;
@end
@implementation WBTweetTextView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.font = [UIFont systemFontOfSize:16.0];
        UILabel *placeLabel = [[UILabel alloc] init];
        placeLabel.textColor = [UIColor lightGrayColor];
        placeLabel.font = self.font;
        [self addSubview:placeLabel];
        self.placeLabel = placeLabel;
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textValueChange) name:UITextViewTextDidChangeNotification object:nil];
    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)setPlaceholder:(NSString *)placeholder{
   
    self.placeLabel.text = placeholder;
    
    CGFloat labelX = 5;
    CGFloat labelY = 7;
    UIFont *font = self.font;
    NSDictionary *attribute = @{NSFontAttributeName: font};
    CGSize labelS = [placeholder sizeWithAttributes:attribute];
    
    self.placeLabel.frame = (CGRect){labelX, labelY, labelS};
    
}

- (void)textValueChange
{
    self.placeLabel.hidden = self.text.length;
}
@end
