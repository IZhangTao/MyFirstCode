//
//  ZTGroupBuyController.m
//  生活百事通
//
//  Created by 张涛 on 15/4/19.
//  Copyright (c) 2015年 张涛. All rights reserved.
//

#import "ZTGroupBuyController.h"
#import "CSStickyHeaderFlowLayout.h"

#import "ZTSection.h"
#import "ZTProductCell.h"

#import "ZTLocationCity.h"
#import "UIBarButtonItem+Extension.h"
#import "ZTCitysController.h"


#import "ZTCategory.h"
#import "ZTDataTool.h"
#import "ZTItem.h"
#import "ZTTGDealListController.h"
#import "ZTProductCell.h"
#import "ZTSection.h"
#import "ZTHeaderCell.h"

#import "ZTCity.h"
#import "ZTMapController.h"

@interface ZTGroupBuyController ()

@property (nonatomic ,strong) NSMutableArray *sections;

@end

@implementation ZTGroupBuyController

static NSString * const headerIdentifier = @"ZTHeaderCell";
static NSString * const productIdentifier = @"ZTProductCell";
//设置布局
- (instancetype)init
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.itemSize = CGSizeMake(80, 80);
    //水平间距
    layout.minimumInteritemSpacing = 0;
    //垂直间距
    layout.minimumLineSpacing = 10;
    
    layout.sectionInset = UIEdgeInsetsMake(10, 0, 0, 0);
    layout.headerReferenceSize = CGSizeMake(0 , 60);
    
    self = [super initWithCollectionViewLayout:layout];
    if (self) {
        
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImage:@"ios7_top_navigation_locationicon" higImage:nil imageScale:1.0 target:self action:@selector(openMapView)];

//    获取当前城市
    NSString *city = [ZTLocationCity sharedZTLocationCity].locationCity.city;
    
    if (!city) {
        city = @"北京";
    }
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:city style:UIBarButtonItemStylePlain target:self action:@selector(chooseCity)];
//    [UIBarButtonItem itemWithNorImage:nil higImage:nil title:city target:self action:@selector(chooseCity)];
 
    // 监听选择城市改变的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(cityChange) name:kCityChangeNote object:nil];
    // 监听定位城市改变的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(locationCity) name:LocationCityNote object:nil];
    
    [self locationCity];
    
    self.collectionView.backgroundColor = ZTCollectionBkgCollor;
    
    //注册cell
    [self registerCell];
    
    //添加组
    [self addSectionBuy];
    
    [self addSectionEntertainment];
}

//注册cell
- (void)registerCell
{
    UINib *nib = [UINib nibWithNibName:productIdentifier bundle:nil];
    [self.collectionView registerNib:nib forCellWithReuseIdentifier:productIdentifier];
    
    nib = [UINib nibWithNibName:headerIdentifier bundle:nil];
    [self.collectionView registerNib:nib forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerIdentifier];
}

// 添加组
- (void)addSectionBuy
{
    ZTSection *section = [[ZTSection alloc]init];
    section.headerTitle = @"购物";
    
    for (int i = 0; i <5; i++) {
        ZTCategory *category = [ZTDataTool sharedZTDataTool].totalCategories[i];
        [section.items addObject:[ZTItem itemWithImage:category.icon title:category.category_name destVcClass:[ZTTGDealListController class]]];
        
    }
    [self.sections addObject:section];
}

- (void)addSectionEntertainment
{
    ZTSection *section = [[ZTSection alloc]init];
    section.headerTitle = @"娱乐";
    
    for (int i = 5; i < [ZTDataTool sharedZTDataTool].totalCategories.count; i++) {
        ZTCategory *category = [ZTDataTool sharedZTDataTool].totalCategories[i];
        [section.items addObject:[ZTItem itemWithImage:category.icon title:category.category_name destVcClass:[ZTTGDealListController class]]];
    }
    [self.sections addObject:section];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return self.sections.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    ZTSection *itemSection = self.sections[section];
    return itemSection.items.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ZTProductCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:productIdentifier forIndexPath:indexPath];
    
    ZTSection *sectionP = self.sections[indexPath.section];
    cell.item = sectionP.items[indexPath.item];
    
    return cell;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    ZTSection *section = self.sections[indexPath.section];
    ZTItem *item = section.items[indexPath.item];
    
    // 运行block
    if (item.selectionHandler) {
        item.selectionHandler();
    }
    
    if (item.destVcClass) {
        UIViewController *vc = [[item.destVcClass alloc]init];
        vc.title = item.title;
        [self.navigationController pushViewController:vc animated:NO];
    }

    
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        ZTSection *section = self.sections[indexPath.section];
        
        ZTHeaderCell *cell = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:headerIdentifier forIndexPath:indexPath];
        cell.headerLable.text = section.headerTitle;
        
        return cell;
    }
    return nil;
}


//地图定位
- (void)openMapView
{
    ZTMapController *map = [[ZTMapController alloc]init];
    [self.navigationController pushViewController:map animated:YES];
}

//选择城市
- (void)chooseCity
{
    ZTCitysController *citys = [[ZTCitysController alloc]init];
    
//    NSString *cityName = [ZTLocationCity sharedZTLocationCity].locationCity.city;
//    citys.title = [NSString stringWithFormat:@"当前城市:%@",cityName];
    
    citys.title = [NSString stringWithFormat:@"当前城市:%@",self.navigationItem.leftBarButtonItem.title];
    
    [self.navigationController pushViewController:citys animated:YES];
}

#pragma mark 城市改变
- (void)cityChange
{
    self.navigationItem.leftBarButtonItem.title = [ZTDataTool sharedZTDataTool].currentCity.name;
}

- (void)locationCity
{
    NSString *cityName = [ZTLocationCity sharedZTLocationCity].locationCity.city;
    if (cityName) {
        // 更新城市
        NSLog(@"%@",[ZTDataTool sharedZTDataTool].totalCities);
        NSString *keyName = [cityName substringToIndex:2];
        
        ZTCity *city = [ZTDataTool sharedZTDataTool].totalCities[keyName];
        [ZTDataTool sharedZTDataTool].currentCity = city;
    }
}

//懒加载
-(NSMutableArray *)sections
{
    if (_sections == nil) {
        _sections = [NSMutableArray array];
    }
    return _sections;
}


@end
