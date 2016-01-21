//
//  WBDetailLableItem.m
//  XinWeibo
//
//  Created by tanyang on 14/10/23.
//  Copyright (c) 2014年 tany. All rights reserved.
//

#import "WBSubtitleItem.h"

@implementation WBSubtitleItem
+ (instancetype)itemWithTitle:(NSString *)title subtitle:(NSString *)subtitle
{
    WBSubtitleItem *item = [[WBSubtitleItem alloc]init];
    item.title = title;
    item.subtitle = subtitle;
    
    return item;
}

+ (instancetype)itemWithTitle:(NSString *)title rightSubtitle:(NSString *)subtitle
{
    WBSubtitleItem *item = [WBSubtitleItem itemWithTitle:title subtitle:subtitle];
    item.subtitleFont = [UIFont systemFontOfSize:16];
    item.subtitleAlignment = NSTextAlignmentRight;
    return item;
}

+ (instancetype)itemWithTitle:(NSString *)title imageName:(NSString *)imageName
{
    WBSubtitleItem *item = [[WBSubtitleItem alloc]init];
    item.title = title;
    item.image = [UIImage imageNamed:imageName];
    
    return item;
}

+ (instancetype)itemWithTitle:(NSString *)title subtitle:(NSString *)subtitle imageName:(NSString *)imageName
{
    WBSubtitleItem *item = [WBSubtitleItem itemWithTitle:title subtitle:subtitle];
    item.image = [UIImage imageNamed:imageName];
    return item;
}
@end
