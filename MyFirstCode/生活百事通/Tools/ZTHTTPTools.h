//
//  ZTHTTPTools.h
//  生活百事通
//
//  Created by 张涛 on 15/4/22.
//  Copyright (c) 2015年 张涛. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZTHTTPTools : NSObject

//获取天气数据
+ (void) getWeatherInfoWithCity:(NSString *)city success:(void(^)(id json))success faild:(void (^)(NSError *error))faild;

// 获得身份证数据
+ (void)getInfoWithIDCard:(NSString *)IDCard success:(void(^)(id json))success faild:(void (^)(NSError *error))faild;

// 获得手机号数据
+ (void)getInfoWithPhone:(NSString *)phone success:(void(^)(id json))success faild:(void (^)(NSError *error))faild;

// 获得货币汇率数据 from 兑换货币  to 换入货币
+ (void)getMoneyFrom:(NSString *)currentRate toRate:(NSString *)toRate success:(void(^)(id json))success faild:(void (^)(NSError *error))faild;

// 获得梦境信息
+ (void)getInfoWithDream:(NSString *)dream success:(void(^)(id json))success faild:(void (^)(NSError *error))faild;

// 获得IP地址数据
+ (void)getInfoWithIP:(NSString *)IP success:(void (^)(id json))success faild:(void (^)(NSError *error))faild;

@end
