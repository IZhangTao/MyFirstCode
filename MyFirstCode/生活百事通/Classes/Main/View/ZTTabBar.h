//
//  WBTabbar.h
//  XinWeibo
//
//  Created by tanyang on 14-10-6.
//  Copyright (c) 2014年 tany. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZTTabBar;
@protocol ZTTabbarDelegate <NSObject>

@optional
- (void)tabBar:(ZTTabBar *)tabBar didSelectedButtonfrom:(NSInteger)from to:(NSInteger)to;
@end

@interface ZTTabBar : UIView
@property (nonatomic, weak) id<ZTTabbarDelegate>delegate;

- (void)addButtonWithItem:(UITabBarItem *)item;
@end
