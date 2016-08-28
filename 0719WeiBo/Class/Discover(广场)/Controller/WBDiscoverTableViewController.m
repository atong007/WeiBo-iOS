//
//  WBDiscoverTableViewController.m
//  0719WeiBo
//
//  Created by 洪龙通 on 16/7/19.
//  Copyright © 2016年 洪龙通. All rights reserved.
//

#import "WBDiscoverTableViewController.h"
#import "WBSearchBar.h"
#import "WBDiscoverItem.h"
#import "WBDiscoverItemCell.h"
#import "WBDiscoverMoreViewController.h"
#import "WBDiscoverHeaderView.h"
#import "WBDiscoverHeaderItem.h"

@interface WBDiscoverTableViewController () <UITextFieldDelegate>

@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) WBSearchBar    *searchBar;
@end

@implementation WBDiscoverTableViewController

- (instancetype)init{
    return [super initWithStyle:UITableViewStyleGrouped];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.contentInset        = UIEdgeInsetsMake(10, 0, 0, 0);
    self.tableView.sectionFooterHeight = 5;
    
    [self setupHeaderView];
    
    // 添加自定义searchBar
    [self setupSearchBar];
}

- (void)setupHeaderView
{
    WBDiscoverHeaderView *headerView = [[WBDiscoverHeaderView alloc] init];
    WBDiscoverHeaderItem *item       = [WBDiscoverHeaderItem itemWithAdPicture:@"square_ad" andTopicArray:@[@"#奥运会#", @"#微博事件#", @"#搞笑集锦#", @"#名人名言#"]];
    headerView.item                  = item;
    self.tableView.tableHeaderView   = headerView;
    
}

/**
 *  添加自定义searchBar
 */
- (void)setupSearchBar
{
    WBSearchBar *searchBar        = [WBSearchBar searchBar];
    searchBar.frame               = CGRectMake(0, 0, self.navigationController.navigationBar.frame.size.width - 10, 30);
    searchBar.delegate            = self; 
    self.navigationItem.titleView = searchBar;
    self.searchBar                = searchBar;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    self.searchBar.placeholder = @"";
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
        
        WBDiscoverItem *hotStatus    = [WBDiscoverItem setItemWithTitle:@"热门微博" subTitle:@"笑话、娱乐都在这啦" icon:@"hot_status" andDestViewController:nil];
        WBDiscoverItem *searchPeople = [WBDiscoverItem setItemWithTitle:@"找人" subTitle:@"名人、有意思的人都在这哦" icon:@"find_people" andDestViewController:nil];
        NSArray *firstGroup          = @[hotStatus, searchPeople];
        [_dataArray addObject:firstGroup];
        
        WBDiscoverItem *gameCenter  = [WBDiscoverItem setItemWithTitle:@"游戏中心" icon:@"game_center" andDestViewController:nil];
        WBDiscoverItem *nearby      = [WBDiscoverItem setItemWithTitle:@"附近" icon:@"near" andDestViewController:nil];
        WBDiscoverItem *application = [WBDiscoverItem setItemWithTitle:@"应用" icon:@"app" andDestViewController:nil];
        
        NSArray *secondGroup = @[gameCenter, nearby, application];
        [_dataArray addObject:secondGroup];
        
        WBDiscoverItem *video   = [WBDiscoverItem setItemWithTitle:@"视频" icon:@"video" andDestViewController:nil];
        WBDiscoverItem *music   = [WBDiscoverItem setItemWithTitle:@"音乐" icon:@"music" andDestViewController:nil];
        WBDiscoverItem *movie   = [WBDiscoverItem setItemWithTitle:@"电影" icon:@"movie" andDestViewController:nil];
        WBDiscoverItem *podcast = [WBDiscoverItem setItemWithTitle:@"播客" icon:@"cast" andDestViewController:nil];
        WBDiscoverItem *more    = [WBDiscoverItem setItemWithTitle:@"更多" icon:@"more" andDestViewController:[WBDiscoverMoreViewController class]];
        NSArray *thirdGroup     = @[video, music, movie, podcast, more];
        [_dataArray addObject:thirdGroup];
    }
    return _dataArray;
}

#pragma mark - TableView Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *array = self.dataArray[section];
    return array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 1.创建cell
    WBDiscoverItemCell *cell = [WBDiscoverItemCell cellWithTableView:tableView];
    
    // 2.传递模型数据
    WBDiscoverItem *item = self.dataArray[indexPath.section][indexPath.row];
    cell.item            = item;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    WBDiscoverItem *item = self.dataArray[indexPath.section][indexPath.row];
    if (item.destClass) {
        [self.navigationController pushViewController:[[item.destClass alloc] init] animated:YES];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
         return 10;
    }else {
        return 5;
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.searchBar resignFirstResponder];
}
@end
