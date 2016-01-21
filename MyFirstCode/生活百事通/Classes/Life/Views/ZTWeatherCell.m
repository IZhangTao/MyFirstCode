//
//  ZTWeatherCell.m
//  生活百事通
//
//  Created by 张涛 on 15/4/23.
//  Copyright (c) 2015年 张涛. All rights reserved.
//

#import "ZTWeatherCell.h"
#import "ZTWeatherInfo.h"

@implementation ZTWeatherCell

- (void)awakeFromNib {
    self.userInteractionEnabled = YES;
}

- (void)setWeatherInfo:(ZTWeatherInfo *)weatherInfo
{
    ZTWeatherData *weatherData = weatherInfo.weather_data[0];
  
    self.cityLabel.text = weatherInfo.currentCity;
    self.dateLable.text = weatherInfo.date;
    self.windLable.text = weatherData.wind;
    self.temperatureLable.text = weatherData.temperature;
    self.PM25.text = [NSString stringWithFormat:@"PM25: %@",weatherInfo.pm25];
    
    NSString *weather = weatherData.weather;
    NSUInteger strLocation = [weather rangeOfString:@"转"].location;
    if (strLocation != NSNotFound) {
        weather = [weather substringToIndex:strLocation];
    }
    self.weatherImageView.image = [UIImage imageNamed:weather];
    self.weatherLable.text = weatherData.weather;
}

@end
