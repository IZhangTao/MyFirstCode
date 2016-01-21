//
//  ZTRestriction.h
//  生活百事通
//
//  Created by zhangtao on 15/12/8.
//  Copyright © 2015年 张涛. All rights reserved.
//

#import <Foundation/Foundation.h>
//附加信息
@interface ZTRestriction : NSObject

// 是否需要预约，0：不是，1：是
@property (nonatomic, assign) BOOL is_reservation_required;
// 是否支持随时退款，0：不是，1：是
@property (nonatomic, assign) BOOL is_refundable;
// （购买须知）附加信息
@property (nonatomic, copy) NSString * special_tips;

@end
