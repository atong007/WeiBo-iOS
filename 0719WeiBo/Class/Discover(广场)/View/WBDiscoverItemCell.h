//
//  WBDiscoverItemCell.h
//  0719WeiBo
//
//  Created by 洪龙通 on 16/8/10.
//  Copyright © 2016年 洪龙通. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WBDiscoverItem;
@interface WBDiscoverItemCell : UITableViewCell

@property (nonatomic, strong) WBDiscoverItem *item;

+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
