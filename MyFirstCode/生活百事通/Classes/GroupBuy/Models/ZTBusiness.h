//
//  ZTBusiness.h
//  生活百事通
//
//  Created by zhangtao on 15/11/26.
//  Copyright © 2015年 张涛. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZTBusiness : NSObject

@property (nonatomic, copy) NSString * city;
@property (nonatomic, copy) NSString * h5_url;
@property (nonatomic, assign) int ID;
@property (nonatomic, assign) double latitude;
@property (nonatomic, assign) double longitude;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString * url;
@end
