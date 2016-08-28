//
//  WBOAuthViewController.m
//  0719WeiBo
//
//  Created by 洪龙通 on 16/7/26.
//  Copyright © 2016年 洪龙通. All rights reserved.
//

#import "WBOAuthViewController.h"
#import "MBProgressHUD.h"
#import "WBHttpTool.h"
#import "WBAccount.h"
#import "WBAccountTool.h"
#import "WBCommonTool.h"

@interface WBOAuthViewController() <UIWebViewDelegate>
@end
@implementation WBOAuthViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 1.设置webView来显示授权页面
    [self setupOAuthWebView];
}

/**
 *  设置webView来显示授权页面
 */
- (void)setupOAuthWebView
{
    UIWebView *webView = [[UIWebView alloc] init];
    webView.frame = self.view.bounds;
    [self.view addSubview:webView];
    webView.delegate = self;
    NSURL *url = [NSURL URLWithString:WBLoginURL];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSRange range = [request.URL.absoluteString rangeOfString:@"code="];
    if (range.location != NSNotFound)
    {
        NSString *code = [request.URL.absoluteString substringFromIndex:range.location + range.length];
        // 获取微博access_token
        [self getAccessToken:code];
        return NO;
    }
    
    return YES;
}

/**
 *  获取微博access_token
 *
 *  @param code 授权成功返回的code
 */
- (void)getAccessToken:(NSString *)code
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"client_id"] = WBAppKey;
    parameters[@"client_secret"] = WBAppSecret;
    parameters[@"grant_type"] = @"authorization_code";
    parameters[@"code"] = code;
    parameters[@"redirect_uri"] = WBRedirectURI;
    
    [WBHttpTool POSTHttpWithURL:@"https://api.weibo.com/oauth2/access_token" parameters:parameters success:^(id responseObject) {
        
        NSDictionary *dict = responseObject;
        WBAccount *account = [WBAccount accountWithDictionary:dict];
        
        // 将account相关信息存入文件
        [WBAccountTool saveAccount:account];
        
        // 跳转下一控制器
        [WBCommonTool chooseRootViewController];
    } failure:^(NSError *error) {
        NSLog(@"error:%@", error);
    }];
}


- (void)webViewDidStartLoad:(UIWebView *)webView
{
    NSLog(@"webViewDidStartLoad");
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.label.text = @"正在为您加载...";
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    NSLog(@"webViewDidFinishLoad");
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}
@end
