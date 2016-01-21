//
//  ZTSection.m
//  生活百事通
//
//  Created by 张涛 on 15/4/23.
//  Copyright (c) 2015年 张涛. All rights reserved.
//

#import "ZTSection.h"

@implementation ZTSection

+ (instancetype)section
{
    return [[self alloc]init];
}

- (id)init
{
    if (self = [super init]) {
        _items = [NSMutableArray array];
    }
    return self;
}

@end
