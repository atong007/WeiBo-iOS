//
//  WBCommonSettingViewController.m
//  0719WeiBo
//
//  Created by 洪龙通 on 16/8/8.
//  Copyright © 2016年 洪龙通. All rights reserved.
//

#import "WBCommonSettingViewController.h"
#import "WBSettingItem.h"
#import "WBArrowSettingItem.h"
#import "WBSwitchSettingItem.h"
#import "WBNewFriendViewController.h"

@implementation WBCommonSettingViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"通用设置";
    
    [self setupGroupsData];
}

/**
 *  设置cell各组数据
 */
- (void)setupGroupsData
{
    WBSettingItem *readMode = [WBArrowSettingItem setItemWithTitle:@"阅读模式" andDestViewController:[WBNewFriendViewController class]];
    WBSettingItem *fontSize = [WBArrowSettingItem setItemWithTitle:@"字体大小" andDestViewController:[WBNewFriendViewController class]];
    WBSettingItem *remarkVisible = [WBSwitchSettingItem setItemWithTitle:@"显示备注"];
    NSArray *firstGroup = @[readMode, fontSize, remarkVisible];
    [self.dataArray addObject:firstGroup];
    
    WBSettingItem *picQuality = [WBArrowSettingItem setItemWithTitle:@"图片质量设置" andDestViewController:[WBNewFriendViewController class]];
    NSArray *secondGroup = @[picQuality];
    [self.dataArray addObject:secondGroup];
    
    WBSettingItem *sound = [WBSwitchSettingItem setItemWithTitle:@"声音"];
    NSArray *thirdGroup = @[sound];
    [self.dataArray addObject:thirdGroup];
    
    WBSettingItem *multiLanguage = [WBSwitchSettingItem setItemWithTitle:@"多语言环境"];
    NSArray *forthGroup = @[multiLanguage];
    [self.dataArray addObject:forthGroup];
    
    WBSettingItem *cleanCache = [WBArrowSettingItem setItemWithTitle:@"清除图片缓存" andDestViewController:[WBNewFriendViewController class]];
    WBSettingItem *clearSearchHistory = [WBArrowSettingItem setItemWithTitle:@"清除搜索历史" andDestViewController:[WBNewFriendViewController class]];

    NSArray *fifthGroup = @[cleanCache, clearSearchHistory];
    [self.dataArray addObject:fifthGroup];
}
@end
