//
//  ZTTGDealListController.m
//  生活百事通
//
//  Created by zhangtao on 15/11/23.
//  Copyright (c) 2015年 张涛. All rights reserved.
//h

#import "ZTTGDealListController.h"
#import "DOPDropDownMenu.h"

#import "ZTSubCategorie.h"
#import "ZTCItyDistrict.h"
#import "ZTOrder.h"

#import "ZTDataTool.h"
#import "ZTCategory.h"
#import "ZTCity.h"

#import "MJRefresh.h"
#import "ZTDealViewCell.h"
#import "ZTTGHttpTool.h"
#import "ZTDetailDealController.h"
#import "ZTDeal.h"

// 菜单高度
#define KMenuHeight 32
static NSString *reuseIdDealCell = @"ZTDealViewCell";

//枚举，菜单选项
typedef enum : NSUInteger {
    kCategorys,
    kDistrics,
    kOrders,
} kTGDtailMenu;

@interface ZTTGDealListController ()<DOPDropDownMenuDataSource,DOPDropDownMenuDelegate,UITableViewDataSource,UITableViewDelegate>


// 分类
@property (nonatomic, strong) NSArray *subcategories;
// 地区
@property (nonatomic, strong) NSArray *districs;
// 排序
@property (nonatomic, strong) NSArray *orders;

// 当前选中的类别
@property (nonatomic, strong) NSString *currentSubcategorie;
// 当前选中的区域
@property (nonatomic, strong) NSString *currentDistrict;
// 当前选中的排序
@property (nonatomic, strong) ZTOrder *currentOrder;

@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *deals;

//分页
@property (nonatomic, assign) int page;

@end

@implementation ZTTGDealListController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = ZTCollectionBkgCollor;
    
    _page = 1;
    
    // fram不包括导航栏
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    //topView 显示数据
    [self savaCurrentName];
    
    //添加topView
    [self addTopViewMenu];
    
    //添加tableview
    [self addTableView];
    
    UINib *nib = [UINib nibWithNibName:@"ZTDealViewCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:reuseIdDealCell];
    
    
    //添加刷新控件
    [self addRefreshView];
    
    //获取数据
    [self.tableView headerBeginRefreshing];
}

- (void)addTableView
{
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, KMenuHeight,kScreenWidth , kScreenHeight - 66)];
    tableView.dataSource = self;
    tableView.delegate = self;
    [self.view addSubview:tableView];
    self.tableView = tableView;
}


- (void)addRefreshView
{
    // 下拉刷新
    [self.tableView addHeaderWithTarget:self action:@selector(getNewTGDetailData)];
    
    // 上拉刷新
    [self.tableView addFooterWithTarget:self action:@selector(getMoreTGDetailData)];
    
}

- (void)getNewTGDetailData
{
    if (!self.currentDistrict || [self.currentDistrict isEqualToString:@"全城"]) {
        self.currentDistrict = nil;
    }
    
    if (!self.currentSubcategorie || [self.currentSubcategorie isEqualToString:@"全部"]) {
        self.currentSubcategorie = [ZTDataTool sharedZTDataTool].currentCategory.category_name;
    }
    
    NSInteger orderIndex = 1;
    if (self.currentOrder ) {
        orderIndex = self.currentOrder.index;
    }
    
    __typeof (self) __weak weakSelf = self;
    
    
    // 页面为1最新一页
    _page = 1;
    
   [[ZTTGHttpTool sharedZTTGHttpTool]dealsWithPage:self.page district:self.currentDistrict category:self.currentSubcategorie orderIndext:self.currentOrder.index success:^(NSArray *deals, int totalCount) {
       
//       ZTLog(@"--%@,%d--",deals,totalCount);
       
       // 添加数据
       weakSelf.deals = [NSMutableArray arrayWithArray:deals];
       
       // 重新加载
       [weakSelf.tableView reloadData];
       
       // 停止刷新
       [weakSelf.tableView headerEndRefreshing];

   } error:^(NSError *error) {
       
       // 停止刷新
       [weakSelf.tableView headerEndRefreshing];
       
   }];
    
}

- (void)getMoreTGDetailData
{
    if (!self.currentDistrict || [self.currentDistrict isEqualToString:@"全城"]) {
        self.currentDistrict = nil;
    }
    
    if (!self.currentSubcategorie || [self.currentSubcategorie isEqualToString:@"全部"]) {
        self.currentSubcategorie = [ZTDataTool sharedZTDataTool].currentCategory.category_name;
    }
    
    NSInteger orderIndex = 1;
    if (self.currentOrder ) {
        orderIndex = self.currentOrder.index;
    }
    
    __typeof (self) __weak weakSelf = self;
    
    //加载更多
    ++_page;
    
    // 发送请求
    [[ZTTGHttpTool sharedZTTGHttpTool] dealsWithPage:_page district:self.currentDistrict category:self.currentSubcategorie orderIndext:orderIndex success:^(NSArray *deals, int totalCount) {
        ZTLog(@"%@,%d",deals,totalCount);
        
        // 添加数据
        [weakSelf.deals addObjectsFromArray:deals];
        
        // 停止刷新
        [weakSelf.tableView reloadData];
        
        // 恢复刷新状态
        [weakSelf.tableView footerEndRefreshing];
    } error:^(NSError *error) {
        // 停止刷新
        [weakSelf.tableView headerEndRefreshing];
    }];

}

