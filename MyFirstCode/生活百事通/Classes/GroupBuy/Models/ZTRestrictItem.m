//
//  ZTRestrictItem.m
//  生活百事通
//
//  Created by zhangtao on 15/12/8.
//  Copyright © 2015年 张涛. All rights reserved.
//

#import "ZTRestrictItem.h"
#import "ZTDeal.h"
#import "ZTRestriction.h"
#import "NSDate+WB.h"

@implementation ZTRestrictItem

- (void)setDeal:(ZTDeal *)deal
{
    self.buyCount = [NSString stringWithFormat:@"已销售%d",deal.purchase_count];
    
    // 设置剩余时间
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd"; // 2013-11-17
    // 2013-11-17
    NSDate *dealline = [fmt dateFromString:deal.purchase_deadline];
    // 2013-11-18 00:00:00
    dealline = [dealline dateByAddingTimeInterval:24 * 3600];
    // 2013-11-17 10:50
    NSDate *now = [NSDate date];
    
    NSDateComponents *cmps = [now compare:dealline];
    
    self.LeaveTime = [NSString stringWithFormat:@"%ld天%ld小时%ld分",(long)cmps.day,(long)cmps.hour,(long)cmps.minute];
    
    ZTRestriction *restriction = deal.restrictions;
    
    self.isOutTimeRefund = restriction.is_refundable;
    
    self.isAnyTimeRefund = restriction.is_refundable;

}

@end
