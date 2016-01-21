//
//  ZTMoreWeather.h
//  生活百事通
//
//  Created by 张涛 on 15/4/26.
//  Copyright (c) 2015年 张涛. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZTMoreWeather : UIView

@property (weak, nonatomic) IBOutlet UILabel *dateLable;
@property (weak, nonatomic) IBOutlet UILabel *temperatureLable;
@property (weak, nonatomic) IBOutlet UILabel *windLable;
@property (weak, nonatomic) IBOutlet UIImageView *weatherImageView;
@property (weak, nonatomic) IBOutlet UILabel *weatherLable;


//白天图片
@property (nonatomic, copy) NSString *dayPictureUrl;
+ (ZTMoreWeather *)getMoreWeather;
@end
