//
//  ZTCoverView.m
//  生活百事通
//
//  Created by zhangtao on 15/12/17.
//  Copyright © 2015年 张涛. All rights reserved.
//

#import "ZTCoverView.h"

#define kAlpha 0.6


@implementation ZTCoverView
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 1.背景色
        self.backgroundColor = [UIColor blackColor];
        
        // 2.自动伸缩
        self.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        
        // 3.透明度
        self.alpha = kAlpha;
    }
    return self;
}

- (void)reset
{
    self.alpha = kAlpha;
}

+ (id)cover
{
    return [[self alloc] init];
}

+ (id)coverWithTarget:(id)target action:(SEL)action
{
    ZTCoverView *cover = [self cover];
    
    [cover addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:target action:action]];
    
    return cover;
}

@end
