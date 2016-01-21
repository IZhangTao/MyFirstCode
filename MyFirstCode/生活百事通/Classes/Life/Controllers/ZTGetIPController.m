//
//  ZTGetIPController.m
//  生活百事通
//
//  Created by 张涛 on 15/4/27.
//  Copyright (c) 2015年 张涛. All rights reserved.
//

#import "ZTGetIPController.h"
#import "ZTHTTPTools.h"
#import "MBProgressHUD+ZT.h"
#import "RETableViewManager.h"
#import "ZTLocationCity.h"

@interface ZTGetIPController ()
@property (nonatomic, strong) RETableViewManager *manager;
@property (nonatomic, strong) RETextItem *IPItem;
@property (nonatomic, strong) RETableViewSection *resultSection;

@end

@implementation ZTGetIPController

- (instancetype)init
{
    if (self = [super initWithStyle:UITableViewStyleGrouped]) {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"IP地址查询";
    
    self.manager = [[RETableViewManager alloc]initWithTableView:self.tableView];
    self.manager.style.cellHeight = 36;
    
    // 添加第一个组 查询
    [self addSectionSearch];
    
    // 添加第二个组 结果
    [self addSectionResult];
    
    // 添加第三组 查询按钮
    [self addSectionButton];
}

// 添加第一个组 查询
- (void)addSectionSearch
{
    UIImage *image = [UIImage imageNamed:@"a5"];
    UIImageView *imageView = [[UIImageView alloc]initWithImage:image];
    imageView.bounds = CGRectMake(0, 0, self.view.frame.size.width, 100);
    imageView.contentMode = UIViewContentModeCenter;
    
    // 添加头部视图
    RETableViewSection *headerSection = [RETableViewSection sectionWithHeaderView:imageView];
    [self.manager addSection:headerSection];
    headerSection.footerTitle = @"可以查询指定IP的物理地址或域名服务器的IP和物理地址，及所在国家或城市，甚至精确到某个网吧，机房或学校等";
    
    RETextItem *IPItem = [RETextItem itemWithTitle:@"IP地址:" value:nil placeholder:@"请输入要查询的IP地址"];
//    IPItem.keyboardType = UIKeyboardTypeDecimalPad;
    [headerSection addItem:IPItem];
    self.IPItem = IPItem;
    
}

// 添加第二个组 结果
- (void)addSectionResult
{
    RETableViewSection *section = [RETableViewSection sectionWithHeaderTitle:@"查询结果:"];
    [self.manager addSection:section];
    self.resultSection = section;
}

- (void)addSectionButton
{
    RETableViewSection *section = [RETableViewSection section];
    [self.manager addSection:section];
    
    // 消除强引用
     __weak __typeof(self)weakSelf = self;
    RETableViewItem *buttonItem = [RETableViewItem itemWithTitle:@"查询" accessoryType:UITableViewCellAccessoryNone selectionHandler:^(RETableViewItem *item) {
        
        if (weakSelf.IPItem.value) {
            // 查询数据
            [weakSelf getIPDataWithIP:weakSelf.IPItem.value];
            [MBProgressHUD showMessage:@"查询中..."];
        }
        
        // item取消选择
        [item deselectRowAnimated:UITableViewRowAnimationAutomatic];
    }];
    buttonItem.textAlignment = NSTextAlignmentCenter;
    [section addItem:buttonItem];
    
}

- (void)getIPDataWithIP:(NSString *)IP
{
    [ZTHTTPTools getInfoWithIP:IP success:^(id json) {
        
        // 清除所有items
        [self.resultSection removeAllItems];
        
        if ([json[@"errNum"]integerValue] == 0) {
            // 返回成功
            
            NSDictionary *retData = json[@"retData"];
            
            // ip
            [self.resultSection addItem:[WBSubtitleItem itemWithTitle:@"IP地址:" rightSubtitle:retData[@"ip"]]];
            
            // 运营商
            [self.resultSection addItem:[WBSubtitleItem itemWithTitle:@"IP拥有商:" rightSubtitle:retData[@"carrier"]]];
            
            // city
            [self.resultSection addItem:[WBSubtitleItem itemWithTitle:@"地理位置:" rightSubtitle:retData[@"city"]]];
            
             //district
            [self.resultSection addItem:[WBSubtitleItem itemWithTitle:@"" rightSubtitle:retData[@"district"]]];
        
            
        } else {
            // 查询失败
            [self.resultSection addItem:@"查询失败，输入是否正确!"];
        }
        
        // 重新加载section
        [self.resultSection reloadSectionWithAnimation:UITableViewRowAnimationAutomatic];
        
        [MBProgressHUD hideHUD];
    } faild:^(NSError *error) {
        [MBProgressHUD hideHUD];
    } ];

}

/*返回数据
 {
	data = invaild ip.;
	code = 1;
 }

 {
	data = {
	country_id = CN;
	county_id = -1;
	isp = 电信;
	area = 华东;
	area_id = 300000;
	city_id = 320500;
	ip = 218.4.255.255;
	region_id = 320000;
	region = 江苏省;
	city = 苏州市;
	county = ;
	isp_id = 100017;
	country = 中国;
 }
 ;
	code = 0;
 }
*/

- (void)dealloc
{
    NSLog(@"IPSearchController dealloc");
}



@end
