//
//  ZTCategory.h
//  生活百事通
//
//  Created by zhangtao on 15/11/20.
//  Copyright (c) 2015年 张涛. All rights reserved.
//

#import "ZTBaseCategory.h"

@interface ZTCategory : ZTBaseCategory

@property (nonatomic, copy) NSString *icon;
@property (nonatomic, strong) NSArray *subcategories;
@end
