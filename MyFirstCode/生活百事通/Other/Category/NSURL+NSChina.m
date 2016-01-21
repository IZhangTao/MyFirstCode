//
//  NSURL+NSChina.m
//  生活百事通
//
//  Created by 张涛 on 15/4/25.
//  Copyright (c) 2015年 张涛. All rights reserved.
//

#import "NSURL+NSChina.h"

@implementation NSURL (NSChina)

+ (NSURL *)urlWithString:(NSString *)str chinaStr:(NSString *)chinaStr{
    NSString *path = [str stringByAppendingFormat:@"%@",chinaStr];
    
    NSString *strUrl = [path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    return [NSURL URLWithString:strUrl];
}

+ (NSString *)urlStringWithString:(NSString *)str chinaStr:(NSString *)chinaStr
{
    NSString *string = [chinaStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSString *strUrl = [str stringByAppendingString:string];

    return strUrl;
}
@end
