//
//  ZTLineLable.m
//  生活百事通
//
//  Created by zhangtao on 15/11/26.
//  Copyright © 2015年 张涛. All rights reserved.
//

#import "ZTLineLable.h"

@implementation ZTLineLable

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    [self.textColor setStroke];
    CGFloat y = rect.size.height * 0.4;
    CGContextMoveToPoint(ctx, 0, y);
    CGContextSetLineWidth(ctx, 1);
    CGContextSetRGBStrokeColor(ctx, 1, 0, 0, 1);
//    CGFloat end = [self.text sizeWithAttributes:@{NSFontAttributeName : self.font}].width;
    CGFloat end = rect.size.width;
    
    
    CGContextAddLineToPoint(ctx, end, y);
    CGContextStrokePath(ctx);
}


@end
