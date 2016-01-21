//
//  ZTWeatherInfo.h
//  生活百事通
//
//  Created by 张涛 on 15/4/22.
//  Copyright (c) 2015年 张涛. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ZTIndexDetail;
@class ZTWeatherData;
@interface ZTWeatherInfo : NSObject
// 当前城市
@property (nonatomic, copy) NSString *currentCity;
// 当前日期
@property (nonatomic, copy) NSString *date;
// pm25
@property (nonatomic, copy) NSString *pm25;
// 细节信息
@property (nonatomic, strong) NSArray *index;
// 天气详情
@property (nonatomic, strong) NSArray *weather_data;
@end

// 细节信息
@interface ZTIndexDetail : NSObject

// 内容
@property (nonatomic, copy) NSString *zs;
// 指数
@property (nonatomic, copy) NSString *tipt;
// 细节
@property (nonatomic, copy) NSString *des;

@end

// 天气详情
@interface ZTWeatherData : NSObject
// 日期
@property (nonatomic, copy) NSString *date;
// 天气
@property (nonatomic, copy) NSString *weather;
// 风力
@property (nonatomic, copy) NSString *wind;
// 温度
@property (nonatomic, copy) NSString *temperature;
//夜间图片
//@property (nonatomic, copy) NSString *nightPictureUrl;
//白天图片
@property (nonatomic, copy) NSString *dayPictureUrl;
@end
