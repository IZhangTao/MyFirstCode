//
//  ZTShowViewController.m
//  生活百事通
//
//  Created by 张涛 on 15/5/8.
//  Copyright (c) 2015年 张涛. All rights reserved.
//

#import "ZTShowViewController.h"

@interface ZTShowViewController ()<UIWebViewDelegate>

@property (nonatomic ,weak) UIWebView *webView;

@property (nonatomic ,weak) UIActivityIndicatorView *activity;
@end

@implementation ZTShowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置webview
    [self setUpWebview];
    //显示网页
    [self loadUpUrl:self.strUrl];
    //设置网络指示器
//    [self setUpActivity];
}
- (void)setUpWebview
{
    UIWebView *webView = [[UIWebView alloc]init];
    webView.frame = self.view.bounds;
    [self.view addSubview:webView];
    self.webView = webView;
    webView.delegate = self;
}

- (void)loadUpUrl:(NSString *)strUrl
{
    NSURL *url = [NSURL URLWithString:strUrl];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
}

#pragma mark - webview deleda
-(void)webViewDidStartLoad:(UIWebView *)webView
{
    [self.activity startAnimating];
    self.activity.hidden = NO;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self.activity stopAnimating];
    self.activity.hidden = YES;
}
- (void)setUpActivity
{
    UIActivityIndicatorView *activity = [[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(0, 0, 60, 60)];
    
    activity.center = CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2);
    
    activity.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhite;
    
    activity.backgroundColor = [UIColor grayColor];
    activity.alpha = 0.5;
    
    //设置背景为圆角
    activity.layer.cornerRadius = 5;
    activity.layer.masksToBounds = YES;
    
    [self.view addSubview:activity];
    self.activity = activity;
    self.activity.hidden = YES;
}

- (void)dealloc
{
    // 释放webview内存
    [self.webView loadHTMLString:@"" baseURL:nil];
    [self.webView stopLoading];
    self.webView.delegate = nil;
    [self.webView removeFromSuperview];
    self.webView = nil;
    
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    NSLog(@"KLNewsViewController dealloc");
}

@end
