//
//  WBHomeTableViewController.m
//  0719WeiBo
//
//  Created by 洪龙通 on 16/7/19.
//  Copyright © 2016年 洪龙通. All rights reserved.
//

#import "WBHomeTableViewController.h"
#import "UIBarButtonItem+WB.h"
#import "WBTitleView.h"
#import "WBStatusTool.h"
#import "WBAccount.h"
#import "WBAccountTool.h"
#import "MJExtension.h"
#import "WBStatus.h"
#import "WBUser.h"
#import "UIImageView+WebCache.h"
#import "WBStatusCell.h"
#import "WBStatusFrame.h"
#import "MJRefresh.h"
#import "WBStatusParameter.h"
#import "WBStatusResult.h"
#import "WBUserTool.h"
#import "WBUserParameter.h"
#import "WBUserResult.h"
#import "WBHttpTool.h"
#import "WBStatusCacheTool.h"
#import "WMPlayer.h"
#import "WBVideoUrlAnalysisTool.h"

#import "WBStatusTopView.h"
#import "WBVideoView.h"

#define kNavBarHeight 64
#define kTabBarHeight 49

@interface WBHomeTableViewController () <MJRefreshBaseViewDelegate>

@property (nonatomic, copy  ) NSArray             *statusFramesArray;
@property (nonatomic, weak  ) WBTitleView         *titleView;
@property (nonatomic, strong) MJRefreshHeaderView *headerRefresh;
@property (nonatomic, strong) MJRefreshFooterView *footerRefresh;
@property (nonatomic, strong) NSIndexPath         *currentIndexPath;
@property (nonatomic, strong) WBVideoView         *currentVideoView;
@property (nonatomic, strong) WMPlayer            *videoPlayer;
@end

@implementation WBHomeTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 集成刷新控件
    [self refressData];
    
    // 设置顶栏子控件
    [self setupBarButtonItems];
    
    // 加载顶栏显示的用户名
    [self setupTitleUserName];
    
    [self loadDataFromLocalCache];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(deviceOrientationChange)
                                                 name:UIDeviceOrientationDidChangeNotification
                                               object:nil];
}

- (void)viewWillDisappear:(BOOL)animated
{
    if (_currentIndexPath) {
        [self cancelVideo];
    }
    [super viewWillDisappear:animated];
}

- (void)viewWillAppear:(BOOL)animated
{
    [self scrollViewDidEndDragging:self.tableView willDecelerate:NO];
    [super viewWillAppear:animated];
}

- (BOOL)prefersStatusBarHidden
{
    return (_videoPlayer.bottomView.alpha)? YES : NO;
}

/**
 *  集成刷新控件
 */
- (void)refressData
{
    // 顶部刷新控件
    MJRefreshHeaderView *headerRefresh = [MJRefreshHeaderView header];
    headerRefresh.scrollView           = self.tableView;
    headerRefresh.delegate             = self;
    self.headerRefresh                 = headerRefresh;
    //    [headerRefresh beginRefreshing];
    
    // 顶部刷新控件
    MJRefreshFooterView *footerRefresh = [MJRefreshFooterView footer];
    footerRefresh.scrollView           = self.tableView;
    self.footerRefresh                 = footerRefresh;
    footerRefresh.delegate             = self;
}

