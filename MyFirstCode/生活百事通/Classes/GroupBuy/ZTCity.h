//
//  KLCity.h
//  KnowingLife
//
//  Created by tanyang on 14/11/1.
//  Copyright (c) 2014年 tany. All rights reserved.
//


#import <CoreLocation/CoreLocation.h>

@interface ZTCity : NSObject
// 分区
@property (nonatomic, strong) NSArray *districts;
// 热门
@property (nonatomic, assign) BOOL hot;
// 经度纬度
@property (nonatomic, assign) CLLocationCoordinate2D position;

@property (nonatomic, copy) NSString *name;//!<<#string#>
@end
