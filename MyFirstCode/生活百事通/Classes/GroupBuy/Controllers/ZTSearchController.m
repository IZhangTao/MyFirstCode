//
//  ZTSearchController.m
//  生活百事通
//
//  Created by zhangtao on 15/12/17.
//  Copyright © 2015年 张涛. All rights reserved.
//

#import "ZTSearchController.h"
#import "ZTCity.h"
#import "ZTDataTool.h"
#import "PinYin4Objc.h"

@interface ZTSearchController()

@property (nonatomic, strong) NSMutableArray *resultCities;
@end

@implementation ZTSearchController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _resultCities = [NSMutableArray array];
}

- (void)setSearchText:(NSString *)searchText
{
    _searchText = searchText;
    
    // 清除之前搜索结果
    [self.resultCities removeAllObjects];
    
    // 筛选城市
    HanyuPinyinOutputFormat *fmt = [[HanyuPinyinOutputFormat alloc]init];
    fmt.caseType = CaseTypeUppercase;
    fmt.toneType = ToneTypeWithoutTone;
    fmt.vCharType = VCharTypeWithUUnicode;
    
    NSDictionary *cities = [ZTDataTool sharedZTDataTool].totalCities;
    
    [cities enumerateKeysAndObjectsUsingBlock:^(NSString *key, ZTCity *obj, BOOL *stop) {
        // 1.拼音
        NSString *pinyin = [PinyinHelper toHanyuPinyinStringWithNSString:obj.name withHanyuPinyinOutputFormat:fmt withNSString:@"#"];
        
        // 2.拼音首字母
        NSArray *words = [pinyin componentsSeparatedByString:@"#"];
        NSMutableString *pinyinHeader = [NSMutableString string];
        for (NSString *word in words) {
            [pinyinHeader appendString:[word substringToIndex:1]];
        }
        
        // 去掉所有的#
        pinyin = [pinyin stringByReplacingOccurrencesOfString:@"#" withString:@""];
        
        // 3.城市名中包含了搜索条件
        // 拼音中包含了搜索条件
        // 拼音首字母中包含了搜索条件
        if (([obj.name rangeOfString:searchText].length != 0) ||
            ([pinyin rangeOfString:searchText.uppercaseString].length != 0)||
            ([pinyinHeader rangeOfString:searchText.uppercaseString].length != 0))
        {
            // 说明城市名中包含了搜索条件
            [self.resultCities addObject:obj];
        }
        
    }];
    
    // 刷新表格
    [self.tableView reloadData];
}

#pragma mark - Table view 数据源

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return self.resultCities.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [NSString stringWithFormat:@"共%ld个搜索结果",self.resultCities.count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellID = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellID];
    }
    ZTCity *city = self.resultCities[indexPath.row];
    cell.textLabel.text = city.name;
    return cell;
    
}

#pragma mark tableview 代理方法

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZTCity *city = self.resultCities[indexPath.row];
    [ZTDataTool sharedZTDataTool].currentCity = city;
    [self.navigationController popViewControllerAnimated:YES];
}

@end

