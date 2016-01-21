//
//  ZTWeatherController.m
//  生活百事通
//
//  Created by 张涛 on 15/4/21.
//  Copyright (c) 2015年 张涛. All rights reserved.
//

#import "ZTWeatherViewController.h"
#import "ZTWeatherInfo.h"
#import "ZTMoreWeather.h"
#import "UIView+Extension.h"


@interface ZTWeatherViewController ()
@property (weak, nonatomic) IBOutlet UILabel *dressing;
@property (weak, nonatomic) IBOutlet UILabel *washcar;
@property (weak, nonatomic) IBOutlet UILabel *travel;
@property (weak, nonatomic) IBOutlet UILabel *cold;
@property (weak, nonatomic) IBOutlet UILabel *sports;
@property (weak, nonatomic) IBOutlet UILabel *light;


@end

@implementation ZTWeatherViewController

- (void) viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.title = @"天气详情";
    [self setMoreWeather];
    
    [self setWeatherData];
}

- (void)setMoreWeather{
    
    float moreY = CGRectGetMaxY(self.light.frame) + 30;

    float width = [UIScreen mainScreen].bounds.size.width;
    float height = [UIScreen mainScreen].bounds.size.height;
    
    
    float moreW = width/4;
    float moreH = height - moreY - kBottomMenuItemH;
    
    for (NSInteger i = 0; i < 4; i++) {
        ZTMoreWeather *weatherM = [ZTMoreWeather getMoreWeather];
        float moreX = moreW * i;
        weatherM.frame = CGRectMake(moreX, moreY, moreW, moreH);
        
        ZTWeatherData *data = self.weatherInfo.weather_data[i];
        if (i == 0) {
            NSString *str = data.date;
            str = [str substringToIndex:2];
            weatherM.dateLable.text = str;
        }else{
            weatherM.dateLable.text = data.date;
        }
        
        weatherM.windLable.text = data.wind;
        weatherM.weatherLable.text = data.weather;
        weatherM.temperatureLable.text = data.temperature;
        
        NSString *weather = data.weather;
        NSUInteger strLocation = [weather rangeOfString:@"转"].location;
        if (strLocation != NSNotFound) {
            weather = [weather substringToIndex:strLocation];
        }
        weatherM.weatherImageView.image = [UIImage imageNamed:weather];
        [self.view addSubview:weatherM];
    }
}



- (void)setWeatherData
{
    
    ZTIndexDetail *dress = self.weatherInfo.index[0];
    self.dressing.text = [NSString stringWithFormat:@"%@----->%@",dress.tipt, dress.des];
    
    ZTIndexDetail *wash = self.weatherInfo.index[1];
    self.washcar.text = [NSString stringWithFormat:@"%@----->%@",wash.tipt, wash.des];
    
    ZTIndexDetail *travel = self.weatherInfo.index[2];
    self.travel.text = [NSString stringWithFormat:@"%@----->%@",travel.tipt, travel.des];
    
    ZTIndexDetail *cold = self.weatherInfo.index[3];
    self.cold.text = [NSString stringWithFormat:@"%@----->%@",cold.tipt, cold.des];
    
    ZTIndexDetail *sports = self.weatherInfo.index[4];
    self.sports.text = [NSString stringWithFormat:@"%@----->%@",sports.tipt, sports.des];
    
    ZTIndexDetail *light = self.weatherInfo.index[5];
    self.light.text = [NSString stringWithFormat:@"%@----->%@",light.tipt, light.des];
    

}




@end
