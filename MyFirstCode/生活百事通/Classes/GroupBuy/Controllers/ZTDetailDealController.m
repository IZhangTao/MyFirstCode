//
//  ZTDetailDealController.m
//  生活百事通
//
//  Created by zhangtao on 15/11/27.
//  Copyright (c) 2015年 张涛. All rights reserved.
//

#import "ZTDetailDealController.h"
#import "UIBarButtonItem+Extension.h"
#import "MBProgressHUD+ZT.h"
#import "ZTDetailWebController.h"

#import "RETableViewManager.h"
#import "ZTImageItem.h"
#import "ZTBuyDock.h"
#import "ZTRestrictItem.h"



#import "ZTRestriction.h"
#import "ZTDeal.h"
#import "ZTTGHttpTool.h"
#import "MultilineTextItem.h"

// 标题字体大小
#define kTitleFontSize 15
#define kFooterHeight 0.5
#define kHearderHeight 8

@interface ZTDetailDealController ()<RETableViewManagerDelegate>

@property (nonatomic, strong) RETableViewManager *manager;
@property (nonatomic, weak) ZTBuyDock *buydock;
@property (nonatomic, strong) ZTDeal *deal;
@end

@implementation ZTDetailDealController

- (instancetype)init
{
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"团购详情";
    
    UIBarButtonItem *rightShare = [UIBarButtonItem itemWithImage:@"icon_merchant_share_normal" higImage:@"icon_merchant_share_highlighted" imageScale:0.5 target:self action:@selector(share)];
    UIBarButtonItem *rightcollect = [UIBarButtonItem itemWithImage:@"icon_collect" higImage:@"icon_collect_highlighted" imageScale:0.5 target:self action:@selector(collect)];
    
    self.navigationItem.rightBarButtonItems = @[rightcollect,rightShare];
    
    self.manager = [[RETableViewManager alloc]initWithTableView:self.tableView];
    self.manager.delegate = self;
    //注册自定义cell
    self.manager[@"ZTImageItem"] = @"ZTImageCell";
    self.manager[@"ZTRestrictItem"] = @"ZTTGRestrictCell";
    
    self.manager.style.defaultCellSelectionStyle = UITableViewCellSelectionStyleNone;
    
    // 设置tableView边框
    self.tableView.separatorInset = UIEdgeInsetsMake(0, 10, 0, 0);
    self.tableView.contentInset = UIEdgeInsetsMake(0,0,self.buydock.frame.size.height+8,0);
    
    // 添加加载中
    [MBProgressHUD showMessage:@"加载中..." toView:self.tableView];
    
    // 获取详细数据
    [self getDetailData];
    
}

- (void)addBuyDockView
{
    if (self.buydock) {
        [self.buydock removeFromSuperview];
    }
    
    __typeof(self) __weak weakSelf = self;
    
    self.buydock = [ZTBuyDock buyDockWithNowPrice:self.deal.current_price_text originalPrice:self.deal.list_price_text clickedHander:^{
        
        ZTDetailWebController *web = [ZTDetailWebController alloc];
        web.deal = self.deal;
        [self.navigationController pushViewController:web animated:YES];
    }];
    

    // 设置frame
    CGFloat toolbarY = self.view.frame.size.height - self.buydock.frame.size.height;
    
    self.buydock.frame = CGRectMake(self.buydock.frame.origin.x, toolbarY +self.tableView.contentOffset.y , self.view.frame.size.width, self.buydock.frame.size.height);
    [self.view addSubview:self.buydock];
    
}


- (void)share
{
    
}

- (void)collect
{
    
}


- (void)getDetailData
{
    __typeof(self) __weak weakSelf = self;
    [[ZTTGHttpTool sharedZTTGHttpTool]dealWithID:self.deal_id success:^(ZTDeal *deal) {
        weakSelf.deal = deal;
        [weakSelf.manager removeAllSections];
        [weakSelf addSections];
        [weakSelf addBuyDockView];
        [weakSelf.view addSubview:self.buydock];
        
        [weakSelf.tableView reloadData];
        [MBProgressHUD hideHUDForView:weakSelf.view];
        
    } error:^(NSError *error) {
        NSLog(@"加载失败");
    }];
}

- (void)addSections
{
    // 添加第一组 商品图片
    [self addImageSection];
    
    // 添加第二组 购买信息
    [self addBuySection];
    
    // 添加第三组 团购详情
    [self addDetailSection];
    
    // 添加第四组 购买须知
    [self addRemindSection];
    
    // 添加第四组 重要通知
    [self addNoticeSection];
}

#pragma mark 第一组 图片展示
- (void)addImageSection
{
    // 创建组
    RETableViewSection *section = [RETableViewSection section];
    section.headerHeight = 0.5;
    section.footerHeight = kFooterHeight;
    
    // 添加item
    [section addItem:[ZTImageItem itemWithImageUrl:self.deal.s_image_url isReservation:self.deal.restrictions.is_reservation_required]];
    
    [self.manager addSection:section];
}

