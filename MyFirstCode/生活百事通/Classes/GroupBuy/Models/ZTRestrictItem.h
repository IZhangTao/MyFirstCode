//
//  ZTRestrictItem.h
//  生活百事通
//
//  Created by zhangtao on 15/12/8.
//  Copyright © 2015年 张涛. All rights reserved.
//

#import "RETableViewItem.h"
@class ZTDeal;
@interface ZTRestrictItem : RETableViewItem

@property (nonatomic, strong) ZTDeal *deal;
// 是否支持过期退款
@property (nonatomic, assign) BOOL isOutTimeRefund;
// 是否支持随时退款
@property (nonatomic, assign) BOOL isAnyTimeRefund;
// 销售
@property (nonatomic, copy) NSString *buyCount;
// 剩余时间
@property (nonatomic, copy) NSString *LeaveTime;
@end
