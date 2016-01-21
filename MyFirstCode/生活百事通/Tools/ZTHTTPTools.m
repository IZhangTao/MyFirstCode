//
//  ZTHTTPTools.m
//  生活百事通
//
//  Created by 张涛 on 15/4/22.
//  Copyright (c) 2015年 张涛. All rights reserved.
//

#import "ZTHTTPTools.h"
#import "ZTHttpTool.h"

#define dreamkey @"c7320e83e45b470396aa1733ab6efe36"
#define key @"57f6be2e42d32f61b6be6073b9ce3cc0"
@implementation ZTHTTPTools

+ (void)getWeatherInfoWithCity:(NSString *)city success:(void (^)(id))success faild:(void (^)(NSError *))faild
{
    if (city == nil) {
        return;
    }
    // 请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"location"] = city;
    params[@"ak"] = @"Q0qFFiynCewS75iBPQ9TkChH";
    params[@"output"] = @"json";
    
    [ZTHttpTool getWithURL:@"http://api.map.baidu.com/telematics/v3/weather?" params:params success:^(id json){
        if (success) {
            success(json);
        }
    } failure:^(NSError *error) {
        if (faild) {
            faild(error);
            NSLog(@"%@",error);
        }
        
    }];
    
}

+ (void)getInfoWithIDCard:(NSString *)IDCard success:(void (^)(id))success faild:(void (^)(NSError *))faild
{
    // 请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"idcard"] = IDCard;
    params[@"appkey"] = @"1307ee261de8bbcf83830de89caae73f";
    
    // 发送请求
    [ZTHttpTool getWithURL:@"http://apis.baidu.com/netpopo/idcard/idcard" params:params success:^(id json) {
        if (success) {
            success(json);
        }
    } failure:^(NSError *error) {
        if (faild) {
            faild(error);
            NSLog(@"%@",error);
        }
    }];
}

+(void)getInfoWithPhone:(NSString *)phone success:(void (^)(id))success faild:(void (^)(NSError *))faild
{
    // 请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"phone"] = phone;
    
    // 发送请求
    [ZTHttpTool getWithURL:@"http://apis.baidu.com/apistore/mobilenumber/mobilenumber?" params:params success:^(id json) {
        if (success) {
            success(json);
        }
    } failure:^(NSError *error) {
        if (faild) {
            faild(error);
        }
    }];
    
}

+ (void)getMoneyFrom:(NSString *)currentRate toRate:(NSString *)toRate success:(void (^)(id))success faild:(void (^)(NSError *))faild
{
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"key"] = key;
    params[@"from"] = currentRate;
    params[@"to"] = toRate;
    
    // 发送请求
    [ZTHttpTool getWithURL:@"http://op.juhe.cn/onebox/exchange/currency?" params:params success:^(id json) {
        if (success) {
            success(json);
        }
    } failure:^(NSError *error) {
        if (faild) {
            faild(error);
            NSLog(@"%@",error);
        }
    }];
}

+ (void)getInfoWithDream:(NSString *)dream success:(void (^)(id))success faild:(void (^)(NSError *))faild
{
    // 请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"q"] = dream;
    params[@"key"] = dreamkey;
    
    // 发送请求
    [ZTHttpTool getWithURL:@"http://apis.haoservice.com/lifeservice/dream/query?" params:params success:^(id json) {
        if (success) {
            success(json);
        }
    } failure:^(NSError *error) {
        if (faild) {
            faild(error);
            NSLog(@"%@",error);
        }
    }];
}


+ (void)getInfoWithIP:(NSString *)IP success:(void (^)(id))success faild:(void (^)(NSError *))faild
{
    // 请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"ip"] = IP;

       // 发送请求
    [ZTHttpTool getWithURL:@"http://apis.baidu.com/apistore/iplookupservice/iplookup?" params:params success:^(id json) {
        if (success) {
            success(json);
            
        }
    } failure:^(NSError *error) {
        if (faild) {
            faild(error);
            NSLog(@"%@",error);
        }
    }];
}
@end
