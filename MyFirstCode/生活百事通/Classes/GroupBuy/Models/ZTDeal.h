//
//  ZTDeal.h
//  生活百事通
//
//  Created by zhangtao on 15/11/25.
//  Copyright (c) 2015年 张涛. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ZTRestriction;
@interface ZTDeal : NSObject

@property (nonatomic, copy) NSString *desc; // 描述
@property (nonatomic, strong) NSArray *categories; // 分类
@property (nonatomic, copy) NSString *deal_url; // url
@property (nonatomic, strong) NSString *publish_date; // 发布日期
@property (nonatomic, assign) int purchase_count; // 已购买人数
@property (nonatomic, copy) NSString *image_url; // 图片
@property (nonatomic, copy) NSString *deal_id; // 团购ID
@property (nonatomic, copy) NSString *title; // 标题
@property (nonatomic, strong) NSString *purchase_deadline; // 下架日期
@property (nonatomic, copy) NSString *s_image_url; // 小图
@property (nonatomic, copy) NSString *city; // 城市
@property (nonatomic, strong) NSArray *regions; // 区域
@property (nonatomic, assign) double current_price; // 当前价格

// 商家信息
@property (nonatomic, strong) NSArray *businesses;

@property (nonatomic, copy) NSString *deal_h5_url; // 链接
@property (nonatomic, assign) double list_price; // 原价


@property (nonatomic, assign) int distance; // -1
@property (nonatomic, assign) int commission_ratio; // 0
@property (nonatomic, copy, readonly) NSString *list_price_text; // 原价
@property (nonatomic, copy, readonly) NSString *current_price_text; // 当前价格

@property (nonatomic, strong) ZTRestriction *restrictions;// 限制


// 详情界面需要显示的数据
@property (nonatomic, copy) NSString *details; // 团购详情
@property (nonatomic, copy) NSString *notice; // 重要通知

@end