- (void)dealloc
{
    [self.headerRefresh free];
    [self.footerRefresh free];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

/**
 *  refresh控件的代理,开始刷新时调用
 */
- (void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView
{
    if ([refreshView isKindOfClass:[MJRefreshHeaderView class]]) {
        [self loadNewStatus];
    }else {
        [self loadMoreStatus];
    }
}

/**
 *  点击home按钮刷新未读消息
 */
- (void)refresh
{
    if ([self.tabBarItem.badgeValue intValue] != 0) {
        [self.headerRefresh beginRefreshing];
    }
}

/**
 *  加载顶栏显示的用户名
 */
- (void)setupTitleUserName
{
    // 封装请求参数
    WBUserParameter *params = [WBUserParameter parameter];
    params.uid              = @([WBAccountTool getAccount].uid);
    
    // 网络请求参数
    [WBUserTool getUserDataWithParams:params success:^(WBUserResult *responseObject) {
        
        [self.titleView setTitle:responseObject.name forState:UIControlStateNormal];
        WBAccount *account = [WBAccountTool getAccount];
        account.name       = responseObject.name;
        [WBAccountTool saveAccount:account];
    } failure:^(NSError *error) {
        NSLog(@"error:%@", error);
    }];
}

/**
 *  设置顶栏子控件
 */
- (void)setupBarButtonItems
{
    // 设置顶栏的左边按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem initWithIcon:@"navigationbar_friendsearch_os7" highlightedIcon:@"navigationbar_friendsearch_highlighted_os7" target:self action:@selector(friendSearch)];
    
    // 设置顶栏的右边按钮
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem initWithIcon:@"navigationbar_pop_os7" highlightedIcon:@"navigationbar_pop_highlighted_os7" target:self action:@selector(popMenu)];
    
    // 设置顶栏标题的按钮
    WBTitleView *titleView = [WBTitleView buttonWithType:UIButtonTypeCustom];
    [titleView setImage:[UIImage imageNamed:@"navigationbar_arrow_down_os7"] forState:UIControlStateNormal];
    [titleView setImage:[UIImage imageNamed:@"navigationbar_arrow_up_os7"] forState:UIControlStateSelected];
    titleView.bounds = CGRectMake(0, 0, 0, 35);
    if (![WBAccountTool getAccount].name) {
        [titleView setTitle:@"首页" forState:UIControlStateNormal];
    }else {
        [titleView setTitle:[WBAccountTool getAccount].name forState:UIControlStateNormal];
    }
    [titleView addTarget:self action:@selector(titleClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    self.tableView.backgroundColor = RGBCOLOR(226, 226, 226);
    self.tableView.contentInset    = UIEdgeInsetsMake(0, 0, 8, 0);
    self.tableView.separatorStyle  = UITableViewCellSeparatorStyleNone;
    self.navigationItem.titleView  = titleView;
    self.titleView                 = titleView;
}

/**
 *  从本地存储的数据库中获取数据
 */
- (void)loadDataFromLocalCache
{
    // 封装请求参数
    WBStatusParameter *params = [WBStatusParameter parameter];
    
    NSArray *cache = [WBStatusCacheTool loadLocalStatusCacheWithParams:params];
    
    if (!cache.count) {
        NSMutableArray *statusArray = [NSMutableArray array];
        for (WBStatus *status in cache) {
            WBStatusFrame *frame = [[WBStatusFrame alloc] init];
            [WBVideoUrlAnalysisTool getRealVideoUrlFromOriginalUrl:status.videoStr WithBlock:^(NSString *realVideoUrl, NSString *videoImage) {
                status.videoStr = realVideoUrl;
                status.videoImage = videoImage;
            }];
            frame.status         = status;
            [statusArray addObject:frame];
        }
        
        self.statusFramesArray = [statusArray copy];
        
        [self.tableView reloadData];
    }else{
        [self.headerRefresh beginRefreshing];
    }
}

/**
 *  加载新的微博数据
 */
- (void)loadNewStatus
{
    // 封装请求参数
    WBStatusParameter *params  = [WBStatusParameter parameter];
    WBStatusFrame *statusFrame = [self.statusFramesArray firstObject];
    if (statusFrame) {
        params.since_id = @([statusFrame.status.idstr longLongValue]);
    }else {
        params.count = @20;
    }
    
    // 网络请求参数
    [WBStatusTool loadStatusWithParams:params success:^(WBStatusResult *responseObject) {
        
        NSMutableArray *statusArray = [NSMutableArray array];
        for (WBStatus *status in responseObject.statuses) {
            WBStatusFrame *frame = [[WBStatusFrame alloc] init];
            frame.status         = status;
            [statusArray addObject:frame];
        }
        
        NSMutableArray *dataArray = [NSMutableArray array];
        [dataArray addObjectsFromArray:statusArray];
        [dataArray addObjectsFromArray:self.statusFramesArray];
        self.statusFramesArray = [dataArray copy];
        
        if (statusArray.count)
        {
            [self.tableView reloadData];
        }
        [self showCountOfNewStatus:statusArray.count];
        [self.headerRefresh endRefreshing];
    } failure:^(NSError *error) {
        [self.headerRefresh endRefreshing];
        WBLog(@"Load New Status Error:%@", error);
    }];
}

/**
 *  加载更多微博数据
 */
- (void)loadMoreStatus
{
    // 封装请求参数
    WBStatusParameter *params  = [WBStatusParameter parameter];
    WBStatusFrame *statusFrame = [self.statusFramesArray lastObject];
    if (statusFrame) {
        params.max_id = @([statusFrame.status.idstr longLongValue]);
        params.count  = @10;
    }
    
    // 网络请求参数
    [WBStatusTool loadStatusWithParams:params success:^(WBStatusResult *responseObject) {
        
        NSMutableArray *statusArray = [NSMutableArray array];
        for (WBStatus *status in responseObject.statuses) {
            WBStatusFrame *frame = [[WBStatusFrame alloc] init];
            frame.status         = status;
            [statusArray addObject:frame];
        }
        
        NSMutableArray *dataArray = [NSMutableArray array];
        [dataArray addObjectsFromArray:self.statusFramesArray];
        [dataArray removeLastObject];
        [dataArray addObjectsFromArray:statusArray];
        self.statusFramesArray = [dataArray copy];
        
        [self.tableView reloadData];
        [self.footerRefresh endRefreshing];
    } failure:^(NSError *error) {
        [self.footerRefresh endRefreshing];
        WBLog(@"Load More Staus Error:%@", error);
    }];
    
}

/**
 *  提示用户新刷新了几条数据
 */
- (void)showCountOfNewStatus:(NSInteger)count
{
    UILabel *countLabel        = [[UILabel alloc] init];
    countLabel.alpha           = 0.7;
    countLabel.backgroundColor = [UIColor orangeColor];
    countLabel.textColor       = [UIColor whiteColor];
    countLabel.font            = [UIFont systemFontOfSize:13.0];
    countLabel.textAlignment   = NSTextAlignmentCenter;
    [self.navigationController.view insertSubview:countLabel belowSubview:self.navigationController.navigationBar];
    CGFloat countLabelW = self.tableView.frame.size.width;
    CGFloat countLabelH = 25;
    CGFloat countLabelX = 0;
    CGFloat countLabelY = 64 - countLabelH;
    countLabel.frame    = CGRectMake(countLabelX, countLabelY, countLabelW, countLabelH);
    
    if (count) {
        countLabel.text = [NSString stringWithFormat:@"有%li条最新微博", count];
    }else {
        countLabel.text = @"木有最新微博哦~";
    }
    
    [UIView animateWithDuration:0.8 animations:^{
        
        countLabel.transform = CGAffineTransformMakeTranslation(0, countLabelH + 2);
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:0.8 delay:0.7 options:UIViewAnimationOptionCurveLinear animations:^{
            countLabel.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            [countLabel removeFromSuperview];
        }];
    }];
    
}

/**
 *  旋转屏幕通知
 */
- (void)deviceOrientationChange
{
    if (!_videoPlayer || _videoPlayer.bottomView.alpha == 0.0){
        return;
    }
    
    UIDeviceOrientation orientation             = [UIDevice currentDevice].orientation;
    UIInterfaceOrientation interfaceOrientation = (UIInterfaceOrientation)orientation;
    switch (interfaceOrientation) {
        case UIInterfaceOrientationPortrait:{
            NSLog(@"旋转方向---电池栏在上");
            [self toFullScreenWithInterfaceOrientation:interfaceOrientation];
        }
        break;
        case UIInterfaceOrientationLandscapeLeft:{
            NSLog(@"旋转方向---电池栏在左");
            [self toFullScreenWithInterfaceOrientation:interfaceOrientation];
        }
        break;
        case UIInterfaceOrientationLandscapeRight:{
            NSLog(@"旋转方向---电池栏在右");
            [self toFullScreenWithInterfaceOrientation:interfaceOrientation];
        }
        break;
        default:
        break;
    }
}

/**
 *  屏幕缩放处理（屏幕旋转或者点击放大全屏）
 */
-(void)toFullScreenWithInterfaceOrientation:(UIInterfaceOrientation )interfaceOrientation{
    
    [_videoPlayer removeFromSuperview];
    _videoPlayer.transform = CGAffineTransformIdentity;
    if (interfaceOrientation==UIInterfaceOrientationLandscapeLeft) {
        _videoPlayer.transform = CGAffineTransformMakeRotation(-M_PI_2);
    }else if(interfaceOrientation==UIInterfaceOrientationLandscapeRight){
        _videoPlayer.transform = CGAffineTransformMakeRotation(M_PI_2);
    }
    
    _videoPlayer.frame             = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    _videoPlayer.playerLayer.frame = _videoPlayer.bounds;
    
    if (interfaceOrientation != UIInterfaceOrientationPortrait)
    {
        // 刷新隐藏状态栏
        [self setNeedsStatusBarAppearanceUpdate];
        _videoPlayer.playerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
        [_videoPlayer.bottomView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(40);
            make.top.mas_equalTo(self.view.frame.size.width-40);
            make.width.mas_equalTo(self.view.frame.size.height);
        }];
    }else {
        _videoPlayer.playerLayer.videoGravity = AVLayerVideoGravityResizeAspect;
        [_videoPlayer.bottomView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(40);
            make.top.mas_equalTo(_videoPlayer.center.y + 90);
            make.width.mas_equalTo(_videoPlayer.frame.size.width);
        }];
    }
    
    [[UIApplication sharedApplication].keyWindow addSubview:_videoPlayer];
    [_videoPlayer bringSubviewToFront:_videoPlayer.bottomView];
    
}

