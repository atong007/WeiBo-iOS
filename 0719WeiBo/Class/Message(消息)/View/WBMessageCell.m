//
//  WBMessageCell.m
//  0719WeiBo
//
//  Created by 洪龙通 on 16/8/26.
//  Copyright © 2016年 洪龙通. All rights reserved.
//

#import "WBMessageCell.h"
#import "WBMessageItem.h"

@implementation WBMessageCell

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    
    static NSString *reuseID  = @"Message";
    WBMessageCell *cell  = [tableView dequeueReusableCellWithIdentifier:reuseID];
    if (cell == nil) {
        cell                      = [[WBMessageCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuseID];
        cell.detailTextLabel.font = [UIFont systemFontOfSize:12.0];
    }
    return cell;
}

- (void)setItem:(WBMessageItem *)item
{
    _item = item;
    
    self.textLabel.text       = item.title;
    self.detailTextLabel.text = item.subTitle;
    self.imageView.image      = [UIImage imageNamed:item.iconStr];
    self.accessoryView        = item.accessoryView;
}

//- (void)setFrame:(CGRect)frame
//{
//    frame.origin.x   = 8;
//    frame.size.width -= 2 * 8;
//    [super setFrame:frame];
//}

@end
