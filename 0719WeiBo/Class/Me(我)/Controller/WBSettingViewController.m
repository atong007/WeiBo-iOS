//
//  WBSettingViewController.m
//  0719WeiBo
//
//  Created by 洪龙通 on 16/8/8.
//  Copyright © 2016年 洪龙通. All rights reserved.
//

#import "WBSettingViewController.h"
#import "WBSettingItem.h"
#import "WBArrowSettingItem.h"
#import "WBNewFriendViewController.h"
#import "WBCommonSettingViewController.h"

@implementation WBSettingViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"设置";
    
    [self setupGroupsData];
}

/**
 *  设置cell各组数据
 */
- (void)setupGroupsData
{
    WBSettingItem *accountManagement = [WBArrowSettingItem setItemWithTitle:@"账号管理" andDestViewController:[WBNewFriendViewController class]];
    NSArray *firstGroup = @[accountManagement];
    [self.dataArray addObject:firstGroup];
    
    WBSettingItem *subject = [WBArrowSettingItem setItemWithTitle:@"主题及背景" andDestViewController:[WBNewFriendViewController class]];
    NSArray *secondGroup = @[subject];
    [self.dataArray addObject:secondGroup];

    WBSettingItem *notice = [WBArrowSettingItem setItemWithTitle:@"通知及提醒" andDestViewController:[WBNewFriendViewController class]];
    WBSettingItem *commonSetting = [WBArrowSettingItem setItemWithTitle:@"通用设置" andDestViewController:[WBCommonSettingViewController class]];
    WBSettingItem *privacy = [WBArrowSettingItem setItemWithTitle:@"隐私及安全" andDestViewController:[WBNewFriendViewController class]];
    NSArray *thirdGroup = @[notice, commonSetting, privacy];
    [self.dataArray addObject:thirdGroup];

    WBSettingItem *advice = [WBArrowSettingItem setItemWithTitle:@"意见反馈" andDestViewController:[WBNewFriendViewController class]];
    WBSettingItem *about = [WBArrowSettingItem setItemWithTitle:@"关于微博" andDestViewController:[WBNewFriendViewController class]];
    NSArray *forthGroup = @[advice, about];
    [self.dataArray addObject:forthGroup];
}
@end