#pragma mark - tableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.deals.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZTDealViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdDealCell];
    if (!cell) {
        cell = [[ZTDealViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdDealCell];
    }
    
    ZTDeal *deal = self.deals[indexPath.row];
    cell.deal = deal;
    
    return  cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZTDeal *deal = self.deals[indexPath.row];
    
    ZTDetailDealController *detail = [[ZTDetailDealController alloc]init];
    detail.deal_id = deal.deal_id;
    [self.navigationController pushViewController:detail animated:NO];
}

#pragma mark - 显示数据
- (void)savaCurrentName
{
    // 保存选择的分类
    for (ZTCategory *category in [ZTDataTool sharedZTDataTool].totalCategories) {
        if ([category.category_name isEqualToString:self.title]) {
            [ZTDataTool sharedZTDataTool].currentCategory = category;
            break;
        }
    }
    
    // 保存需要数据
    NSMutableArray *tmp = nil;
    ZTSubCategorie *subCategorie = [[ZTSubCategorie alloc]init];
    subCategorie.category_name = @"全部";
    if ([ZTDataTool sharedZTDataTool].currentCategory.subcategories == nil) {
        tmp = [NSMutableArray array];
        [tmp addObject:subCategorie];
    } else {
        tmp = [NSMutableArray arrayWithArray:[ZTDataTool sharedZTDataTool].currentCategory.subcategories];
        [tmp insertObject:subCategorie atIndex:0];
    }
    self.subcategories = tmp;
    
    
    if ([[ZTDataTool sharedZTDataTool].currentCategory.category_name isEqualToString: @"结婚"]) {
        [tmp removeObjectAtIndex:0];
        ZTSubCategorie *subCategorie = tmp[0];
        self.currentSubcategorie = subCategorie.category_name;
    } else {
        self.currentSubcategorie = nil;
    }
    
    // 保存全部地区
    ZTCItyDistrict *distrc = [[ZTCItyDistrict alloc]init];
    distrc.name = @"全城";
    if ([ZTDataTool sharedZTDataTool].currentCity.districts == nil) {
        tmp = [NSMutableArray array];
        [tmp addObject:distrc];
    } else {
        tmp = [NSMutableArray arrayWithArray:[ZTDataTool sharedZTDataTool].currentCity.districts];
        [tmp insertObject:distrc atIndex:0];
    }
    self.districs = tmp;
    
    // 保存排序
    self.orders = [ZTDataTool sharedZTDataTool].totalOrders;
}

- (void)addTopViewMenu
{
    DOPDropDownMenu *menu = [[DOPDropDownMenu alloc]initWithOrigin:CGPointMake(0, 0) andHeight:KMenuHeight];
    menu.delegate = self;
    menu.dataSource = self;
    menu.backgroundColor = [UIColor yellowColor];
    
    [self.view addSubview:menu];
}

#pragma mark DOPDropDownMenuDataSource

- (NSInteger)numberOfColumnsInMenu:(DOPDropDownMenu *)menu
{
    return 3;
}

- (NSInteger)menu:(DOPDropDownMenu *)menu numberOfRowsInColumn:(NSInteger)column
{
    switch (column) {
        case kCategorys:
            return self.subcategories.count;
            break;
        case kDistrics:
            return  self.districs.count;
            break;
        case kOrders:
            return  self.orders.count;
            break;
        default:
            return 0;
            break;
    }
}


- (NSString *)menu:(DOPDropDownMenu *)menu titleForRowAtIndexPath:(DOPIndexPath *)indexPath
{
    if (indexPath.column == kCategorys) {
        ZTSubCategorie *sb = self.subcategories[indexPath.row];
        return sb.category_name;
    }else if (indexPath.column == kDistrics){
        ZTCItyDistrict *district = self.districs[indexPath.row];
        return district.name;
    }else if (indexPath.column == kOrders){
        ZTOrder *order = self.orders[indexPath.row];
        return order.name;
    }else{
        return nil;
    }
}

//美团
- (NSInteger)menu:(DOPDropDownMenu *)menu numberOfItemsInRow:(NSInteger)row column:(NSInteger)column
{
    if (column == 0) {
        if (row == 0) {
            
        }

    }
    return 0;
}

- (NSString *)menu:(DOPDropDownMenu *)menu titleForItemsInRowAtIndexPath:(DOPIndexPath *)indexPath
{
  
    return nil;
}


#pragma mark DOPDropDownMenuDelegate
- (void)menu:(DOPDropDownMenu *)menu didSelectRowAtIndexPath:(DOPIndexPath *)indexPath
{
    if (indexPath.column == kCategorys) {
         // 记录当前分类
        ZTSubCategorie *sb = self.subcategories[indexPath.row];
        self.currentSubcategorie = sb.category_name;
    }else if (indexPath.column == kDistrics){
        // 记录当前分区
        ZTCItyDistrict *dis = self.districs[indexPath.row];
        self.currentDistrict = dis.name;
    }else if (indexPath.column == kOrders){
        // 记录当前排序
        self.currentOrder = self.orders[indexPath.row];
    }else{
        
    }
    
    __typeof (self) __weak weakSelf = self;
    [weakSelf.tableView headerBeginRefreshing];
}



- (NSMutableArray *)deals
{
    if (!_deals) {
        _deals = [NSMutableArray array];
    }
    return _deals;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
