//
//  SJOAuthViewController.m
//  SoulJaWeibo
//
//  Created by SoulJa on 15/6/9.
//  Copyright (c) 2015年 SoulJa. All rights reserved.
//

#import "SJOAuthViewController.h"
#import "AFNetworking.h"
#import "MBProgressHUD+MJ.h"
#import "SJAccount.h"
#import "SJNewFeatureViewController.h"
#import "SJTabBarController.h"
#import "SJWeiboTool.h"
#import "SJAccountTool.h"
@interface SJOAuthViewController () <UIWebViewDelegate>
@end
@implementation SJOAuthViewController
- (void)viewDidLoad
{
    //1.添加webView
    UIWebView *webView = [[UIWebView alloc] init];
    webView.frame = self.view.bounds;
    webView.delegate = self;
    [self.view addSubview:webView];
    //2.加载授权页面
    NSString *urlStr = [NSString stringWithFormat:@"https://api.weibo.com/oauth2/authorize?client_id=%@&redirect_uri=http://",AppKey];
    NSURL *url = [NSURL URLWithString:urlStr];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
}
#pragma mark - UIWebViewDelegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    //1.请求的url路径
    NSString *urlStr = request.URL.absoluteString;
    //2.查找code=在urlStr中的范围
    NSRange range = [urlStr rangeOfString:@"code="];
    if (range.length) {
        //获取code
        NSString *code = [urlStr substringFromIndex:range.location + range.length];
        //发送请求获取access_token
        [self accessTokenWithCode:code];
    }
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [MBProgressHUD showMessage:@"正在加载..."];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [MBProgressHUD hideHUD];
}

- (void)accessTokenWithCode:(NSString *)code
{
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"client_id"] = AppKey;
    params[@"client_secret"] = AppSecret;
    params[@"grant_type"] = @"authorization_code";
    params[@"code"] = code;
    params[@"redirect_uri"] = @"http://";
    [mgr POST:@"https://api.weibo.com/oauth2/access_token" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [MBProgressHUD hideHUD];
        SJAccount *account = [SJAccount accountWithDict:responseObject];
        //存储模型数据
        [SJAccountTool saveAccount:account];
        
        [SJWeiboTool chooseRootController];
        

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [MBProgressHUD showError:@"请求失败!"];
    }];
}
@end