- (void)friendSearch
{
    NSLog(@"friendSearch");
}

- (void)popMenu
{
    NSLog(@"popMenu");
}

/**
 *  用户标题被点击
 */
- (void)titleClicked:(WBTitleView *)titleButton
{
    titleButton.selected = !titleButton.selected;
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.statusFramesArray.count;
}

/**
 *  tableView cell的设置
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //1.创建cell
    WBStatusCell *cell = [WBStatusCell cellWithTableView:tableView];
    
    //2.传递数据模型来设置cell属性
    WBStatusFrame *frame = self.statusFramesArray[indexPath.row];
    cell.statusFrames    = frame;
    
    //3.返回cell
    return cell;
}

/**
 *  设置cell的高度
 */
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WBStatusFrame *frame = self.statusFramesArray[indexPath.row];
    return frame.cellHeight;
}

/**
 *  播放视频
 *
 *  @param urlString 视频地址
 *  @param videoView 视频的父类控件
 */
-(void)startPlayVideoWithURL:(NSString *)urlString toView:(WBVideoView *)videoView
{
//    WBLog(@"urlString:%@", urlString);
    _videoPlayer               = [[WMPlayer alloc]initWithFrame:videoView.bounds videoURLStr:urlString];
    _videoPlayer.player.volume = 0.0;
    [_videoPlayer.player play];
    UITapGestureRecognizer* singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap)];
    singleTap.numberOfTapsRequired    = 1;// 单击
    [_videoPlayer addGestureRecognizer:singleTap];
    [videoView addSubview:_videoPlayer];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(cancelVideo) name:@"finishedPlay" object:_videoPlayer];
    
    [videoView bringSubviewToFront:_videoPlayer];
    [videoView sendSubviewToBack:videoView.playOrPauseBtn];
    [self.tableView reloadData];
}

