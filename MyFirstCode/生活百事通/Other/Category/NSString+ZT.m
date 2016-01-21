//
//  NSString+TG.m
//  KnowingLife
//
//  Created by tanyang on 14/11/3.
//  Copyright (c) 2014年 tany. All rights reserved.
//

#import "NSString+ZT.h"

@implementation NSString (ZT)

+ (NSString *)stringWithDouble:(double)value fractionCount:(int)fractionCount
{
    if (fractionCount < 0) return nil;
    
    // 1.fmt ---> %.2f
    NSString *fmt = [NSString stringWithFormat:@"%%.%df", fractionCount];
    
    // 2.生成保留fractionCount位小数的字符串
    NSString *stringFloat = [NSString stringWithFormat:fmt, value];
    
    const char *floatChars = [stringFloat UTF8String];
    NSUInteger length = [stringFloat length];
    NSUInteger zeroLength = 0;
    int i = (int)length-1;
    for(; i>=0; i--)
    {
        if(floatChars[i] == '0'/*0x30*/) {
            zeroLength++;
        } else {
            if(floatChars[i] == '.')
                i--;
            break;
        }
    }
    NSString *returnString;
    if(i == -1) {
        returnString = @"0";
    } else {
        returnString = [stringFloat substringToIndex:i+1];
    }
    
    return returnString;
}

- (CGSize)textSizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size lineBreakMode:(NSLineBreakMode)lineBreakMode
{
    CGSize textSize;
    if (CGSizeEqualToSize(size, CGSizeZero))
    {
        // NSDictionary *attributes = @{NSFontAttributeName:font}
        NSDictionary *attributes = [NSDictionary dictionaryWithObject:font forKey:NSFontAttributeName];
        // textSize = [self sizeWithAttributes:attributes];
        // textSize = []
        
        textSize = [self sizeWithAttributes:attributes];
    }
    else
    {
        NSStringDrawingOptions option = NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
        //NSStringDrawingTruncatesLastVisibleLine如果文本内容超出指定的矩形限制，文本将被截去并在最后一个字符后加上省略号。 如果指定了NSStringDrawingUsesLineFragmentOrigin选项，则该选项被忽略 NSStringDrawingUsesFontLeading计算行高时使用行间距。（译者注：字体大小+行间距=行高）
        NSDictionary *attributes = [NSDictionary dictionaryWithObject:font forKey:NSFontAttributeName];
        CGRect rect = [self boundingRectWithSize:size
                                         options:option
                                      attributes:attributes
                                         context:nil];
        
        textSize = rect.size;
    }
    return textSize;
}

#warning 增加对json解析字符串的处理
//把没有双引号和用了单引号的json字符串转化为标准格式字符串;
+ (NSString *)changeJsonStringToTrueJsonString:(NSString *)json
{
    // 将没有双引号的替换成有双引号的
    NSString *validString = [json stringByReplacingOccurrencesOfString:@"(\\w+)\\s*:([^A-Za-z0-9_])"
                                                            withString:@"\"$1\":$2"
                                                               options:NSRegularExpressionSearch
                                                                 range:NSMakeRange(0, [json length])];
    
    //把'单引号改为双引号"
    validString = [validString stringByReplacingOccurrencesOfString:@"([:\\[,\\{])'"
                                                         withString:@"$1\""
                                                            options:NSRegularExpressionSearch
                                                              range:NSMakeRange(0, [validString length])];
    validString = [validString stringByReplacingOccurrencesOfString:@"'([:\\],\\}])"
                                                         withString:@"\"$1"
                                                            options:NSRegularExpressionSearch
                                                              range:NSMakeRange(0, [validString length])];
    
    //再重复一次 将没有双引号的替换成有双引号的
    validString = [validString stringByReplacingOccurrencesOfString:@"([:\\[,\\{])(\\w+)\\s*:"
                                                         withString:@"$1\"$2\":"
                                                            options:NSRegularExpressionSearch
                                                              range:NSMakeRange(0, [validString length])];
    return validString;
}

@end
