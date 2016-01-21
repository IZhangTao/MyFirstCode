//
//  ZTCityController.h
//  生活百事通
//
//  Created by 张涛 on 15/4/22.
//  Copyright (c) 2015年 张涛. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol  ZTCityControllerDelegate <NSObject>

- (void)cityControllerSelectedWithCity:(NSString *)city;

@end
@interface ZTCityController : UITableViewController

@property (nonatomic ,weak) id <ZTCityControllerDelegate>  delegate;


@end
