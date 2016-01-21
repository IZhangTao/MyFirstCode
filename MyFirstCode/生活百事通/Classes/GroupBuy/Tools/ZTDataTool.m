//
//  ZTDataTool.m
//  生活百事通
//
//  Created by 张涛 on 15/5/12.
//  Copyright (c) 2015年 张涛. All rights reserved.
//

#import "ZTDataTool.h"
#import "ZTCategory.h"
#import "MJExtension.h"

#import "ZTCitySection.h"
#import "ZTCity.h"
#import "ZTOrder.h"

@interface ZTDataTool()
{
    NSMutableArray *_visitedCityNames; // 存储曾经访问过城市的名称
    
    NSMutableDictionary *_totalCities; // 存放所有的城市 key 是城市名  value 是城市对象
    
    ZTCitySection *_visitedSection; // 最近访问的城市组数组
}
@end


@implementation ZTDataTool

ZTSingletonM(ZTDataTool)

- (id)init
{
    if (self = [super init]) {
     
        // 初始化分类数据
        [self loadCategoryData];
        
        //初始化城市
        [self loadCityData];
        
        // 初始化排序数据
        [self loadOrderData];
    }
    return self;
}

- (void)loadOrderData
{
    NSArray *orderArray = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"Orders.plist" ofType:nil]];
    
    NSInteger count = orderArray.count;
    
    NSMutableArray *temp = [NSMutableArray array];
    for (int i = 0; i < count; i ++) {
        ZTOrder *order = [[ZTOrder alloc]init];
        order.name = orderArray[i];
        order.index = i + 1;
        [temp addObject:order];
    }
    _totalOrders = temp;
}

- (ZTOrder *)orderWithName:(NSString *)name
{
    for (ZTOrder *order in _totalOrders) {
        if ([name isEqualToString:order.name]) {
            return order;
        }
    }
    return nil;
}


- (void)loadCategoryData
{
    NSArray *plistA = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"Categories.plist" ofType:nil]];
    
    NSMutableArray *iconA = [NSMutableArray array];
    
    for (NSDictionary *dict in plistA) {
        ZTCategory *category = [ZTCategory objectWithKeyValues:dict];
        [iconA addObject:category];
    }
    
    _totalCategories = iconA;
    
}


- (void)loadCityData
{
    _totalCities = [NSMutableDictionary dictionary];
    
    // 存放所有的城市组
    NSMutableArray *cityArray = [NSMutableArray array];
    
    //热门城市组
    ZTCitySection *hostSection = [[ZTCitySection alloc]init];
    hostSection.name = @"热门";
    hostSection.cities = [NSMutableArray array];
    [cityArray addObject:hostSection];
    
    // plist城市
    NSArray *cityP = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"Cities.plist" ofType:nil]];
    
    for (NSDictionary *dic in cityP) {
        ZTCitySection *section = [ZTCitySection objectWithKeyValues:dic];
        [cityArray addObject:section];
        
        for (ZTCity *city in section.cities) {
            if (city.hot) {
                [hostSection.cities addObject:city];
            }
            
            [_totalCities setObject:city forKey:city.name];
        }
    }
    
    //沙盒读取访问过的城市
    _visitedCityNames = [NSKeyedUnarchiver unarchiveObjectWithFile:kFilePath];
    if (_visitedCityNames == nil) {
        _visitedCityNames = [NSMutableArray array];
    }
    
    //最近访问组
    ZTCitySection *vistSection = [[ZTCitySection alloc]init];
    vistSection.name = @"最近";
    vistSection.cities = [NSMutableArray array];
    _visitedSection = vistSection;
    
    
    for (NSString *name in _visitedCityNames) {
        ZTCity *city = _totalCities[name];
        [vistSection.cities addObject:city];
    }
    
    
    if (vistSection.cities.count > 0) {
        // 当前城市
        _currentCity = vistSection.cities.firstObject;
    }
    if (_currentCity == nil) {
        // 添加默认城市
        _currentCity = _totalCities[@"北京"];
    }
    
    if (_visitedCityNames.count != 0) {
        [cityArray insertObject:vistSection atIndex:0];
    }
    
    _totalCitySections = cityArray;
    
}

- (void)setCurrentCity:(ZTCity *)currentCity
{
    _currentCity = currentCity;
    
    // 发出通知
    [[NSNotificationCenter defaultCenter] postNotificationName:kCityChangeNote object:nil];
    
    // 肯定添加“最近访问城市”
    if (![_totalCitySections containsObject:_visitedSection]) {
        NSMutableArray *allSections = (NSMutableArray *)_totalCitySections;
        [allSections insertObject:_visitedSection atIndex:0];
    }
}
@end
