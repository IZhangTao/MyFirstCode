//
//  ZTDeal.m
//  生活百事通
//
//  Created by zhangtao on 15/11/25.
//  Copyright (c) 2015年 张涛. All rights reserved.
//

#import "ZTDeal.h"
#import "MJExtension.h"
#import "ZTBusiness.h"
#import "NSString+ZT.h"

@implementation ZTDeal

- (NSDictionary *)objectClassInArray
{
    return @{@"businesses":[ZTBusiness class]};
}

- (void)setList_price:(double)list_price
{
    _list_price = list_price;
    _list_price_text = [NSString stringWithDouble:list_price fractionCount:2];
}

- (void)setCurrent_price:(double)current_price
{
    _current_price = current_price;
    
    _current_price_text = [NSString stringWithDouble:_current_price fractionCount:2];
}
@end
