//
//  ZTSection.h
//  生活百事通
//
//  Created by 张涛 on 15/4/23.
//  Copyright (c) 2015年 张涛. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZTSection : NSObject

// 头部标题
@property (nonatomic, copy) NSString *headerTitle;
// 尾部标题
@property (nonatomic, copy) NSString *footerTitle;

@property (nonatomic, weak) UIView *headerView;

@property (nonatomic, weak) UIView *footerView;

// 存放item的数组
@property (nonatomic, copy) NSMutableArray *items;

+(instancetype)section;

@end
