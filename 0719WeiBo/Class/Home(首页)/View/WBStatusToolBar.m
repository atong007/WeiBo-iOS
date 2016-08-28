//
//  WBStatusToolBar.m
//  0719WeiBo
//
//  Created by 洪龙通 on 16/7/30.
//  Copyright © 2016年 洪龙通. All rights reserved.
//

#import "WBStatusToolBar.h"
#import "WBStatus.h"

@interface WBStatusToolBar()

@property (nonatomic, weak) UIButton *retweetBtn;
@property (nonatomic, weak) UIButton *commentBtn;
@property (nonatomic, weak) UIButton *praiseBtn;

@property (nonatomic, strong) NSMutableArray *buttonsArray;
@property (nonatomic, strong) NSMutableArray *cuttingLineArray;

@end
@implementation WBStatusToolBar

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        // ImageView允许用户点击,上面的子控件才能接收用户点击事件
        self.userInteractionEnabled = YES;
        
        // 设置背景图片
        self.image = [UIImage resizeImageWithName:@"timeline_card_bottom_background"];
        self.highlightedImage = [UIImage resizeImageWithName:@"timeline_card_bottom_background_highlighted"];
        
        // 添加转发按钮
        self.retweetBtn = [self setupSubViewButtonWithTitle:@"转发" image:@"timeline_icon_retweet" bgImage:@"timeline_card_middlebottom_highlighted"];
        
        // 添加评论按钮
        self.commentBtn = [self setupSubViewButtonWithTitle:@"评论" image:@"timeline_icon_comment" bgImage:@"timeline_card_middlebottom_highlighted"];
        
        // 添加点赞按钮
        self.praiseBtn = [self setupSubViewButtonWithTitle:@"点赞" image:@"timeline_icon_unlike" bgImage:@"timeline_card_middlebottom_highlighted"];
        
        // 添加分割线
        [self setupCuttingLine];
        [self setupCuttingLine];

    }
    return self;
}

/**
 *  设置转发评论及点赞按钮
 *
 *  @param title       按钮标题
 *  @param imageName   按钮的内部图标
 *  @param bgImageName 按钮的高亮背景
 *
 */
- (UIButton *)setupSubViewButtonWithTitle:(NSString *)title image:(NSString *)imageName bgImage:(NSString *)bgImageName
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:13.0];
    [button setTitle:title forState:UIControlStateNormal];
    [button setImage:[UIImage resizeImageWithName:imageName] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage resizeImageWithName:bgImageName] forState:UIControlStateHighlighted];
    [self addSubview:button];
    
    [self.buttonsArray addObject:button];
    return button;
}

/**
 *  设置按钮分割线
 */
- (void)setupCuttingLine
{
    UIImageView *cuttingLine = [[UIImageView alloc] init];
    cuttingLine.image = [UIImage imageNamed:@"timeline_card_bottom_line_os7"];
    cuttingLine.highlightedImage = [UIImage imageNamed:@"timeline_card_bottom_line_highlighted_os7"];
    [self addSubview:cuttingLine];
    [self.cuttingLineArray addObject:cuttingLine];
}

- (NSMutableArray *)buttonsArray
{
    if (!_buttonsArray) {
        _buttonsArray = [NSMutableArray array];
    }
    return _buttonsArray;
}

- (NSMutableArray *)cuttingLineArray
{
    if (!_cuttingLineArray) {
        _cuttingLineArray = [NSMutableArray array];
    }
    return _cuttingLineArray;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 分割线的宽度
    CGFloat lineW = 2;
    NSInteger lineCount = self.cuttingLineArray.count;
    
    // 设置按钮的Frame
    CGFloat buttonW = (self.frame.size.width - lineW * lineCount) / self.buttonsArray.count;
    CGFloat buttonH = self.frame.size.height;
    for (int index = 0; index < self.buttonsArray.count; index++) {
        UIButton *button = self.buttonsArray[index];
        CGFloat buttonX = (buttonW + lineW) * index;
        CGFloat buttonY = 0;
        button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
    }
    
    // 设置分割线的Frame
    CGFloat lineY = 0;
    CGFloat lineH = buttonH;
    for (int index = 0; index < self.cuttingLineArray.count; index++) {
        UIImageView *cuttingLine = self.cuttingLineArray[index];
        UIButton *button = self.buttonsArray[index];
        CGFloat lineX = CGRectGetMaxX(button.frame);
        cuttingLine.frame = CGRectMake(lineX, lineY, lineW, lineH);
    }
    
}

- (void)setStatus:(WBStatus *)status
{
    _status = status;

    [self setupSubBtn:self.retweetBtn withOraginalTitle:@"转发" count:status.reposts_count];
    [self setupSubBtn:self.commentBtn withOraginalTitle:@"评论" count:status.comments_count];
    [self setupSubBtn:self.praiseBtn withOraginalTitle:@"点赞" count:status.attitudes_count];
    
}

- (void)setupSubBtn:(UIButton *)button withOraginalTitle:(NSString *)oraginalTitle count:(int)count
{
    if (count) {
        NSString *title = nil;
        if (count < 10000) {
            title = [NSString stringWithFormat:@"%d", count];
        }else {
            float newCount = count / 1000.0 * 0.1;
            title = [NSString stringWithFormat:@"%.2f万", newCount];
            title = [title stringByReplacingOccurrencesOfString:@".0" withString:@""];
        }
        [button setTitle:title forState:UIControlStateNormal];
    }else {
        [button setTitle:oraginalTitle forState:UIControlStateNormal];
    }
}

@end
