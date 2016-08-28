//
//  WBDiscoverItemCell.m
//  0719WeiBo
//
//  Created by 洪龙通 on 16/8/10.
//  Copyright © 2016年 洪龙通. All rights reserved.
//

#import "WBDiscoverItemCell.h"
#import "WBDiscoverItem.h"

@implementation WBDiscoverItemCell

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    
    static NSString *reuseID  = @"Discover";
    WBDiscoverItemCell *cell  = [tableView dequeueReusableCellWithIdentifier:reuseID];
    if (cell == nil) {
        cell                      = [[WBDiscoverItemCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuseID];
        cell.detailTextLabel.font = [UIFont systemFontOfSize:12.0];
    }
    return cell;
}

- (void)setItem:(WBDiscoverItem *)item
{
    _item = item;
    
    self.textLabel.text       = item.title;
    self.detailTextLabel.text = item.subTitle;
    if (item.iconStr) {
        self.imageView.image      = [UIImage imageNamed:item.iconStr];
    }
    self.accessoryView        = item.accessoryView;
}

- (void)setFrame:(CGRect)frame
{
    frame.origin.x   = 8;
    frame.size.width -= 2 * 8;
    [super setFrame:frame];
}

@end
