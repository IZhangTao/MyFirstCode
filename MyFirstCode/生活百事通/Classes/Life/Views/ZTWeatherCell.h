//
//  ZTWeatherCell.h
//  生活百事通
//
//  Created by 张涛 on 15/4/23.
//  Copyright (c) 2015年 张涛. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZTWeatherInfo;
@interface ZTWeatherCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UILabel *cityLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLable;
@property (weak, nonatomic) IBOutlet UILabel *temperatureLable;
@property (weak, nonatomic) IBOutlet UILabel *PM25;
@property (weak, nonatomic) IBOutlet UILabel *windLable;
@property (weak, nonatomic) IBOutlet UIImageView *weatherImageView;
@property (weak, nonatomic) IBOutlet UILabel *weatherLable;

@property (nonatomic ,strong) ZTWeatherInfo *weatherInfo;
@end
