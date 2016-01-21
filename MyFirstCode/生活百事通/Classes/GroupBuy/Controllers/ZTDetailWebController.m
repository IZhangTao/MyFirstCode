//
//  ZTDetailWebController.m
//  生活百事通
//
//  Created by zhangtao on 15/12/9.
//  Copyright © 2015年 张涛. All rights reserved.
//

#import "ZTDetailWebController.h"
#import "ZTDeal.h"

@interface ZTDetailWebController ()<UIWebViewDelegate>

@property (nonatomic, strong) UIWebView *webView;
@end

@implementation ZTDetailWebController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addWebView];
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_deal.deal_h5_url]]];
}



- (void)addWebView
{
    UIWebView *web = [[UIWebView alloc]init];
    web.delegate = self;
    web.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    [self.view addSubview:web];
    self.webView = web;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    NSLog(@"%@",webView.request.URL);
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        // 1.加载请求
        NSString *ID = [_deal.deal_id substringFromIndex:[_deal.deal_id rangeOfString:@"-"].location + 1];
        NSString *url = [NSString stringWithFormat:@"http://lite.m.dianping.com/group/deal/moreinfo/%@", ID];

        [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];
    });
}

- (void)dealloc
{
    NSLog(@"KLDetailWebInfoController dealloc");
    
    // 释放webview内存
    [self.webView loadHTMLString:@"" baseURL:nil];
    [self.webView stopLoading];
    self.webView.delegate = nil;
    [self.webView removeFromSuperview];
    self.webView = nil;
    
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
