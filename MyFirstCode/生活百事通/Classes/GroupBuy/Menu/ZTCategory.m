//
//  ZTCategory.m
//  生活百事通
//
//  Created by zhangtao on 15/11/20.
//  Copyright (c) 2015年 张涛. All rights reserved.
//

#import "ZTCategory.h"
#import "MJExtension.h"
#import "ZTSubCategorie.h"

@implementation ZTCategory

- (NSDictionary *)objectClassInArray
{
    return @{@"subcategories":[ZTSubCategorie class]};
}

@end
