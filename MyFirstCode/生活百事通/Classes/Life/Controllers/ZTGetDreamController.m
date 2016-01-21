//
//  ZTGetDreamController.m
//  生活百事通
//
//  Created by 张涛 on 15/4/27.
//  Copyright (c) 2015年 张涛. All rights reserved.
//

#import "ZTGetDreamController.h"
#import "RETableViewManager.h"

#import "MBProgressHUD+ZT.h"
#import "ZTHTTPTools.h"
#import "MultilineTextItem.h"
@interface ZTGetDreamController ()

@property (nonatomic ,strong) RETableViewManager *manager;
@property (nonatomic ,strong) RETextItem        *textItem;
@property (nonatomic ,strong) RETableViewSection *resultSection;

@end

@implementation ZTGetDreamController

- (instancetype)init
{
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"周公解梦";
    RETableViewManager *manager = [[RETableViewManager alloc]initWithTableView:self.tableView];
    self.manager = manager;
    
    [self addSeachSection];
    [self addResultSection];
    [self addBtbItem];
}

- (void)addSeachSection
{
    UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"a6"]];
    imageView.contentMode = UIViewContentModeCenter;
    imageView.frame = CGRectMake(0, 0, self.view.frame.size.width, 100);
    
    RETableViewSection *section = [RETableViewSection sectionWithHeaderView:imageView];
    
    section.footerTitle = @"目前最完善的周公解梦数据！大约收录梦境关键词数据4500多条，并且结合现代梦境的解释含义，权威精准又富有娱乐性!";
    [self.manager addSection:section];
    
    RETextItem *item = [RETextItem itemWithTitle:@"梦：" value:nil placeholder:@"请输入梦的相关信息"];
    [section addItem:item];
    self.textItem = item;
    
}
- (void)addResultSection{
    RETableViewSection *section = [RETableViewSection sectionWithHeaderTitle:@"梦寓意"];
    self.resultSection = section;
    [self.manager addSection:section];
}
- (void)addBtbItem{
    
    RETableViewSection *section = [RETableViewSection section];
    [self.manager addSection:section];
   
     __weak __typeof(self)weakSelf = self;
    
    RETableViewItem *btnItem = [RETableViewItem itemWithTitle:@"查询" accessoryType:UITableViewCellAccessoryNone selectionHandler:^(RETableViewItem *item) {
        
        if (weakSelf.textItem.value) {
            [weakSelf getDream:weakSelf.textItem.value];
            
            [MBProgressHUD showMessage:@"正在查询。。。"];
        }
        [item deselectRowAnimated:UITableViewRowAnimationAutomatic];
        
    }];
    
    btnItem.textAlignment = NSTextAlignmentCenter;
    [section addItem:btnItem];
}

- (void)getDream:(NSString *)dream
{
    [ZTHTTPTools getInfoWithDream:dream success:^(id json) {
        NSDictionary *dic =json;
        
        // 清除所有items
        [self.resultSection removeAllItems];
        
        if ([dic[@"error_code"] integerValue] == 0) {
            NSLog(@"----->%@",dic[@"result"]);
            NSArray *arr = dic[@"result"];
            NSInteger count = arr.count;
            
            for (NSInteger i = 0; i < count; i ++) {
                
                MultilineTextItem *item = [MultilineTextItem itemWithTitle:arr[i][@"list"] fontSzie:13];
             
                [self.resultSection addItem:item];
            }
            
        }else{
            [self.resultSection addItem:[RETableViewItem itemWithTitle:@"加载失败,只支持中文查找"]];
        }
        [self.resultSection reloadSectionWithAnimation:UITableViewRowAnimationAutomatic];
        [MBProgressHUD hideHUD];
    } faild:^(NSError *error) {
        [MBProgressHUD hideHUD];
    }];
}
-(void)dealloc
{
    NSLog(@"----->ZTGetDreamController");
}

@end
