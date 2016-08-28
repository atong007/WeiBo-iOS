//
//  WBStatusCell.h
//  0719WeiBo
//
//  Created by 洪龙通 on 16/7/28.
//  Copyright © 2016年 洪龙通. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WBStatusFrame, WBStatusTopView;
@interface WBStatusCell : UITableViewCell

/**
 *  status的Frame模型数据
 */
@property (nonatomic, strong) WBStatusFrame *statusFrames;

/** 顶部原创微博的主控件View */
@property (nonatomic, weak) WBStatusTopView *topView;

+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
