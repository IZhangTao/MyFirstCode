//
//  ZTDataTool.h
//  生活百事通
//
//  Created by 张涛 on 15/5/12.
//  Copyright (c) 2015年 张涛. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZTSingleton.h"
@class ZTCategory,ZTOrder,ZTCity;



@interface ZTDataTool : NSObject
ZTSingletonH(ZTDataTool)

/**
 *  解析所有plist 工具类
 */


//Categories - 字典  团购图标，菜单1
@property (nonatomic, strong) ZTCategory *currentCategory;
//Categories - 数组
@property (nonatomic, strong, readonly) NSArray *totalCategories;



// 城市
@property (nonatomic, strong, readonly) NSDictionary *totalCities;
// 所有的城市组数据
@property (nonatomic, strong, readonly) NSArray *totalCitySections;
// 当前选中的城市
@property (nonatomic, strong) ZTCity *currentCity;


// 所有的排序数据
@property (nonatomic, strong, readonly) NSArray *totalOrders;
- (ZTOrder *)orderWithName:(NSString *)name;

@end
