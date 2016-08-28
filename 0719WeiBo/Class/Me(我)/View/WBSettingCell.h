//
//  WBSettingCell.h
//  0719WeiBo
//
//  Created by 洪龙通 on 16/8/8.
//  Copyright © 2016年 洪龙通. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WBSettingItem;
@interface WBSettingCell : UITableViewCell

@property (nonatomic, strong) WBSettingItem *item;

+ (instancetype)setingCellWithTableView:(UITableView *)tableView;
@end
