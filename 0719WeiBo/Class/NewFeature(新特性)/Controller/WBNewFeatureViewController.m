//
//  WBNewFeatureViewController.m
//  0719WeiBo
//
//  Created by 洪龙通 on 16/7/24.
//  Copyright © 2016年 洪龙通. All rights reserved.
//

#import "WBNewFeatureViewController.h"
#import "WBTabBarController.h"

#define WBNewFeatureViewImageCount 3

@interface WBNewFeatureViewController() <UIScrollViewDelegate>

@property (nonatomic, strong) UIPageControl *pageControl;
@end
@implementation WBNewFeatureViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 1.设置scrollView
    [self setupScrollView];
    
    // 2.设置PageControl
    [self setupPageControl];
}

- (void)setupScrollView
{
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.frame = self.view.bounds;
    scrollView.delegate = self;
    [self.view addSubview:scrollView];
    
    CGFloat imageViewW = self.view.frame.size.width;
    CGFloat imageViewH = self.view.frame.size.height;
    for (int index = 0; index < WBNewFeatureViewImageCount; index++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"new_feature_%d", index + 1]];
        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
        CGFloat imageViewX = self.view.frame.size.width * index;
        imageView.frame = CGRectMake(imageViewX, 0, imageViewW, imageViewH);
        
        [scrollView addSubview:imageView];
        
        if (index == WBNewFeatureViewImageCount - 1) {
            imageView.userInteractionEnabled = YES;
            [self setupLastImageView:imageView];
        }
    }
    
    scrollView.contentSize = CGSizeMake(WBNewFeatureViewImageCount * scrollView.frame.size.width, 0);
    scrollView.pagingEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    
}

- (void)setupPageControl
{
    UIPageControl *pageControl = [[UIPageControl alloc] init];
    pageControl.numberOfPages = WBNewFeatureViewImageCount;
    pageControl.center = CGPointMake(self.view.frame.size.width * 0.5, self.view.frame.size.height - 30);
    pageControl.bounds = CGRectMake(0, 0, 100, 30);
    pageControl.currentPageIndicatorTintColor = RGBCOLOR(253, 98, 42);
    pageControl.pageIndicatorTintColor = RGBCOLOR(189, 189, 189);
    [self.view addSubview:pageControl];
    self.pageControl = pageControl;
}

- (void)setupLastImageView:(UIImageView *)imageView
{
    // 添加chekBox
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button"] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button_highlighted"] forState:UIControlStateHighlighted];
    
    [button setTitle:@"开始微博" forState:UIControlStateNormal];
    button.center = CGPointMake(self.view.frame.size.width * 0.5, self.view.center.y + 50);;
    button.bounds = (CGRect){CGPointZero, button.currentBackgroundImage.size};
    [button addTarget:self action:@selector(start) forControlEvents:UIControlEventTouchUpInside];
    [imageView addSubview:button];
    
    // 添加checkBox
    UIButton *checkBox = [UIButton buttonWithType:UIButtonTypeCustom];
    [checkBox setImage:[UIImage imageNamed:@"new_feature_share_true"] forState:UIControlStateNormal];
    [checkBox setImage:[UIImage imageNamed:@"new_feature_share_false"] forState:UIControlStateSelected];
    [checkBox setTitle:@"马上发微博分享" forState:UIControlStateNormal];
    [checkBox setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    checkBox.titleLabel.font = [UIFont systemFontOfSize:12.0];
    checkBox.center = CGPointMake(button.center.x, button.center.y - 40);
    checkBox.bounds = CGRectMake(0, 0, 140, 30);
    [checkBox addTarget:self action:@selector(checkBoxClicked:) forControlEvents:UIControlEventTouchUpInside];
    [imageView addSubview:checkBox];

}

- (void)start
{
    self.view.window.rootViewController = [[WBTabBarController alloc] init];
}

- (void)checkBoxClicked:(UIButton *)checkButton
{
    checkButton.selected = !checkButton.selected;
    
}

/**
 *  当scrollView开始滚动时调用
 *
 */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    int offset = (int)roundf(scrollView.contentOffset.x / scrollView.frame.size.width);
    self.pageControl.currentPage = offset;
}
@end
