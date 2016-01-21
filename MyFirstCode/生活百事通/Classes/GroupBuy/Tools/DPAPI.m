//
//  DPAPI.m
//  生活百事通
//
//  Created by zhangtao on 15/11/25.
//  Copyright (c) 2015年 张涛. All rights reserved.
//

#import "DPAPI.h"
#import "DPConstants.h"

@implementation DPAPI
{
    NSMutableSet *requests;
}

ZTSingletonM(DPAPI)

- (id)init {
    self = [super init];
    if (self) {
        requests = [[NSMutableSet alloc] init];
    }
    return self;
}

- (DPRequest*)requestWithURL:(NSString *)url
                      params:(NSMutableDictionary *)params
                    delegate:(id<DPRequestDelegate>)delegate {
    if (params == nil) {
        params = [NSMutableDictionary dictionary];
    }
    
    NSString *fullURL = [kDPAPIDomain stringByAppendingString:url];
    
    DPRequest *_request = [DPRequest requestWithURL:fullURL
                                             params:params
                                           delegate:delegate];
    _request.dpapi = self;
    [requests addObject:_request];
    [_request connect];
    return _request;
}

- (DPRequest *)requestWithURL:(NSString *)url
                 paramsString:(NSString *)paramsString
                     delegate:(id<DPRequestDelegate>)delegate {
    return [self requestWithURL:[NSString stringWithFormat:@"%@?%@", url, paramsString] params:nil delegate:delegate];
}

- (void)requestDidFinish:(DPRequest *)request
{
    [requests removeObject:request];
    request.dpapi = nil;
}

- (void)dealloc
{
    for (DPRequest* _request in requests)
    {
        _request.dpapi = nil;
    }
}


@end
