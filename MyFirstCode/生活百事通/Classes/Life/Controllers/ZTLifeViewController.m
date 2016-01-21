//
//  ZTLifeViewController.m
//  生活百事通
//
//  Created by 张涛 on 15/4/23.
//  Copyright (c) 2015年 张涛. All rights reserved.
//
#import "UIBarButtonItem+Extension.h"
#import "ZTLocationCity.h"
#import "MJExtension.h"

#import "ZTLifeViewController.h"
#import "ZTHTTPTools.h"
#import "AFHTTPRequestOperationManager.h"

#import "ZTWeatherCell.h"
#import "ZTHeaderCell.h"
#import "ZTProductCell.h"

#import "ZTSection.h"
#import "ZTItem.h"
#import "CSStickyHeaderFlowLayout.h"

#import "ZTCityController.h"
#import "ZTWeatherInfo.h"
#import "ZTLocationCity.h"
#import "ZTWeatherViewController.h"
#import "WeatherViewController.h"

#import "ZTGetDreamController.h"
#import "ZTGetIDCadeController.h"
#import "ZTGetIPController.h"
#import "ZTGetMoneyController.h"
#import "ZTGetPhoneController.h"

#import "FangDaiViewController.h"
#import "ZTShuiShouController.h"
#import "ZTLotteyController.h"
@interface ZTLifeViewController ()<ZTCityControllerDelegate>
@property (nonatomic ,strong) NSMutableArray *sections;
@property (nonatomic ,weak) ZTWeatherCell *weatherCell;


@end

@implementation ZTLifeViewController


static NSString * const weatherIdentifier = @"ZTWeatherCell";
static NSString * const headerIdentifier = @"ZTHeaderCell";
static NSString * const productIdentifier = @"ZTProductCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    __typeof (&*self) __weak weakSelf = self;
//    设置layout
    [self reloadLayout];
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImage:@"ios7_top_navigation_infoicon" target:self action:@selector(chooseCity)];
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithNorImage:nil higImage:nil title:@"刷新" target:self action:@selector(flashWeather)];
    
//    注册cell
    [self registerCell];
    self.collectionView.backgroundColor = ZTCollectionBkgCollor;

//    添加分组
    [self addFirstSection];
    [self addSecondSection];
    [self addThirdSection];
    
//    定位城市
    [ZTLocationCity sharedZTLocationCity];

    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(locationCity) name:ZTCurrentCityMessage object:nil];
    
     [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(NOLocationCity) name:ZTNOCityMessage object:nil];

  
}

- (void)NOLocationCity
{
    [self layoutWeatherInfo:@"北京"];
}

#pragma mark - 设置视图
/**
 *  设置布局
 */
- (void)reloadLayout
{
    CSStickyHeaderFlowLayout *layout = (id)self.collectionViewLayout;
    
    if ([layout isKindOfClass:[CSStickyHeaderFlowLayout class]]) {
        
        //展示的最小size，再小向上滚动,设置weathercell的自动布局效果
        layout.parallaxHeaderMinimumReferenceSize = CGSizeMake(self.view.frame.size.width, 200);
        //展示的size
        layout.parallaxHeaderReferenceSize = CGSizeMake(self.view.frame.size.width, 400);
        
        //设置headerView的尺寸
        layout.headerReferenceSize = CGSizeMake(self.view.frame.size.width, 50);
        //设置水平间距
        layout.minimumInteritemSpacing = 0;
        
        //cell之间的间距
        layout.minimumLineSpacing = 10;
        
        layout.headerReferenceSize = CGSizeMake(200, 50);
        
        
        //设置headerView与cell的间距
        layout.sectionInset = UIEdgeInsetsMake(10, 0, 0, 0);
        layout.itemSize = CGSizeMake(80, 80);
    }
}
/**
 *  注册cell
 */
- (void)registerCell
{
   
    UINib *nib = [UINib nibWithNibName:productIdentifier bundle:nil];
    [self.collectionView registerNib:nib forCellWithReuseIdentifier:productIdentifier];
     
    nib = [UINib nibWithNibName:headerIdentifier  bundle:nil];
    [self.collectionView registerNib:nib forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerIdentifier];
    
    nib = [UINib nibWithNibName:weatherIdentifier bundle:nil];
    [self.collectionView registerNib:nib forSupplementaryViewOfKind:CSStickyHeaderParallaxHeader withReuseIdentifier:weatherIdentifier];
}

/**
 *  向数组中添加数据
 */
- (void)addFirstSection
{
    ZTSection *section = [[ZTSection alloc]init];
    section.headerTitle = @"生活查询";
    
    ZTItem *itemID = [ZTItem itemWithImage:@"s3" title:@"身份证查询" destVcClass:[ZTGetIDCadeController class]];
    
    ZTItem *itemSJ =
    [ZTItem itemWithImage:@"a1" title:@"手机归属地" destVcClass:[ZTGetPhoneController class]];
    
    ZTItem *itemHL = [ZTItem itemWithImage:@"a7" title:@"货币汇率" destVcClass:[ZTGetMoneyController class]];
    
    ZTItem *itemJM = [ZTItem itemWithImage:@"a6" title:@"周公解梦" destVcClass:[ZTGetDreamController class]];
    
    ZTItem *itemIP = [ZTItem itemWithImage:@"a5" title:@"IP地址查询" destVcClass:[ZTGetIPController class]];
    
    [section.items addObjectsFromArray:@[itemHL,itemID,itemIP,itemJM,itemSJ]];
    [self.sections addObject:section];
    
}

