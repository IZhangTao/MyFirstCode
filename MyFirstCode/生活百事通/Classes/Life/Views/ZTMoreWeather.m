//
//  ZTMoreWeather.m
//  生活百事通
//
//  Created by 张涛 on 15/4/26.
//  Copyright (c) 2015年 张涛. All rights reserved.
//

#import "ZTMoreWeather.h"


@implementation ZTMoreWeather

+(ZTMoreWeather *)getMoreWeather{
    return [[[NSBundle mainBundle]loadNibNamed:@"ZTMoreWeather" owner:nil options:nil] lastObject];
}
@end
