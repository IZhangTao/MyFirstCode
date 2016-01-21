//
//  ZTGetMoneyController.m
//  生活百事通
//
//  Created by 张涛 on 15/4/27.
//  Copyright (c) 2015年 张涛. All rights reserved.
//

#import "ZTGetMoneyController.h"
#import "MBProgressHUD+ZT.h"
#import "ZTHTTPTools.h"
#import "RETableViewManager.h"
#import "RETableViewOptionsController.h"
#import "NSString+ZT.h"

@interface ZTGetMoneyController ()
@property (nonatomic ,strong) NSArray *array;
@property (nonatomic ,strong) RETableViewManager *manager;
@property (nonatomic ,strong) RETableViewSection *seachSection;
@property (nonatomic, strong) RETableViewSection *resultSection;

@property (nonatomic ,strong) RERadioItem *from;
@property (nonatomic ,strong) RERadioItem *to;
@property (nonatomic ,strong) RETextItem *number;

@end

@implementation ZTGetMoneyController
- (instancetype)init
{
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"各国货币汇率查询";
    self.manager = [[RETableViewManager alloc]initWithTableView:self.tableView];
    
    self.manager.style.cellHeight = 44;
    
    [self addSeachSection];
    [self addResultSection];
    [self addBtn];
}
- (void)addSeachSection
{
     __weak __typeof(self)weakSelf = self;
    UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"a7"]];
    imageView.contentMode = UIViewContentModeCenter;
    imageView.frame = CGRectMake(0, 0, self.view.frame.size.width, 100);
    
    RETableViewSection *section = [RETableViewSection sectionWithHeaderView:imageView];
    section.footerTitle = @"强大的货币汇率!包括人民币汇率、美元汇率、欧元汇率、港币汇率、英镑汇率等多个国家和地区货币汇率换算。实时汇率换算查询，货币汇率自动按国际换汇牌价进行调整。";
  
    RERadioItem *from = [weakSelf createSwapOutInItemWithTitle:@"原始货币:" value:@"CNY - 人民币"];
    [section addItem:from];
    self.from = from;
    
    RERadioItem *to = [weakSelf createSwapOutInItemWithTitle:@"目标货币:" value:@"USD - 美元"];
    [section addItem:to];
    self.to = to;

    RETextItem *number = [RETextItem itemWithTitle:@"兑换金额" value:nil placeholder:@"请输入兑换的金额"];
    number.keyboardType = UIKeyboardTypeNumberPad;
    [section addItem:number];
    self.number = number;
    
    [self.manager addSection:section];
}

- (RERadioItem *)createSwapOutInItemWithTitle:(NSString *)title value:(NSString *)value
{
     __typeof (self) __weak weakSelf = self;
    RERadioItem *radioItem = [RERadioItem itemWithTitle:title value:value selectionHandler:^(RERadioItem *item) {

        RETableViewOptionsController *optionsController = [[RETableViewOptionsController alloc]initWithItem:item options:weakSelf.array multipleChoice:NO completionHandler:^(RETableViewItem *selectedItem) {
            
            [weakSelf.navigationController popViewControllerAnimated:YES];
            
            [item reloadRowWithAnimation:UITableViewRowAnimationNone];
        }];
        
        [weakSelf.navigationController pushViewController:optionsController animated:YES];
    }];

    return radioItem;
}


// 添加第二个组 结果
- (void)addResultSection
{
    RETableViewSection *section = [RETableViewSection sectionWithHeaderTitle:@"查询结果:"];
    [self.manager addSection:section];
    self.resultSection = section;
}

//查询按钮
- (void)addBtn
{
     __weak __typeof(self)weakSelf = self;
    RETableViewSection *section = [RETableViewSection section];
    [self.manager addSection:section];
    
    RETableViewItem *btnItem = [RETableViewItem itemWithTitle:@"查询" accessoryType:UITableViewCellAccessoryNone selectionHandler:^(RETableViewItem *item) {
        
        if (weakSelf.number.value) {
            
            [weakSelf getMoneyFrom:[weakSelf.from.value substringToIndex:3] to:[weakSelf.to.value substringToIndex:3]];
            [MBProgressHUD showMessage:@"查询中。。。"];
         }
        [item deselectRowAnimated:UITableViewRowAnimationAutomatic];

    }];
    btnItem.textAlignment = NSTextAlignmentCenter;
    [section addItem:btnItem];

}
/*
    result = 0.1611;
	currencyFD = 1;
	updateTime = 2015-05-06 00:04:59;
	currencyT_Name = 美元;
	currencyF = CNY;
	exchange = 0.161139579103419;
	currencyF_Name = 人民币;
	currencyT = USD;
 */
- (void)getMoneyFrom:(NSString *)from to:(NSString *)to
{
    
    [ZTHTTPTools getMoneyFrom:from toRate:to success:^(id json) {
        
       NSLog(@"----->%@",json);
        NSDictionary *dic = json;
        NSNumber *error = dic[@"error_code"];
        
        // 清除所有items
        [self.resultSection removeAllItems];
        
        // 是否成功
        if (error.integerValue == 0) {
            NSDictionary *result = dic[@"result"][0];
            // 添加item
            // from货币
            [self.resultSection addItem:[WBSubtitleItem itemWithTitle:result[@"currencyF_Name"] rightSubtitle:self.number.value ]];
            // 当前汇率
            [self.resultSection addItem:[WBSubtitleItem itemWithTitle:@"当前汇率" rightSubtitle:result[@"exchange"]]];
            
            // to货币
            double toNumber = [self.number.value doubleValue] * [result[@"exchange"] doubleValue];
            [self.resultSection addItem:[WBSubtitleItem itemWithTitle:result[@"currencyT_Name"] rightSubtitle:[NSString stringWithDouble:toNumber fractionCount:3]]];
            
            // 当前汇率更新日期
            [self.resultSection addItem:[WBSubtitleItem itemWithTitle:@"汇率更新日期" rightSubtitle:result[@"updateTime"]]];
            
        } else {
            // 查询失败
            [self.resultSection addItem:[RETableViewItem itemWithTitle:@"查询失败,输入是否正确"]];
        }
        
        // 重新加载section
        [self.resultSection reloadSectionWithAnimation:UITableViewRowAnimationAutomatic];
        
        [MBProgressHUD hideHUD];
    } faild:^(NSError *error) {
        [MBProgressHUD hideHUD];
    }];
    
}

- (NSString *)changeFloat:(NSString *)stringFloat
{
    const char *floatChars = [stringFloat UTF8String];
    NSUInteger length = [stringFloat length];
    NSUInteger zeroLength = 0;
    int i = length-1;
    for(; i>=0; i--)
    {
        if(floatChars[i] == '0'/*0x30*/) {
            zeroLength++;
        } else {
            if(floatChars[i] == '.')
                i--;
            break;
        }
    }
    NSString *returnString;
    if(i == -1) {
        returnString = @"0";
    } else {
        returnString = [stringFloat substringToIndex:i+1];
    }
    return returnString;
}


/**
 *  reaudio选择数组
 */
-(NSArray *)array
{
    if (!_array) {
        _array = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"Currency.plist" ofType:nil]];
        NSLog(@"排序前---->%@",_array);
        //排序
        _array = [_array sortedArrayUsingSelector:@selector(compare:)];
        NSLog(@"排序后---->%@",_array);
    }
    return _array;
}
















@end
