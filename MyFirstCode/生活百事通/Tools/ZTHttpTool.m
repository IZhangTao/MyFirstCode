//
//  ZTHttpTool.m
//  生活百事通
//
//  Created by 张涛 on 15/4/22.
//  Copyright (c) 2015年 张涛. All rights reserved.
//

#import "ZTHttpTool.h"
#import "AFNetworking.h"

@implementation ZTHttpTool

+ (void)postWithURL:(NSString *)url params:(NSDictionary *)params success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure
{
    // AFNetWorking
    // 创建请求管理对象
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    // 发生请求
    [manager POST:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
    
    
}

+ (void)postXmlWithURL:(NSString *)url params:(NSDictionary *)params success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure
{
    // AFNetWorking
    // 创建请求管理对象
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    //NSDictionary *params = @{@"format": @"xml"};
    // 发生请求
    [manager POST:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
    
    
}

+ (void)postWithURL:(NSString *)url params:(NSDictionary *)params formDataArray:(NSArray *)formDataArray success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    // AFNetWorking
    // 创建请求管理对象
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    // 发送请求
    [manager POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> allFormData) {
        for (ZTFormData *formData in formDataArray) {
            [allFormData appendPartWithFileData:formData.data name:formData.name fileName:formData.filename mimeType:formData.mimeType];
        }
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)getWithURL:(NSString *)url params:(NSDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    // AFNetWorking
    // 创建请求管理对象
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    //头文件设置apikey 查询手机用
    [manager.requestSerializer setValue:@"99d0def0611a05b9a6bd30c77bbe3fc0" forHTTPHeaderField:@"apikey"];

    //回调类型是Data
//    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
//    [manager setResponseSerializer:[AFXMLParserResponseSerializer new]];
//    manager.responseSerializer = [AFHTTPResponseSerializer serializer];//使用这个将得到的是NSData
    manager.responseSerializer = [AFJSONResponseSerializer serializer];//默认是JSON
    
    // 发生请求
    [manager GET:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if (success) {
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
    
}
@end

/**
 *  用来封装文件数据的模型
 */
@implementation ZTFormData
@end