/**
 *  停止视频播放
 */
- (void)cancelVideo
{
    WBLog(@"-------------cancelVideo");
    [_videoPlayer closeTheVideo];
    [_currentVideoView bringSubviewToFront:_currentVideoView.playOrPauseBtn];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"finishedPlay" object:_videoPlayer];
    _videoPlayer      = nil;
    _currentVideoView = nil;
    _currentIndexPath = nil;
}

/**
 *  单击手势方法
 */
- (void)handleSingleTap{
    [UIView animateWithDuration:0.5 animations:^{
        if (_videoPlayer.bottomView.alpha == 0.0) {
            _videoPlayer.player.volume    = 1.0;
            _videoPlayer.bottomView.alpha = 1.0;
            [self toFullScreenWithInterfaceOrientation:UIInterfaceOrientationPortrait];
        }else{
            _videoPlayer.bottomView.alpha = 0.0;
            _videoPlayer.closeBtn.alpha   = 0.0;
            _videoPlayer.player.volume    = 0.0;
            // 刷新显示状态栏
            [self setNeedsStatusBarAppearanceUpdate];
            [_videoPlayer removeFromSuperview];
            _videoPlayer.playerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
            _videoPlayer.transform                = CGAffineTransformIdentity;
            _videoPlayer.frame                    = _currentVideoView.bounds;
            _videoPlayer.playerLayer.frame        = _videoPlayer.bounds;
            [_currentVideoView addSubview:_videoPlayer];
            [self.tableView reloadData];
            
        }
    } completion:^(BOOL finish){
        
    }];
}


