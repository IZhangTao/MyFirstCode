//
//  ZTGetPhoneController.m
//  生活百事通
//
//  Created by 张涛 on 15/4/27.
//  Copyright (c) 2015年 张涛. All rights reserved.
//

#import "ZTGetPhoneController.h"
#import "RETableViewManager.h"
#import "RETableViewSection.h"
#import "MBProgressHUD+ZT.h"
#import "ZTHTTPTools.h"

@interface ZTGetPhoneController ()

@property (nonatomic ,strong) RETableViewManager *manager;
@property (nonatomic ,strong) RETableViewSection *seachSection;
@property (nonatomic ,strong) RETableViewSection *resultSection;

@property (nonatomic ,strong) RETableViewItem *btnItem;
@end

@implementation ZTGetPhoneController

- (instancetype)init
{
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self) {
        
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"手机归属地查询";
    RETableViewManager *manager = [[RETableViewManager alloc]initWithTableView:self.tableView];
    
    self.manager.style.cellHeight = 36;
    
    self.manager = manager;
    
    [self addSeachSection];
    [self addResultSection];
    [self addBtnItem];
    
}

- (void)addSeachSection
{
    UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"a1"]];
    imageView.bounds = CGRectMake(0, 0, self.view.frame.size.width, 100);
    imageView.contentMode = UIViewContentModeCenter;
    
    RETableViewSection *section = [RETableViewSection sectionWithHeaderView:imageView];
    
    section.footerTitle = @"手机号码归属地查询，可查询中国移动，中国联通，中国电信手机号段归属地信息.";
    
    [self.manager addSection:section];
    self.seachSection = section;
    
    RETextItem *item = [RETextItem itemWithTitle:@"手机号" value:nil placeholder:@"请输入要查询的手机号码"];
    
    [section addItem:item];
}
- (void)addResultSection
{
    RETableViewSection *section = [RETableViewSection sectionWithHeaderTitle:@"查询结果："];
    [self.manager addSection:section];
    self.resultSection = section;
}
- (void)addBtnItem
{
     __weak __typeof(self)weakSelf = self;
    RETableViewSection *section = [RETableViewSection section];
    
    RETableViewItem *item = [RETableViewItem itemWithTitle:@"查询" accessoryType:UITableViewCellAccessoryNone selectionHandler:^(RETableViewItem *item) {
        
        RETextItem *textItem = weakSelf.seachSection.items[0];
        if (textItem.value) {
            [weakSelf getPhoneInfo:textItem.value];
            
            [MBProgressHUD showMessage:@"查询中。。。"];
        }
        
        [item deselectRowAnimated:UITableViewRowAnimationAutomatic];
    }];
    
    item.textAlignment = NSTextAlignmentCenter;
    [section addItem:item];
    [self.manager addSection:section];
}

- (void)getPhoneInfo:(NSString *)Phone
{
    [ZTHTTPTools getInfoWithPhone:Phone success:^(id json) {
        NSDictionary *dic = json;
        
        // 清除所有items
        [self.resultSection removeAllItems];
        
        if ([dic[@"errNum"] integerValue] == 0) {
            
            NSDictionary *retData = dic[@"retData"];
            
            [self.resultSection addItem:[WBSubtitleItem itemWithTitle:@"手机号：" rightSubtitle:retData[@"phone"]]];
            
            [self.resultSection addItem:[WBSubtitleItem itemWithTitle:@"城市：" rightSubtitle:retData[@"city"]]];
            
            [self.resultSection addItem:[WBSubtitleItem itemWithTitle:@"手机号类型：" rightSubtitle:retData[@"supplier"]]];
            
        }else{
            [self.resultSection addItem:[WBSubtitleItem itemWithTitle:@"查询失败，手机号输入错误"]];
        }
        
        [self.resultSection reloadSectionWithAnimation:UITableViewRowAnimationAutomatic];
        
        [MBProgressHUD hideHUD];
    } faild:^(NSError *error) {
        [MBProgressHUD hideHUD];
    }];
}

-(void)dealloc
{
    NSLog(@"----->ZTGetPhoneController");
}
@end
