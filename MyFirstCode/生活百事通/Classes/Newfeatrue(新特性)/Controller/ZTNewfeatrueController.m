//
//  ViewController.m
//  Demo
//
//  Created by apple on 15/3/26.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "ZTNewfeatrueController.h"
#import "HMPageView.h"
#import "HMPageModel.h"

@interface ZTNewfeatrueController ()<UIScrollViewDelegate>

@end

@implementation ZTNewfeatrueController

- (void)viewDidLoad {
    [super viewDidLoad];

    // 1.创建一个UIScrollView
    UIScrollView *sc = [[UIScrollView alloc] init];
    sc.backgroundColor = [UIColor redColor];
    sc.delegate = self;
    sc.frame = self.view.bounds;
    [self.view addSubview:sc];
    // 2.创建添加分页
    NSInteger count = 4;
    for (int i = 0; i < count; i++) {
        // 1.创建分页
        HMPageView *pageView = [HMPageView pageView];
        // 给每一页绑定一tag, 标记当前是第几页
        pageView.tag = i;
        // 告诉所有分页一共有多少页
        pageView.maxCount = count;
        
        // 2.设置分页的frame
        CGFloat pvW = self.view.bounds.size.width;
        CGFloat pvH = self.view.bounds.size.height;
        CGFloat pvY = 0;
        CGFloat pvX = i * pvW;
        pageView.frame = CGRectMake(pvX, pvY, pvW, pvH);
        
        // 3.根据当前的页码, 计算对应页显示的图片
        // 3.1创建一个模型
        HMPageModel *model = [[HMPageModel alloc] init];
        model.bgName = [NSString stringWithFormat:@"guide%tuBackground", i + 1];
        model.guideName = [NSString stringWithFormat:@"guide%tu", i + 1];
        model.largeTextName = [NSString stringWithFormat:@"guideLargeText%tu", i + 1];
        model.smallTextName = [NSString stringWithFormat:@"guideSmallText%tu", i + 1];
        // 4.设置分页上的图片
        pageView.model = model;

        // 4.添加分页到UIScrollView上
        [sc addSubview:pageView];
        
    }
    // 3.设置UIScrollView相关的属性
    // 设置滚动范围
    sc.contentSize = CGSizeMake(count * self.view.bounds.size.width, self.view.bounds.size.height);
    // 开启分页
    sc.pagingEnabled = YES;
    // 关闭弹簧效果
    sc.bounces = NO;
    // 隐藏滚动条
    sc.showsHorizontalScrollIndicator = NO;
    
}

#pragma mark - UIScrollViewDelegate
// 停止滚动
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    // 1.计算页码
    int page = scrollView.contentOffset.x / self.view.frame.size.width;
    
    // 2.拿到当前滚到到的HMPageView?
    HMPageView *pv =  scrollView.subviews[page];
    [pv startAnimation:YES];
}

@end
