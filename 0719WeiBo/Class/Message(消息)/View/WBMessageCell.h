//
//  WBMessageCell.h
//  0719WeiBo
//
//  Created by 洪龙通 on 16/8/26.
//  Copyright © 2016年 洪龙通. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WBMessageItem;
@interface WBMessageCell : UITableViewCell

@property (nonatomic, strong) WBMessageItem *item;

+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
