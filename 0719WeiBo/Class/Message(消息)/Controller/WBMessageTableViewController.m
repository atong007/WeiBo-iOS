//
//  WBMessageTableViewController.m
//  0719WeiBo
//
//  Created by 洪龙通 on 16/7/19.
//  Copyright © 2016年 洪龙通. All rights reserved.
//

#import "WBMessageTableViewController.h"
#import "WBSearchBar.h"
#import "WBMessageItem.h"
#import "WBMessageCell.h"

@interface WBMessageTableViewController () <UITextFieldDelegate>

@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) WBSearchBar *searchBar;
@end

@implementation WBMessageTableViewController

- (instancetype)init{
    return [super initWithStyle:UITableViewStyleGrouped];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.contentInset        = UIEdgeInsetsMake(10, 0, 0, 0);
    self.tableView.sectionHeaderHeight = 35;
    self.tableView.rowHeight = 60;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"写私信" style:UIBarButtonItemStyleDone target:self action:@selector(writePersonalMessage)];
    
    [self setupSearchBar];
}

/**
 *  添加自定义searchBar
 */
- (void)setupSearchBar
{
    WBSearchBar *searchBar        = [WBSearchBar searchBar];
    searchBar.frame               = CGRectMake(0, 0, 100, 30);
    searchBar.delegate            = self;
    self.searchBar                = searchBar;
    self.tableView.tableHeaderView = searchBar;
}

- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        WBMessageItem *atSomeOne    = [WBMessageItem setItemWithTitle:@"@我的" icon:@"messagescenter_at" andDestViewController:nil];
        WBMessageItem *comment = [WBMessageItem setItemWithTitle:@"评论" icon:@"messagescenter_comments" andDestViewController:nil];
        WBMessageItem *praise  = [WBMessageItem setItemWithTitle:@"赞" icon:@"messagescenter_good" andDestViewController:nil];
        WBMessageItem *messageBox    = [WBMessageItem setItemWithTitle:@"未关注人消息" icon:@"messagescenter_messagebox" andDestViewController:nil];
        WBMessageItem *subscription = [WBMessageItem setItemWithTitle:@"评论" icon:@"messagescenter_subscription" andDestViewController:nil];
        NSArray *array = @[atSomeOne, comment, praise, messageBox, subscription];
        _dataArray = [array mutableCopy];
    }
    return _dataArray;
}

- (void)writePersonalMessage
{
    
}

#pragma mark - TableView Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.searchBar isFirstResponder]) {
        [self.searchBar resignFirstResponder];
    }
    WBMessageItem *item = self.dataArray[indexPath.row];
    if (item.destClass) {
        [self.navigationController pushViewController:[[item.destClass alloc] init] animated:YES];
    }
}

/**
 *  tableView cell的设置
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //1.创建cell
    WBMessageCell *cell = [WBMessageCell cellWithTableView:tableView];
    
    //2.传递数据模型来设置cell属性
    WBMessageItem *item = self.dataArray[indexPath.row];
    cell.item = item;
    
    //3.返回cell
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.searchBar resignFirstResponder];
}

@end
