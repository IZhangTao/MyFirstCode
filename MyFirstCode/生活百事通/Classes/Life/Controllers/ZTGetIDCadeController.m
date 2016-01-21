//
//  ZTGetIDCadeController.m
//  生活百事通
//
//  Created by 张涛 on 15/4/27.
//  Copyright (c) 2015年 张涛. All rights reserved.
//

#import "ZTGetIDCadeController.h"
#import "RETableViewManager.h"
#import "MBProgressHUD+ZT.h"
#import "ZTHTTPTools.h"

@interface ZTGetIDCadeController ()<RETableViewManagerDelegate>

@property (nonatomic ,strong) RETableViewManager *manager;
@property (nonatomic ,strong) RETableViewSection *searchSection;
@property (nonatomic ,strong) RETableViewSection *resultSection;

@end

@implementation ZTGetIDCadeController
- (instancetype)init
{
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self) {
        
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"国内身份证查询验证";
    
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
    UIImage *image = [UIImage imageNamed:@"s3"];
    UIImageView *imageView = [[UIImageView alloc]initWithImage:image];
    imageView.bounds = CGRectMake(0, 0, self.view.frame.size.width, 100);
    imageView.contentMode = UIViewContentModeCenter;
    
    // 添加头部视图
    RETableViewSection *IDCardsection = [RETableViewSection sectionWithHeaderView:imageView];
    IDCardsection.footerTitle = @"身份证验证查询系统,请勿用于非法途径!";
    
    [self.manager addSection:IDCardsection];
    self.searchSection = IDCardsection;
    
    RETextItem *IDCardItem = [RETextItem itemWithTitle:@"身份证号码:" value:nil placeholder:@"请输入身份证号码"];
    [IDCardsection addItem:IDCardItem];
}

// 添加第二个组 结果
- (void)addSectionResult
{
    RETableViewSection *section = [RETableViewSection sectionWithHeaderTitle:@"查询结果:"];
    [self.manager addSection:section];
    self.resultSection = section;
}

// 添加第三组 查询按钮
- (void)addSectionButton
{
    RETableViewSection *section = [RETableViewSection section];
    [self.manager addSection:section];
    
    // 消除强引用
    __typeof (self) __weak weakSelf = self;
    RETableViewItem *buttonItem = [RETableViewItem itemWithTitle:@"查询" accessoryType:UITableViewCellAccessoryNone selectionHandler:^(RETableViewItem *item) {
        //item.title = @"Pressed!";
        
        // 读取item数据
        RETextItem *IDCarditem = weakSelf.searchSection.items[0];
        
        if (IDCarditem.value) {
            // 查询数据
            [weakSelf getIDCardData:IDCarditem.value];
            [MBProgressHUD showMessage:@"查询中..."];
        }
        
        // item取消选择
        [item deselectRowAnimated:UITableViewRowAnimationAutomatic];
    }];
    buttonItem.textAlignment = NSTextAlignmentCenter;
    [section addItem:buttonItem];
    
}

// 查询数据
- (void)getIDCardData:(NSString *)IDCard
{

    [ZTHTTPTools getInfoWithIDCard:IDCard success:^(id json) {

        NSDictionary *dic = json;
        NSNumber *msg = dic[@"msg"];
        
        // 清除所有items
        [self.resultSection removeAllItems];
        
        // 是否成功
        if (!msg) {
            // 生日
            WBSubtitleItem *item = [WBSubtitleItem itemWithTitle:@"生日:" rightSubtitle:dic[@"birth"]];
            [self.resultSection addItem:item];
            
            // 性别
//            NSNumber *sex = dic[@"sex"];
//            NSString *sexstr = sex.integerValue ? @"男":@"女";
            item = [WBSubtitleItem itemWithTitle:@"性别:" rightSubtitle:dic[@"sex"]];
            [self.resultSection addItem:item];
            
            // 地区
            item = [WBSubtitleItem itemWithTitle:@"地区:" rightSubtitle:dic[@"address"]];
            [self.resultSection addItem:item];
            
        } else {
            [self.resultSection addItem:[RETableViewItem itemWithTitle:@"查询失败，身份证号码输入错误！"]];
        }
        
        // 重新加载section
        [self.resultSection reloadSectionWithAnimation:UITableViewRowAnimationAutomatic];
        
        [MBProgressHUD hideHUD];
    } faild:^(NSError *error) {
        
        [MBProgressHUD hideHUD];
    } ];
     
    
}

- (void)dealloc
{
    NSLog(@"IDCardsSearchController dealloc");
}







@end
