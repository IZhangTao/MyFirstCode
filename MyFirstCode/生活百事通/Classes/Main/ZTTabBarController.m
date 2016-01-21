//
//  ZTTabBarController.m
//  生活百事通
//
//  Created by 张涛 on 15/4/19.
//  Copyright (c) 2015年 张涛. All rights reserved.
//

#import "ZTTabBarController.h"
#import "CSStickyHeaderFlowLayout.h"
#import "ZTNavigationViewController.h"

#import "ZTTabBar.h"

#import "ZTLifeViewController.h"
#import "ZTNewsController.h"
#import "ZTGroupBuyController.h"
#import "ZTMoreController.h"
@interface ZTTabBarController ()<ZTTabbarDelegate>
@property (nonatomic, weak) ZTTabBar *customTabBar;

@property (nonatomic ,weak) ZTLifeViewController *life;
@property (nonatomic, weak) ZTMoreController *more;
@end

@implementation ZTTabBarController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    for (UIView *child in self.tabBar.subviews) {
        if ([child isKindOfClass:[UIControl class]]) {
            [child removeFromSuperview];
        }
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 初始化tabbar
    [self setupTabBar];
    
    // 初始化所以子控制器
    [self setupAllChildViewControls];
}

- (void)setupTabBar
{
    ZTTabBar *customTabBar = [[ZTTabBar alloc]init];
    customTabBar.delegate = self;
    customTabBar.frame = self.tabBar.bounds;
    [self.tabBar addSubview:customTabBar];
    self.customTabBar = customTabBar;
}

// tabbar代理方法 点击了哪个
- (void)tabBar:(ZTTabBar *)tabBar didSelectedButtonfrom:(NSInteger)from to:(NSInteger)to
{
    self.selectedIndex = to;
    
    if (to == 3) { // 点击更多
        //[self.home refreshData];
        // 传递数据
        self.more.weatherInfo = self.life.weatherInfo;
    }
}

- (void)setupAllChildViewControls
{
    // 首页控制器
    // 创建布局
    CSStickyHeaderFlowLayout *layout = [[CSStickyHeaderFlowLayout alloc]init];
    // 设置cell尺寸
    layout.itemSize = CGSizeMake(80, 80);
    // 设置水平间距
    layout.minimumInteritemSpacing = 0;
    // 设置垂直间距
    layout.minimumLineSpacing = 10;
    layout.sectionInset = UIEdgeInsetsMake(10, 0, 0, 0);
    layout.parallaxHeaderReferenceSize = CGSizeMake(self.view.frame.size.width, 170);
    layout.headerReferenceSize = CGSizeMake(200, 50);
    
    
    ZTLifeViewController *life = [[ZTLifeViewController alloc]initWithCollectionViewLayout:layout];
    
    [self addChildViewControl:life title:@"生活" imageName:@"tabbar_home_os7" selectedImageName:@"tabbar_home_selected_os7"];
    self.life = life;
    
    // 新闻控制器
    ZTNewsController *news = [[ZTNewsController alloc]init];
    //msg.tabBarItem.badgeValue = @"30";
    [self addChildViewControl:news title:@"新闻" imageName:@"tabbar_message_center_os7" selectedImageName:@"tabbar_message_center_selected_os7"];
    
    // 团购控制器
    ZTGroupBuyController *discover = [[ZTGroupBuyController alloc]init];
    //discover.tabBarItem.badgeValue = @"60";
    [self addChildViewControl:discover title:@"团购" imageName:@"tabbar_discover_os7" selectedImageName:@"tabbar_discover_selected_os7"];
    
    // 更多控制器
    ZTMoreController *more = [[ZTMoreController alloc]init];
    //me.tabBarItem.badgeValue = @"80";
    [self addChildViewControl:more title:@"更多" imageName:@"tabbar_more_os7" selectedImageName:@"tabbar_more_selected_os7"];
    self.more = more;
    
}

/**
 *  添加子控制器
 *
 *  @param childVc           子控制器
 *  @param title             标题
 *  @param imageName         图片
 *  @param selectedImageName 被选中图片
 */
- (void)addChildViewControl:(UIViewController *)childVc title:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName
{
    // 设置标题图片
    childVc.title = title;
    childVc.tabBarItem.image = [UIImage imageNamed:imageName];
    if (ios7) {
        childVc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }else {
        childVc.tabBarItem.selectedImage = [UIImage imageNamed:selectedImageName];
    }
    
    // 添加到导航控制器
    ZTNavigationViewController *childVcNav = [[ZTNavigationViewController alloc]initWithRootViewController:childVc];
    [self addChildViewController:childVcNav];
    // 添加自定义item
    [self.customTabBar addButtonWithItem:childVc.tabBarItem];
}


@end
