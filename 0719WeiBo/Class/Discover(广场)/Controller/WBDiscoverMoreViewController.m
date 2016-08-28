//
//  WBDiscoverMoreViewController.m
//  0719WeiBo
//
//  Created by 洪龙通 on 16/8/10.
//  Copyright © 2016年 洪龙通. All rights reserved.
//

#import "WBDiscoverMoreViewController.h"
#import "WBDiscoverItem.h"
#import "WBDiscoverItemCell.h"

@interface WBDiscoverMoreViewController()

@property (nonatomic, copy) NSArray *dataArray;
@end

@implementation WBDiscoverMoreViewController

- (instancetype)init{
    return [super initWithStyle:UITableViewStyleGrouped];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.contentInset        = UIEdgeInsetsMake(-20, 0, 0, 0);
    self.tableView.sectionFooterHeight = 5;
    self.tableView.sectionHeaderHeight = 5;
}

- (NSArray *)dataArray
{
    if (!_dataArray) {
        WBDiscoverItem *goods     = [WBDiscoverItem setItemWithTitle:@"热门商品" andDestViewController:nil];
        WBDiscoverItem *lottery   = [WBDiscoverItem setItemWithTitle:@"彩票" andDestViewController:nil];
        WBDiscoverItem *food      = [WBDiscoverItem setItemWithTitle:@"美食" andDestViewController:nil];
        WBDiscoverItem *cars      = [WBDiscoverItem setItemWithTitle:@"汽车" andDestViewController:nil];
        WBDiscoverItem *travel    = [WBDiscoverItem setItemWithTitle:@"旅游" andDestViewController:nil];
        WBDiscoverItem *news      = [WBDiscoverItem setItemWithTitle:@"新闻" andDestViewController:nil];
        WBDiscoverItem *recommend = [WBDiscoverItem setItemWithTitle:@"官方推荐" andDestViewController:nil];
        WBDiscoverItem *reading   = [WBDiscoverItem setItemWithTitle:@"读书" andDestViewController:nil];
        _dataArray                = @[goods, lottery, food, cars, travel, news, recommend, reading];
    }
    return _dataArray;
}

#pragma mark - TableView Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 1.创建cell
    WBDiscoverItemCell *cell = [WBDiscoverItemCell cellWithTableView:tableView];
    
    // 2.传递模型数据
    WBDiscoverItem *item = self.dataArray[indexPath.row];
    cell.item            = item;
    
    return cell;
}

@end
