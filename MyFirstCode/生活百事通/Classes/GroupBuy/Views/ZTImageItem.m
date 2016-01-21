//
//  ZTImageItem.m
//  生活百事通
//
//  Created by zhangtao on 15/12/8.
//  Copyright © 2015年 张涛. All rights reserved.
//

#import "ZTImageItem.h"

@implementation ZTImageItem

+ (ZTImageItem *)itemWithImageNamed:(NSString *)imageName
{
    ZTImageItem *item = [[ZTImageItem alloc] init];
    item.imageName = imageName;
    return item;
}

+ (ZTImageItem *)itemWithImageUrl:(NSString *)imageUrl isReservation:(BOOL)isReservation
{
    ZTImageItem *item = [[ZTImageItem alloc] init];
    item.imageUrl = imageUrl;
    item.isReservation = isReservation;
    return item;
}

@end
