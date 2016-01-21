//
//  ZTTGRestrictCell.m
//  生活百事通
//
//  Created by zhangtao on 15/11/27.
//  Copyright © 2015年 张涛. All rights reserved.
//

#import "ZTTGRestrictCell.h"

@interface ZTTGRestrictCell()

// 是否支持过期退款
@property (weak, nonatomic) IBOutlet UIButton *outTimeRefundBtn;
// 是否支持随时退款
@property (weak, nonatomic) IBOutlet UIButton *anyTimeRefundBtn;
// 销售
@property (weak, nonatomic) IBOutlet UIButton *buyCountBtn;
// 剩余时间
@property (weak, nonatomic) IBOutlet UIButton *LeaveTimeBtn;
@end

@implementation ZTTGRestrictCell

+ (CGFloat)heightWithItem:(NSObject *)item tableViewManager:(RETableViewManager *)tableViewManager
{
    return 70;
}

- (void)cellDidLoad
{
    [super cellDidLoad];
    
}

- (void)cellWillAppear
{
    [super cellWillAppear];
    
    self.outTimeRefundBtn.enabled = self.item.isOutTimeRefund;
    
    self.anyTimeRefundBtn.enabled = self.item.isOutTimeRefund;

    [self.buyCountBtn setTitle:self.item.buyCount forState:UIControlStateDisabled];
 
    [self.LeaveTimeBtn setTitle:self.item.LeaveTime forState:UIControlStateDisabled];
}

@end
