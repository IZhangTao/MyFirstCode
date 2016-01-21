//
//  ZTLifeViewController.h
//  生活百事通
//
//  Created by 张涛 on 15/4/23.
//  Copyright (c) 2015年 张涛. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZTWeatherInfo;
@interface ZTLifeViewController : UICollectionViewController

@property (nonatomic ,strong) ZTWeatherInfo *weatherInfo;
@end