#pragma mark scrollView delegate
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if(scrollView == self.tableView){
        
        for (WBStatusCell *cell in [self.tableView visibleCells])
        {
            if ([cell.statusFrames.status.videoStr length] <= 1) {
                continue;
            }
            WBVideoView *videoView = cell.topView.videoView;
            
            NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
            
            CGRect rectInTableView                   = [self.tableView rectForRowAtIndexPath:indexPath];
            CGPoint videoInTableView                 = CGPointMake(0, rectInTableView.origin.y + videoView.center.y);
            CGPoint videoCenterInSuperView           = [self.tableView convertPoint:videoInTableView toView:self.tableView.superview];
            NSLog(@"row:%ld, videoCenterInSuperViewY = %f",indexPath.row, videoCenterInSuperView.y);
            if (videoCenterInSuperView.y < kNavBarHeight ||
                videoCenterInSuperView.y > self.view.frame.size.height - kTabBarHeight)
            {
                if (indexPath == _currentIndexPath)
                {
                    [self cancelVideo];
                }
            }else {
                if (indexPath != _currentIndexPath && !_videoPlayer) {
                    _currentIndexPath = indexPath;
                    _currentVideoView = videoView;
                    [self startPlayVideoWithURL:cell.statusFrames.status.videoStr toView:videoView];
                }
            }
        }
        
    }
}

/**
 *  当有播放视频被滚动出屏幕范围时需要清除video
 */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (_currentIndexPath) {
        BOOL isCurrentIndexOutOfScreen = YES;
        for (WBStatusCell *cell in [self.tableView visibleCells])
        {
            NSIndexPath *indexPath    = [self.tableView indexPathForCell:cell];
            if (_currentIndexPath.row == indexPath.row) {
                isCurrentIndexOutOfScreen = NO;
                break;
            }
        }
        if (isCurrentIndexOutOfScreen) {
            [self cancelVideo];
        }
    }
}

/**
 *  惯性滚动结束时
 */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    WBLog(@"scrollViewDidEndDecelerating");
    [self scrollViewDidEndDragging:scrollView willDecelerate:NO];
}

@end
