//
//  WBTabBarController.m
//  0719WeiBo
//
//  Created by 洪龙通 on 16/7/19.
//  Copyright © 2016年 洪龙通. All rights reserved.
//

#import "WBTabBarController.h"
#import "WBHomeTableViewController.h"
#import "WBDiscoverTableViewController.h"
#import "WBMessageTableViewController.h"
#import "WBMeTableViewController.h"
#import "UIImage+Extension.h"
#import "WBTabBar.h"
#import "WBNavigationController.h"
#import "WBTweetNewStatus.h"
#import "WBUserUnreadParameter.h"
#import "WBUserUnreadResult.h"
#import "WBAccountTool.h"
#import "WBAccount.h"
#import "WBUserTool.h"

@interface WBTabBarController () <WBTabBarDelegate>
@property (nonatomic, strong) WBTabBar *customTabBar;

// 1.首页控制器
@property (nonatomic, strong) WBHomeTableViewController *home;
// 2.消息控制器
@property (nonatomic, strong) WBMessageTableViewController *message;
// 3.广场控制器
@property (nonatomic, strong) WBDiscoverTableViewController *discover;
// 4.关于我控制器
@property (nonatomic, strong) WBMeTableViewController *aboutMe;
@end

@implementation WBTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];

    // 1.设置自定义tabBar
    [self setupTabBar];

    // 2.创建添加所有的子控制器
    [self setupChildViewControllers];
    
    // 添加定时器刷新获取未读微博数据
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(getUnreadData) userInfo:nil repeats:YES];
    // 默认计时器在主线程的runloop中,计时会被UI处理阻塞,
    // 所以使用NSRunLoopCommonModes添加到子线程中
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // 删除系统自带的tabBarButton
    for (UIView *childView in self.tabBar.subviews) {
        if ([childView isKindOfClass:[UIControl class]]) {
            [childView removeFromSuperview];
        }
    }
}

/**
 *  设置自定义tabBar
 */
- (void)setupTabBar
{
    WBTabBar *customTabBar = [[WBTabBar alloc] init];
    customTabBar.delegate = self;
    customTabBar.frame = self.tabBar.bounds;
    [self.tabBar addSubview:customTabBar];
    self.customTabBar = customTabBar;
}

/**
 *  创建添加所有的子控制器
 */
- (void)setupChildViewControllers
{
    // 1.首页控制器
    WBHomeTableViewController *home = [[WBHomeTableViewController alloc] init];
    [self setupViewControllerWithViewController:home title:@"首页" imageName:@"tabbar_home" andSelectedImageName:@"tabbar_home_selected"];
    self.home = home;
    
    // 2.消息控制器
    WBMessageTableViewController *message = [[WBMessageTableViewController alloc] init];
    [self setupViewControllerWithViewController:message title:@"消息" imageName:@"tabbar_message_center" andSelectedImageName:@"tabbar_message_center_selected"];
    self.message = message;
    
    // 3.广场控制器
    WBDiscoverTableViewController *discover = [[WBDiscoverTableViewController alloc] init];
    [self setupViewControllerWithViewController:discover title:@"广场" imageName:@"tabbar_discover" andSelectedImageName:@"tabbar_discover_selected"];
    self.discover = discover;
    
    // 4.关于我控制器
    WBMeTableViewController *aboutMe = [[WBMeTableViewController alloc] init];
    [self setupViewControllerWithViewController:aboutMe title:@"我" imageName:@"tabbar_profile" andSelectedImageName:@"tabbar_profile_selected"];
    self.aboutMe = aboutMe;
}

/**
 *  初始化一个自控制器
 *
 *  @param childVC 子控制器
 *  @param title   子控制器标题
 */
- (void)setupViewControllerWithViewController:(UIViewController *)childVC title:(NSString *)title imageName:(NSString *)imageName andSelectedImageName:(NSString *)selectedImage
{
    // 1.设置子控制器的属性
    childVC.title = title;
    childVC.tabBarItem.image = [UIImage imageWithName:imageName];
    childVC.tabBarItem.selectedImage = [UIImage imageWithName:selectedImage];
    
    WBNavigationController *nav = [[WBNavigationController alloc] initWithRootViewController:childVC];
    [self addChildViewController:nav];
    
    // 2.添加自定义tabBar按钮
    [self.customTabBar addTabButtonWithTabBarItem:childVC.tabBarItem];
}
/**
 *  定时刷新获取未读微博数据
 */
- (void)getUnreadData
{
    // 封装请求参数
    WBUserUnreadParameter *params = [WBUserUnreadParameter parameter];
    params.uid = @([WBAccountTool getAccount].uid);
    
    // 网络请求参数
    [WBUserTool getUnreadDataWithParams:params success:^(WBUserUnreadResult *responseObject) {
        self.home.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d", responseObject.status];
        self.message.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d", responseObject.messageCount];
        [UIApplication sharedApplication].applicationIconBadgeNumber = responseObject.count;
    } failure:^(NSError *error) {
        NSLog(@"error:%@", error);
    }];
}

/**
 *  自定义tabBar的点击代理事件
 */
- (void)changeViewControllerFrom:(NSInteger)from to:(NSInteger)to
{
    self.selectedIndex = to;
    
    if (to == 0) {
        [self.home refresh];
    }else {
        [self.home viewWillDisappear:YES];
    }
}

/**
 *  发送微博按钮点击
 */
- (void)sendNewStatus
{
    WBTweetNewStatus *newTweet = [[WBTweetNewStatus alloc] init];
    WBNavigationController *nav = [[WBNavigationController alloc] initWithRootViewController:newTweet];
    [self presentViewController:nav animated:YES completion:nil];
}

@end
