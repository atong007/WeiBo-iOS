//
//  WBMeTableViewController.m
//  0719WeiBo
//
//  Created by 洪龙通 on 16/7/19.
//  Copyright © 2016年 洪龙通. All rights reserved.
//

#import "WBMeTableViewController.h"
#import "WBSettingItem.h"
#import "WBArrowSettingItem.h"
#import "WBNewFriendViewController.h"
#import "WBSettingViewController.h"

@interface WBMeTableViewController ()

@end

@implementation WBMeTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"设置" style:UIBarButtonItemStyleDone target:self action:@selector(setting)];
    
    [self setupGroupsData];
}

/**
 *  设置菜单
 */
- (void)setting
{
    [self.navigationController pushViewController:[[WBSettingViewController alloc] init] animated:YES];
}

/**
 *  设置cell各组数据
 */
- (void)setupGroupsData
{
    WBSettingItem *newFriend = [WBArrowSettingItem setItemWithTitle:@"新的朋友" icon:@"new_friend" andDestViewController:[WBNewFriendViewController class]];
    NSArray *firstGroup = @[newFriend];
    [self.dataArray addObject:firstGroup];
    
    WBSettingItem *myPhoto = [WBArrowSettingItem setItemWithTitle:@"我的相册" icon:@"album" andDestViewController:[WBNewFriendViewController class]];
    WBSettingItem *myCollection = [WBArrowSettingItem setItemWithTitle:@"我的收藏" icon:@"collect" andDestViewController:[WBNewFriendViewController class]];
    WBSettingItem *praise = [WBArrowSettingItem setItemWithTitle:@"赞" icon:@"like" andDestViewController:[WBNewFriendViewController class]];
    NSArray *secondGroup = @[myPhoto, myCollection, praise];
    [self.dataArray addObject:secondGroup];
    
    WBSettingItem *microBlogPay = [WBArrowSettingItem setItemWithTitle:@"微博支付" icon:@"pay" andDestViewController:[WBNewFriendViewController class]];
    WBSettingItem *membership = [WBArrowSettingItem setItemWithTitle:@"会员中心" icon:@"vip" andDestViewController:[WBNewFriendViewController class]];
    NSArray *thirdGroup = @[microBlogPay, membership];
    [self.dataArray addObject:thirdGroup];
    
    WBSettingItem *myCard = [WBArrowSettingItem setItemWithTitle:@"我的名片" icon:@"card" andDestViewController:[WBNewFriendViewController class]];
    WBSettingItem *tempBox = [WBArrowSettingItem setItemWithTitle:@"草稿箱" icon:@"draft" andDestViewController:[WBNewFriendViewController class]];
    NSArray *forthGroup = @[myCard, tempBox];
    [self.dataArray addObject:forthGroup];
}



@end
