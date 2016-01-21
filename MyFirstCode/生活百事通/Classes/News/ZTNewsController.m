//
//  ZTNewsController.m
//  生活百事通
//
//  Created by 张涛 on 15/4/19.
//  Copyright (c) 2015年 张涛. All rights reserved.
//

#import "ZTNewsController.h"
#import "REMenu.h"
#import "ZTShowViewController.h"
#import "UIBarButtonItem+Extension.h"

#define baiduNewUrl @"http://news.baidu.com" 
#define fengNewUrl @"http://3g.ifeng.com"
#define sinaNewUrl @"http://news.sina.cn"
#define tencenNewUrl @"http://info.3g.qq.com"
#define wangyiNewUrl @"http://3g.163.com"

@interface ZTNewsController ()<UIWebViewDelegate>

@property (nonatomic, strong) REMenu *menu;

@end

@implementation ZTNewsController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (![self.menu isOpen]) {
        [self.menu showInView:self.view];
    }
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    if ([self.menu isOpen]) {
        [self.menu close];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //self.view.fream 不计算 navigationBar
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImage:@"navigationbar_more" target:self action:@selector(selectMoreNews)];
    
    UIImageView *imageView = [[UIImageView alloc]init];
    imageView.image = [UIImage imageNamed:@"audionews_play_bg_morning.jpg"];
    imageView.frame = self.view.bounds;
    [self.view addSubview:imageView];
    
    
    [self setUpMenu];
 
}


//展示菜单
- (void)selectMoreNews
{
    if (!self.menu.isOpen)
        return [self.menu showInView:self.view];
}
//设置菜单
- (void)setUpMenu
{
     __weak __typeof(self)weakSelf = self;

    REMenuItem *baidu = [[REMenuItem alloc]initWithTitle:@"百度新闻" subtitle:@"全球最大的中文新闻平台" image:nil highlightedImage:nil action:^(REMenuItem *item) {
        [weakSelf pushViewControllerWithUrl:baiduNewUrl title:@"百度新闻"];
    }];
    
    REMenuItem *fenghuang = [[REMenuItem alloc]initWithTitle:@"凤凰新闻" subtitle:@"24小时提供最及时，最权威，最客观的新闻资讯" image:nil highlightedImage:nil action:^(REMenuItem *item) {
        [weakSelf pushViewControllerWithUrl:fengNewUrl title:@"凤凰新闻"];
    }];
    
    REMenuItem *xinlang = [[REMenuItem alloc]initWithTitle:@"新浪新闻" subtitle:@"最新，最快头条新闻一网打尽" image:nil highlightedImage:nil action:^(REMenuItem *item) {
        [weakSelf pushViewControllerWithUrl:sinaNewUrl title:@"新浪新闻"];
    }];
    
    REMenuItem *tengxu = [[REMenuItem alloc]initWithTitle:@"腾讯新闻" subtitle:@"中国浏览最大的中文门户网站" image:nil highlightedImage:nil action:^(REMenuItem *item) {
        [weakSelf pushViewControllerWithUrl:tencenNewUrl title:@"腾讯新闻"];
    }];
    
    REMenuItem *wangyi = [[REMenuItem alloc]initWithTitle:@"网易新闻" subtitle:@"因新闻最快速，评论最犀利而备受推崇" image:nil highlightedImage:nil action:^(REMenuItem *item) {
        [weakSelf pushViewControllerWithUrl:wangyiNewUrl title:@"网易新闻"];
    }];

    self.menu = [[REMenu alloc]initWithItems:@[baidu,fenghuang,xinlang,tengxu,wangyi]];
    
    self.menu.textColor = [UIColor whiteColor];
    self.menu.subtitleTextColor = [UIColor whiteColor];
    
}
//跳转控制器
- (void)pushViewControllerWithUrl:(NSString *)url title:(NSString *)title
{
    ZTShowViewController *show = [[ZTShowViewController alloc]init];
    show.strUrl = url;
    show.title = title;
    [self.navigationController pushViewController:show animated:NO];
    
}


@end
