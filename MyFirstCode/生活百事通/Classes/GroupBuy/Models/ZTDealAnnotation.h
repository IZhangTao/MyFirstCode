//
//  ZTDealAnnotation.h
//  生活百事通
//
//  Created by zhangtao on 15/12/17.
//  Copyright © 2015年 张涛. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
@interface ZTDealAnnotation : NSObject<MKAnnotation>

@property (nonatomic, assign) CLLocationCoordinate2D coordinate;
@property (nonatomic, copy) NSString *deal_id; // 显示的哪个团购
@property (nonatomic, copy) NSString *title;
@end
