//
//  ZTImageItem.h
//  生活百事通
//
//  Created by zhangtao on 15/12/8.
//  Copyright © 2015年 张涛. All rights reserved.
//

#import "RETableViewItem.h"

@interface ZTImageItem : RETableViewItem

@property (copy, readwrite, nonatomic) NSString *imageName;

@property (nonatomic, copy) NSString *imageUrl;
// 免预约
@property (nonatomic, assign) BOOL isReservation;

+ (ZTImageItem *)itemWithImageNamed:(NSString *)imageName;

+ (ZTImageItem *)itemWithImageUrl:(NSString *)imageUrl isReservation:(BOOL)isReservation;

@end