#pragma mark 第二组 购买信息
- (void)addBuySection
{
    // 创建组
    RETableViewSection *section = [RETableViewSection section];
    //section.headerView = self.buyDock;
    
    // 添加标题item
    RETableViewItem *itemTitle = [RETableViewItem itemWithTitle:self.deal.title fontSzie:kTitleFontSize+2];
  
    section.headerHeight = 0.5;
    section.footerHeight = kFooterHeight;
    itemTitle.cellHeight = 38;
    [section addItem:itemTitle];
    
    // 添加详情item
    MultilineTextItem *itemDes = [MultilineTextItem itemWithTitle:self.deal.desc fontSzie:12];
    itemDes.titleColor = [UIColor darkGrayColor];
    [section addItem:itemDes];
    
    // 添加购买条件信息
    ZTRestrictItem *restrictItem = [ZTRestrictItem item];
    restrictItem.deal = self.deal;
    [section addItem:restrictItem];
    
    [self.manager addSection:section];
}

#pragma mark 第三组 团购详情
- (void)addDetailSection
{
    // 创建组
    RETableViewSection *section = [RETableViewSection section];
    section.headerHeight = kHearderHeight;
    section.footerHeight = kFooterHeight;
    
    // 标题
    RETableViewItem *titleItem = [RETableViewItem itemWithTitle:@"团购详情" fontSzie:kTitleFontSize];
    titleItem.image = [UIImage imageNamed:@"icon_deal_package"];
    titleItem.imageScale = 0.4;
    titleItem.cellHeight = 32;
    
    //内容
    MultilineTextItem *contentItem = [MultilineTextItem itemWithTitle:self.deal.details fontSzie:13];
    
    // 查看图文详细情况
    __typeof (self) __weak weakSelf = self;
    RETableViewItem *detailItem = [RETableViewItem itemWithTitle:@"查看图文详情" accessoryType:UITableViewCellAccessoryDisclosureIndicator selectionHandler:^(RETableViewItem *item) {
        NSLog(@"查看图文详情");
        ZTDetailWebController *webInfo = [[ZTDetailWebController alloc]init];
        webInfo.deal = weakSelf.deal;
        [weakSelf.navigationController pushViewController:webInfo animated:YES];
    }];
    detailItem.cellHeight = 30;
    detailItem.titleFontSize = 13;
    detailItem.titleColor = ZTColor(63, 176, 141);
    
    [section addItemsFromArray:@[titleItem,contentItem,detailItem]];
    
    [self.manager addSection:section];
}

#pragma mark 第四组 购买须知
- (void)addRemindSection
{
    // 创建组
    RETableViewSection *section = [RETableViewSection section];
    section.headerHeight = kHearderHeight;
    section.footerHeight = kFooterHeight;
    
    // 标题
    RETableViewItem *titleItem = [RETableViewItem itemWithTitle:@"购买须知" fontSzie:kTitleFontSize];
    titleItem.image = [UIImage imageNamed:@"icon_deal_notice"];
    titleItem.imageScale = 0.4;
    titleItem.cellHeight = 32;
    
    //内容
    MultilineTextItem *contentItem = [MultilineTextItem itemWithTitle:self.deal.restrictions.special_tips fontSzie:13];
    
    [section addItemsFromArray:@[titleItem,contentItem]];
    
    [self.manager addSection:section];

}

#pragma mark 第五组 重要通知
- (void)addNoticeSection
{
    // 创建组
    RETableViewSection *section = [RETableViewSection section];
    section.headerHeight = kHearderHeight;
    section.footerHeight = kFooterHeight;
    
    // 标题
    RETableViewItem *titleItem = [RETableViewItem itemWithTitle:@"重要通知" fontSzie:kTitleFontSize];
    titleItem.image = [UIImage imageNamed:@"icon_deal_recommed"];
    titleItem.imageScale = 0.4;
    titleItem.cellHeight = 32;
    
    //内容
    NSString *content = (self.deal.notice == nil || [self.deal.notice isEqualToString:@""]) ? @"无" : self.deal.notice;
    MultilineTextItem *contentItem = [MultilineTextItem itemWithTitle:content fontSzie:13];
    
    [section addItemsFromArray:@[titleItem,contentItem]];
    
    [self.manager addSection:section];

}

#pragma mark scrollViewDelegate
// 滚动保持dock在最下面
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // 设置toolbar不随tableview移动
    CGFloat toolbarY = self.view.frame.size.height - self.buydock.frame.size.height;
    
    self.buydock.frame = CGRectMake(self.buydock.frame.origin.x, toolbarY +self.tableView.contentOffset.y , self.view.frame.size.width, self.buydock.frame.size.height);
    //[self.view bringSubviewToFront:self.toolBar];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
