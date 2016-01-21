//
//  UIWindow+Extension.m
//
//  Created by apple on 15/3/26.
//

#import "UIWindow+Extension.h"
#import "ZTTabBarController.h"
#import "ZTNewfeatrueController.h"

@implementation UIWindow (Extension)

- (void)chooseRootViewController
{
    // 取出window
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    
#warning 注意: 此处获取出来的软件版本号, 不建议使用double或者int类型来保存, 最好用字符串
    // 3.加载info.plist
    // 获取软件当前的版本号
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[@"CFBundleShortVersionString"];
//    NSLog(@"currentVersion = %@", currentVersion);
    
    // 4.获取本地保存的版本号
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *sandboxVersion = [defaults valueForKey:@"sandboxVersion"];
//    NSLog(@"sandboxVersion = %@", sandboxVersion);
    
    // 4.判断是否需要显示新特性
    if ([currentVersion compare:sandboxVersion] == NSOrderedDescending) {
        
        // 4.0注册通知, 监听按钮的点击
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(chooseRootVc) name:@"chooseRootViewController" object:nil];
        
        // 4.1显示新特性
        ZTNewfeatrueController *nfVc = [[ZTNewfeatrueController alloc] init];
        
        // 4.2更新本地保存的版本号
        [defaults setValue:currentVersion forKey:@"sandboxVersion"];
        
        window.rootViewController = nfVc;
    }else
    {
        // 2.创建根控制器
        ZTTabBarController *tbVc = [[ZTTabBarController alloc] init];
        // 5.设置根控制器
        window.rootViewController = tbVc;
    }
}
- (void)chooseRootVc
{
    NSLog(@"切换根控制器");
    // 0.销毁通知监听
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    // 1.创建根控制器
    ZTTabBarController *tbVc = [[ZTTabBarController alloc] init];
    // 2.设置根控制器
     [UIApplication sharedApplication].keyWindow.rootViewController = tbVc;
}
@end
