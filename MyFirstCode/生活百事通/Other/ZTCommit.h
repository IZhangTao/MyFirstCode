//
//  ZTCommit.h
//  生活百事通
//
//  Created by zhangtao on 15/11/20.
//  Copyright (c) 2015年 张涛. All rights reserved.
//

#ifndef ______ZTCommit_h
#define ______ZTCommit_h



// 判断是否为ios7
#define ios7 ([[UIDevice currentDevice].systemVersion doubleValue] >= 7.0)

// 获得RGB颜色
#define ZTColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
// 是否是4寸iPhone
#define is4Inch ([UIScreen mainScreen].bounds.size.height == 568)

//获取屏幕的长和宽
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define kScreenWidth [UIScreen mainScreen].bounds.size.width

// collectionview背景颜色
#define ZTCollectionBkgCollor ZTColor(231, 231, 231);

// 自定义Log
#ifdef DEBUG
#define ZTLog(...) NSLog(__VA_ARGS__)
#else
#define ZTLog(...)
#endif

// 顶部菜单项的宽高
#define kTopMenuItemW 100
#define kTopMenuItemH 44

// 底部菜单项的宽高
#define kBottomMenuItemW 100
#define kBottomMenuItemH 60

// 通知
// 城市改变的通知
#define kCityChangeNote @"city_change"

// 城市的key
#define kCityKey @"city"

#define ZTCurrentCityMessage @"ZTCurrentCityMessage"
#define ZTCityChangeMessage @"ZTCityChangeMessage"
#define ZTNOCityMessage @"ZTNOCityMessage"



// 4.全局背景色
#define kGlobalBg [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_deal.png"]]


// 5.默认的动画时间
#define kDefaultAnimDuration 0.3

// 6.最近访问城市
#define kFilePath [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"visitedCityNames.archive"]

#endif
