//
//  WBMySettingBaseViewController.m
//  0719WeiBo
//
//  Created by 洪龙通 on 16/8/8.
//  Copyright © 2016年 洪龙通. All rights reserved.
//

#import "WBMySettingBaseViewController.h"
#import "WBSettingCell.h"
#import "WBSettingItem.h"

@implementation WBMySettingBaseViewController

- (instancetype)init
{
    return [super initWithStyle:UITableViewStyleGrouped];
}

- (instancetype)initWithStyle:(UITableViewStyle)style
{
    return [super initWithStyle:UITableViewStyleGrouped];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // 设置顶部的空白区域大小
    self.tableView.contentInset = UIEdgeInsetsMake(-20, 0, 0, 0);
    
    // 设置cell组之间的间隙
    self.tableView.sectionFooterHeight = 5;
    self.tableView.sectionHeaderHeight = 5;
    
}

- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

#pragma mark - TableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *array = self.dataArray[section];
    return array.count;
}

/**
 *  tableView cell的设置
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //1.创建cell
    WBSettingCell *cell = [WBSettingCell setingCellWithTableView:tableView];
    
    //2.传递数据模型来设置cell属性
    WBSettingItem *item = self.dataArray[indexPath.section][indexPath.row];
    cell.item = item;
    
    //3.返回cell
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    WBSettingItem *item = self.dataArray[indexPath.section][indexPath.row];
    if (item.destClass) {
        [self.navigationController pushViewController:[[item.destClass alloc] init] animated:YES];
    }
}
@end
