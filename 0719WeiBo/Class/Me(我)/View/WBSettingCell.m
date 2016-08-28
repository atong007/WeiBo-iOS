//
//  WBSettingCell.m
//  0719WeiBo
//
//  Created by 洪龙通 on 16/8/8.
//  Copyright © 2016年 洪龙通. All rights reserved.
//

#import "WBSettingCell.h"
#import "WBSettingItem.h"

@implementation WBSettingCell


+ (instancetype)setingCellWithTableView:(UITableView *)tableView {
    static NSString *reuseID = @"Me";
    WBSettingCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseID];
    if (cell == nil) {
        cell = [[WBSettingCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseID];
    }
    return cell;
}

- (void)setItem:(WBSettingItem *)item
{
    _item = item;
    
    self.textLabel.text = item.title;
    if (item.iconStr) {
        self.imageView.image = [UIImage imageNamed:item.iconStr];
    }
    self.accessoryView = item.accessoryView;
    
}
@end