- (void)addSecondSection
{
    ZTSection *section = [[ZTSection alloc]init];
    section.headerTitle = @"贷款计算";
    
    ZTItem *itemFD = [ZTItem itemWithImage:@"a8" title:@"房贷计算" destVcClass:[FangDaiViewController class ]];
    
    ZTItem *itemSS = [ZTItem itemWithImage:@"s7" title:@"税收计算"destVcClass:[ZTShuiShouController class ]];
    
    [section.items addObjectsFromArray:@[itemFD,itemSS]];
    [self.sections addObject:section];
    
}

- (void)addThirdSection
{
    ZTSection *section = [[ZTSection alloc]init];
    section.headerTitle = @"彩票开奖";
    
    ZTItem *itemCP = [ZTItem itemWithImage:@"a2" title:@"网易彩票" destVcClass:[ZTLotteyController class ]];
    
    [section.items addObjectsFromArray:@[itemCP]];
    [self.sections addObject:section];
    

}


/**
 *  <UICollectionViewDataSource>
 */
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return self.sections.count;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    ZTSection *product = self.sections[section];
    return product.items.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    // 获得cell
    ZTProductCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:productIdentifier forIndexPath:indexPath];
    
    // 传递模型
    ZTSection *productSection = self.sections[indexPath.section];
    cell.item = productSection.items[indexPath.item];
    
    return cell;

}

/**
 *  根据布局设置视图
 */
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        ZTSection *section = self.sections[indexPath.section];
        
        ZTHeaderCell *cell = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:headerIdentifier forIndexPath:indexPath];
        
        cell.headerLable.text = section.headerTitle;
        
        return cell;
    } else if ([kind isEqualToString:CSStickyHeaderParallaxHeader]) {
        ZTWeatherCell *cell = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:weatherIdentifier forIndexPath:indexPath];
        
          [cell addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickWeatherView)]];
        
        self.weatherCell =cell;
        if (self.weatherInfo == nil) {
        }else{
        cell.weatherInfo = self.weatherInfo;
        }
        return cell;
    }
    return nil;
}

#pragma mark - 设置加载数据

//收到定位城市通知
- (void)locationCity
{
    ZTLocationTool *location = [ZTLocationCity sharedZTLocationCity].locationCity;

    if (location&&location.city) {
        [self layoutWeatherInfo:[ZTLocationCity sharedZTLocationCity].locationCity.city];
    }
}

- (void)chooseCity
{
    ZTCityController *city = [[ZTCityController alloc]init];
    [self.navigationController pushViewController:city animated:YES];
    city.delegate = self;
}


// 刷新数据
- (void)layoutWeatherInfo:(NSString *)city
{
     __weak __typeof(self)weakSelf = self;
    [ZTHTTPTools getWeatherInfoWithCity:city success:^(id json) {
        NSArray *weather = [ZTWeatherInfo objectArrayWithKeyValuesArray:json[@"results"]];
      
        _weatherInfo = weather[0];
        
        NSDateFormatter *fm = [[NSDateFormatter alloc]init];
        fm.dateFormat = @"yyyy年MM月dd日";
        
        NSString *currentDate = [fm stringFromDate:[NSDate date]];
        
        _weatherInfo.date = currentDate;
        
        weakSelf.weatherCell.weatherInfo = _weatherInfo;
    } faild:^(NSError *error) {
        NSLog(@"网络加载失败");
    }];

    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:city forKey:@"currentCity"];
}

//选择城市刷新
- (void)cityControllerSelectedWithCity:(NSString *)city
{
    [self layoutWeatherInfo:city];
}

#pragma mark - 点击按钮跳转页面

- (void)flashWeather
{
    ZTLocationCity *locationCity = [ZTLocationCity sharedZTLocationCity];
    [self layoutWeatherInfo:locationCity.locationCity.city];
    
}
- (void)clickWeatherView
{
     __weak __typeof(self)weakSelf = self;
    ZTWeatherViewController *weather = [[ZTWeatherViewController alloc]init];
//    WeatherViewController *weather = [[WeatherViewController alloc]init];
    weather.weatherInfo = weakSelf.weatherInfo;
   
    [self.navigationController pushViewController:weather animated:NO];
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    ZTSection *section = self.sections[indexPath.section];
    ZTItem *item = section.items[indexPath.row];
    
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




#pragma mark - 懒加载
-(NSMutableArray *)sections
{
    if (!_sections) {
        _sections = [NSMutableArray array];
    }
    return _sections;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    NSLog(@"ZTLifeViewController----dealloc");
}
@end
