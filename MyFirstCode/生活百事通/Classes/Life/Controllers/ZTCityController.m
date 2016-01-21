
//
//  ZTCityController.m
//  生活百事通
//
//  Created by 张涛 on 15/4/22.
//  Copyright (c) 2015年 张涛. All rights reserved.
//

#import "ZTCityController.h"
#import "ZTLocationCity.h"

@interface ZTCityController ()

@property (nonatomic ,strong) NSArray *provinces;

@end

@implementation ZTCityController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"城市选择";
}

#pragma mark - 数据源方法

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return self.provinces.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    NSDictionary *citysDic = self.provinces[section];
    NSArray * citys = citysDic[@"Cities"];
    return citys.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellID = @"CityCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellID];
    }
    NSDictionary *citysDic = self.provinces[indexPath.section];
    NSArray * citys = citysDic[@"Cities"];
    
    NSDictionary *cityInfoDic = citys[indexPath.row];
    cell.textLabel.text = cityInfoDic[@"city"];
    
    return cell;
    
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSDictionary *provinceInfo = self.provinces[section];
    return provinceInfo[@"State"];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *cityDic = self.provinces[indexPath.section];
    NSArray *citys = cityDic[@"Cities"];
    
    NSDictionary *cityInfoDic = citys[indexPath.row];
    NSString *city = cityInfoDic[@"city"];
    
        
    if ([self.delegate respondsToSelector:@selector(cityControllerSelectedWithCity:)]) {
        [self.delegate cityControllerSelectedWithCity:city];
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - 懒加载
-(NSArray *)provinces
{
    if (!_provinces) {
        NSString *path = [[NSBundle mainBundle]pathForResource:@"ProvincesAndCities.plist" ofType:nil];
        _provinces = [NSArray arrayWithContentsOfFile:path];
    }
    return _provinces;
}
@end
