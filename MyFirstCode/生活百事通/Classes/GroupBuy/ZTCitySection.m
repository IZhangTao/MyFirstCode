//
//  KLCitySection.m
//  KnowingLife
//
//  Created by tanyang on 14/11/1.
//  Copyright (c) 2014年 tany. All rights reserved.
//

#import "ZTCitySection.h"
#import "MJExtension.h"
#import "ZTCity.h"

@implementation ZTCitySection
- (NSDictionary *)objectClassInArray
{
    return @{@"cities" : [ZTCity class]};
}
@end
