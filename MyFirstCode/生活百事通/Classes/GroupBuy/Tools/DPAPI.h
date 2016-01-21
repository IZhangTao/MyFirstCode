//
//  DPAPI.h
//  生活百事通
//
//  Created by zhangtao on 15/11/25.
//  Copyright (c) 2015年 张涛. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZTSingleton.h"
#import "DPRequest.h"

#define kDPAppKey             @"902353788"
#define kDPAppSecret          @"9146c3fba4464c5ca7200808923d35a3"

@interface DPAPI : NSObject

ZTSingletonH(DPAPI)

- (DPRequest*)requestWithURL:(NSString *)url
                      params:(NSMutableDictionary *)params
                    delegate:(id<DPRequestDelegate>)delegate;

- (DPRequest *)requestWithURL:(NSString *)url
                 paramsString:(NSString *)paramsString
                     delegate:(id<DPRequestDelegate>)delegate;

@end
