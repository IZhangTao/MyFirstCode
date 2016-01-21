//
//  NSString+TG.h
//  KnowingLife
//
//  Created by tanyang on 14/11/3.
//  Copyright (c) 2014年 tany. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (ZT)
/**
 *  字符串保留小数位数
 */
+ (NSString *)stringWithDouble:(double)value fractionCount:(int)fractionCount;
/**
 *  根据字体大小，预设size,换行模式
 */
- (CGSize)textSizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size lineBreakMode:(NSLineBreakMode)lineBreakMode;

+ (NSString *)changeJsonStringToTrueJsonString:(NSString *)json;
@end
