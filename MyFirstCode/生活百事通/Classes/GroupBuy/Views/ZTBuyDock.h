//
//  ZTBuyDock.h
//  生活百事通
//
//  Created by zhangtao on 15/11/27.
//  Copyright © 2015年 张涛. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZTLineLable.h"

@interface ZTBuyDock : UIView

@property (weak, nonatomic) IBOutlet UILabel *priceLable;

@property (weak, nonatomic) IBOutlet ZTLineLable *originalPriceLable;

@property (weak, nonatomic) IBOutlet UILabel *yuanLable;
@property (weak, nonatomic) IBOutlet UIButton *buyBtn;


+ (instancetype)buyDockWithNowPrice:(NSString *)nowPrice originalPrice:(NSString *)originalPrice clickedHander:(void(^)(void))clicked;


@end
