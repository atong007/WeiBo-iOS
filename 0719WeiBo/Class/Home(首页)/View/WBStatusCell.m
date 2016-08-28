//
//  WBStatusCell.m
//  0719WeiBo
//
//  Created by 洪龙通 on 16/7/28.
//  Copyright © 2016年 洪龙通. All rights reserved.
//

#import "WBStatusCell.h"
#import "WBStatusFrame.h"
#import "WBStatusToolBar.h"
#import "WBStatusTopView.h"

@interface WBStatusCell()

///** 顶部原创微博的主控件View */
//@property (nonatomic, weak) WBStatusTopView *topView;

/** 微博的工具条 */
@property (nonatomic, weak) WBStatusToolBar *statusToolbar;
@end

@implementation WBStatusCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {

        // 1.添加顶部的View的(原创及转发微博的组成部分)
        [self setupTopView];
        
        // 2.添加微博底部的工具栏的子控件
        [self setupStatusToolBar];
    }
    return self;
}

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    
    static NSString *reuseID = @"Home";
    WBStatusCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseID];
    if (cell == nil) {
        cell = [[WBStatusCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseID];
    }
    return cell;
}

/**
 * 添加顶部的View的子控件(原创微博的组成部分)
 */
- (void)setupTopView
{
    self.selectedBackgroundView = [[UIView alloc] init];
    self.backgroundColor = [UIColor clearColor];
    
    // 顶部View父控件
    WBStatusTopView *topView = [[WBStatusTopView alloc] init];
    [self.contentView addSubview:topView];
    self.topView = topView;
}

/**
 * 添加微博底部的工具栏的子控件
 */
- (void)setupStatusToolBar
{
    WBStatusToolBar *statusToolbar = [[WBStatusToolBar alloc] init];
    [self.contentView addSubview:statusToolbar];
    self.statusToolbar = statusToolbar;
}

- (void)setStatusFrames:(WBStatusFrame *)statusFrames
{
    _statusFrames = statusFrames;
    
    // 1.设置顶部的View的Frame(原创微博的组成部分)
    [self setupTopViewFrame];

    // 2.设置每条微博底部的工具栏的Frame
    [self setupStatusToolBarFram];
}

- (void)setFrame:(CGRect)frame
{
//    frame.origin.x = WBStatusMargin;
    frame.origin.y += WBStatusMargin;
//    frame.size.width -= 2 * WBStatusMargin;
    frame.size.height -= WBStatusMargin;
    [super setFrame:frame];
}

/**
 *  设置顶部的View的Frame(原创微博的组成部分)
 */
- (void)setupTopViewFrame
{
    self.topView.frame = self.statusFrames.topViewF;
    self.topView.statusFrames = self.statusFrames;
}

/**
 *  设置每条微博底部的工具栏的Frame
 */
- (void)setupStatusToolBarFram
{
    self.statusToolbar.frame = self.statusFrames.statusToolbarF;
    self.statusToolbar.status = self.statusFrames.status;
}


@end
