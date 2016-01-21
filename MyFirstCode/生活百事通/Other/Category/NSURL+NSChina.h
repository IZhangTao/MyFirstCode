//
//  NSURL+NSChina.h
//  生活百事通
//
//  Created by 张涛 on 15/4/25.
//  Copyright (c) 2015年 张涛. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSURL (NSChina)
/**
 *  传入一个包含汉字的字符串，转为URL
 */
+ (NSURL *)urlWithString:(NSString *)str chinaStr:(NSString *)chinaStr;
/**
 *  传入一个包含汉字的字符串，转为URLString
 */
+ (NSString *)urlStringWithString:(NSString *)str chinaStr:(NSString *)chinaStr;
@end
