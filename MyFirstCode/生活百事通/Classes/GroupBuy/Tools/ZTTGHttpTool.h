//
//  ZTTGHttpTool.h
//  生活百事通
//
//  Created by zhangtao on 15/11/25.
//  Copyright (c) 2015年 张涛. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZTSingleton.h"



@class ZTDeal;
// deals里面装的都是模型数据
typedef void (^DealsSuccessBlock)(NSArray *deals, int totalCount);
typedef void (^DealsErrorBlock)(NSError *error);

// deal里面装的都是模型数据
typedef void (^DealSuccessBlock)(ZTDeal *deal);
typedef void (^DealErrorBlock)(NSError *error);


typedef void (^RequestBlock)(id result, NSError *errorObj);



@interface ZTTGHttpTool : NSObject
ZTSingletonH(ZTTGHttpTool)

// 基本封装
- (void)requestWithURL:(NSString *)url params:(NSMutableDictionary *)params block:(RequestBlock)block;

// 获得第page页的团购数据
- (void)dealsWithPage:(int)page district:(NSString *)district category:(NSString *)category orderIndext:(NSInteger)orderIndext success:(DealsSuccessBlock)success error:(DealsErrorBlock)error;

// 获得指定团购数据
- (void)dealWithID:(NSString *)ID success:(DealSuccessBlock)success error:(DealErrorBlock)error;

// 获得周边团购数据
- (void)dealsWithLatitude:(CGFloat)latitude longitude:(CGFloat)longitude success:(DealsSuccessBlock)success error:(DealsErrorBlock)error;

@end
