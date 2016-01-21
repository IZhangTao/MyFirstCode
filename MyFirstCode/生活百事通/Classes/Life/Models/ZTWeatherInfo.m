//
//  ZTWeatherInfo.m
//  生活百事通
//
//  Created by 张涛 on 15/4/22.
//  Copyright (c) 2015年 张涛. All rights reserved.
//

#import "ZTWeatherInfo.h"

@implementation ZTWeatherInfo

- (NSDictionary *)objectClassInArray
{
    return @{@"index": [ZTIndexDetail class], @"weather_data": [ZTWeatherData class]};
}
@end



@implementation ZTIndexDetail

@end


@implementation ZTWeatherData

@end

