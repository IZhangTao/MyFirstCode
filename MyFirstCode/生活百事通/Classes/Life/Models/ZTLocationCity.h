//
//  ZTCity.h
//  生活百事通
//
//  Created by 张涛 on 15/4/25.
//  Copyright (c) 2015年 张涛. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "ZTSingleton.h"

//城市位置类
@interface ZTLocationTool : NSObject
@property (nonatomic, copy) NSString *city;
@property (nonatomic, assign) CLLocationCoordinate2D coordinate;

@end

// 通知名
#define LocationCityNote @"location_City_Note"

@interface ZTLocationCity : NSObject
ZTSingletonH(ZTLocationCity)

// 定位城市
@property (nonatomic, strong) ZTLocationTool *locationCity;

@end



