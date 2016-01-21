//
//  ZTCity.m
//  生活百事通
//
//  Created by 张涛 on 15/4/25.
//  Copyright (c) 2015年 张涛. All rights reserved.
//
#import "ZTLocationCity.h"
#import "MBProgressHUD+ZT.h"
@implementation ZTLocationTool
@end

@interface ZTLocationCity () <CLLocationManagerDelegate>
@property (nonatomic,strong) CLLocationManager *mgr;
@property (nonatomic,strong) CLGeocoder *geo;
@end

@implementation ZTLocationCity
ZTSingletonM(ZTLocationCity)

- (id)init
{
    if (self = [super init]) {
        if ([CLLocationManager locationServicesEnabled]) {
            _geo = [[CLGeocoder alloc] init];
            _mgr = [[CLLocationManager alloc] init];
            
            [_mgr requestAlwaysAuthorization];
            [_mgr startUpdatingLocation];
            _mgr.delegate = self;
            
        }else{
          [MBProgressHUD showError:@"对象没有被创建"];
        }
    }
    return self;
}


- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{

    // 1.停止定位
    [_mgr stopUpdatingLocation];
    
    // 2.根据经纬度反向获得城市名称
    CLLocation *location = [locations firstObject];
    
    [_geo reverseGeocodeLocation:location completionHandler:
     ^(NSArray *placemarks, NSError *error) {
         
         
         // 取出位置
         CLPlacemark *place = placemarks[0];
        
         NSString *cityName = place.administrativeArea ;
         
         
         // 设置定位城市
         _locationCity = [[ZTLocationTool alloc]init];
         _locationCity.city = cityName;
         _locationCity.coordinate = location.coordinate;
         
         // 发出通知
         [[NSNotificationCenter defaultCenter] postNotificationName:ZTCurrentCityMessage object:nil];
     }];
}

-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    if ([error code]==kCLErrorDenied) {        
        [MBProgressHUD showError:@"访问被拒绝"];
       
    }
    if ([error code]==kCLErrorLocationUnknown) {
        [MBProgressHUD showError:@"无法获取位置信息"];
    }
    
    // 发出通知
    [[NSNotificationCenter defaultCenter] postNotificationName:ZTNOCityMessage object:nil];
}
@end
