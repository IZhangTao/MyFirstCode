//
//  ZTTGRestrictCell.h
//  生活百事通
//
//  Created by zhangtao on 15/11/27.
//  Copyright © 2015年 张涛. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RETableViewCell.h"
#import "ZTRestrictItem.h"
@interface ZTTGRestrictCell : RETableViewCell

@property (strong, readwrite, nonatomic) ZTRestrictItem *item;

@end
