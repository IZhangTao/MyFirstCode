//
//  ZTCitysController.m
//  生活百事通
//
//  Created by zhangtao on 15/12/14.
//  Copyright © 2015年 张涛. All rights reserved.
//

#import "ZTCitysController.h"
#import "UIBarButtonItem+Extension.h"
#import "ZTDataTool.h"

#import "ZTCitySection.h"
#import "ZTCity.h"
#import "ZTSearchController.h"
#import "ZTCoverView.h"

@interface ZTCitysController ()<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate,NSCoding>
@property (nonatomic, weak) UISearchBar *searchBar;
@property (nonatomic, weak) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *citySections;
@property (nonatomic, strong) ZTSearchController *searchResult;
@property (nonatomic, strong) ZTCoverView *coverView;
@end


#define kSearchH 36
@implementation ZTCitysController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    [self addSearchBar];
    
    [self addTableView];
    
    [self loadCitiesData];
}

- (void)addSearchBar
{
    UISearchBar *search = [[UISearchBar alloc]init];
    search.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    search.frame = CGRectMake(0, 0, self.view.frame.size.width, kSearchH);
    search.delegate = self;
    search.placeholder = @"请输入城市名或拼音";
    [self.view addSubview:search];
    self.searchBar = search;
}

- (void)addTableView
{
    UITableView *tableView = [[UITableView alloc]init];
    CGFloat h = self.view.frame.size.height - kSearchH;
    tableView.frame = CGRectMake(0, kSearchH, self.view.frame.size.width, h);
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:tableView];
    _tableView = tableView;
}

#pragma mark - loadCitiesData
- (void)loadCitiesData
{
    self.citySections = [NSMutableArray array];
    [self.citySections addObjectsFromArray:[ZTDataTool sharedZTDataTool].totalCitySections];
}

#pragma mark - tableView 
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return  self.citySections.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    ZTCitySection *citySection = self.citySections[section];
    return citySection.cities.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellID = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellID];
    }
    
    ZTCitySection *citySection = self.citySections[indexPath.section];
    ZTCity *city = citySection.cities[indexPath.row];
    cell.textLabel.text = city.name;
    
    return cell;

}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    ZTCitySection *sectionCity = self.citySections[section];
    return sectionCity.name;
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return [self.citySections valueForKeyPath:@"name"];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZTCitySection *section = self.citySections[indexPath.section];
    ZTCity *city = section.cities[indexPath.row];
    
    //存的是string数组
    NSMutableArray *citys = [NSKeyedUnarchiver unarchiveObjectWithFile:kFilePath];
    
    NSString *cityName = city.name;
    [citys addObject:cityName];
    [NSKeyedArchiver archiveRootObject:citys toFile:kFilePath];
    
    [ZTDataTool sharedZTDataTool].currentCity = city;
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - searchView

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    // 显示取消按钮
    [searchBar setShowsCancelButton:YES animated:YES];
    
    if (self.coverView == nil) {
        self.coverView = [ZTCoverView coverWithTarget:self action:@selector(coverClicked)];
    }
    
    self.coverView.frame = self.tableView.frame;
    self.coverView.alpha = 0.0;
    [self.view addSubview:self.coverView];
    [UIView animateWithDuration:0.3 animations:^{
        [self.coverView reset];
    }];
}


- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    if (searchText.length == 0) {
        // 隐藏搜索界面
        [_searchResult.view removeFromSuperview];
    } else {
        // 显示搜索界面
        if (_searchResult == nil) {
            _searchResult = [[ZTSearchController alloc] init];
            _searchResult.view.frame = self.coverView.frame;
            _searchResult.view.autoresizingMask = self.coverView.autoresizingMask;
            [self addChildViewController:_searchResult];
        }
        _searchResult.searchText = searchText;
        [self.view addSubview:_searchResult.view];
    }
}


- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [self coverClicked];
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    [self coverClicked];
}


- (void)coverClicked
{
    // 移除遮罩
    [UIView animateWithDuration:0.3 animations:^{
        self.coverView.alpha = 0.0;
    } completion:^(BOOL finished) {
        [self.coverView removeFromSuperview];
    }];
    
    // 取消按钮消失
    [self.searchBar setShowsCancelButton:NO animated:YES];
    
    // 键盘消失
    [self.searchBar resignFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
