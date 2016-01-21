//
//  FangResultViewController.m
//  FangDaiDemo
//
//  Created by baiteng-5 on 14-1-17.
//  Copyright (c) 2014年 org.baiteng. All rights reserved.
//

#import "FangResultViewController.h"

@interface FangResultViewController ()

@property (nonatomic, retain) UIScrollView * coverScrollview;//背景滚动视图
@property (nonatomic, retain) UIView * btnView;//按钮容器
@property (nonatomic, retain) ExpendTableView * expendView;//可展开列表
@property (nonatomic, retain) UIButton * expendBtn;

@end

@implementation FangResultViewController
@synthesize xianType;
@synthesize coverScrollview;
@synthesize oneTableView;
@synthesize btnView;
@synthesize expendView;
@synthesize expendBtn;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    
    self.view.backgroundColor = ZTCollectionBkgCollor;
    
    //添加背景滚动视图
    coverScrollview = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    coverScrollview.backgroundColor = [UIColor clearColor];
    coverScrollview.contentSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height-44);
    [self.view addSubview:coverScrollview];
    
    //判断加载类型
    if ([xianType isEqualToString:@"1"]) {
        [self addViewOne];
    }
    if ([xianType isEqualToString:@"2"]) {
        [self addViewTwo];
    }
}

-(void)addViewOne
{
    //添加列表
    oneTableView = [[UITableView alloc]initWithFrame:CGRectMake(10, 10, self.view.frame.size.width - 20, self.nameArray_1.count*38+30) style:UITableViewStyleGrouped];
    oneTableView.backgroundView.alpha = 0;
    oneTableView.dataSource = self;
    oneTableView.delegate = self;
    oneTableView.scrollEnabled = NO;
    [coverScrollview addSubview:oneTableView];
    //添加按钮视图
    btnView = [[UIView alloc]initWithFrame:CGRectMake(0, oneTableView.frame.origin.y+oneTableView.frame.size.height, 320, 100)];
    btnView.backgroundColor = [UIColor clearColor];
    //标题1
    UILabel * label_1 = [[UILabel alloc]initWithFrame:CGRectMake(20, 3, self.view.frame.size.width -20, 20)];
    label_1.backgroundColor = [UIColor clearColor];
    label_1.font = [UIFont systemFontOfSize:14];
    label_1.textColor = [UIColor grayColor];
    label_1.text = @"以上结果仅供参考。";
    [btnView addSubview:label_1];
    //标题2
    UILabel * label_2 = [[UILabel alloc]initWithFrame:CGRectMake(20, 25, self.view.frame.size.width -20, 20)];
    label_2.backgroundColor = [UIColor clearColor];
    label_2.font = [UIFont systemFontOfSize:14];
    label_2.textColor = [UIColor grayColor];
    label_2.text = @"房产计算结果最终以实际交易金额为准。";
    [btnView addSubview:label_2];
    //分割线
    UIImageView * lineImg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 48, self.view.frame.size.width, 8)];
    lineImg.image = [UIImage imageNamed:@"line02.png"];
    [btnView addSubview:lineImg];
    
    [coverScrollview addSubview:btnView];
    //判断滚动范伟
    int a = self.view.frame.size.height-44;
    int b = self.nameArray_1.count*38+160;
    if (b>a) {
        coverScrollview.contentSize = CGSizeMake(self.view.frame.size.width -20, b+50);
    }
}

#pragma mark -------Tab Dele-------
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.nameArray_1.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 38;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * CellWithIdentifier = @"Cell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:CellWithIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellWithIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    while (cell.contentView.subviews.lastObject) {
        [cell.contentView.subviews.lastObject removeFromSuperview];
    }
    
    NSUInteger row = [indexPath row];
    //名称栏
    UILabel * name = [[UILabel alloc]initWithFrame:CGRectMake(10, 9, 100, 20)];
    name.backgroundColor = [UIColor clearColor];
    name.text = [self.nameArray_1 objectAtIndex:row];
    name.font = [UIFont systemFontOfSize:18];
    [cell.contentView addSubview:name];
    //数据栏
    UILabel * data = [[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width-200-30, 10, 200, 18)];
    data.backgroundColor = [UIColor clearColor];
    data.text = [self.dataArray_1 objectAtIndex:row];
    data.font = [UIFont systemFontOfSize:16];
    data.textAlignment = NSTextAlignmentRight;
    data.textColor = [UIColor blueColor];
    [cell.contentView addSubview:data];
    
    return cell;
}

-(void)addViewTwo
{
    
    //添加列表
    oneTableView = [[UITableView alloc]initWithFrame:CGRectMake(10, 10, self.view.frame.size.width -20, self.nameArray_1.count*38+30) style:UITableViewStyleGrouped];
    oneTableView.backgroundView.alpha = 0;
    oneTableView.dataSource = self;
    oneTableView.delegate = self;
    oneTableView.scrollEnabled = NO;
    [coverScrollview addSubview:oneTableView];
    //展开按钮
    UILabel * btnLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, oneTableView.frame.origin.y+oneTableView.frame.size.height, 200, 18)];
    btnLabel.backgroundColor = [UIColor clearColor];
    btnLabel.text = @"月均还款";
    btnLabel.textColor = [UIColor grayColor];
    btnLabel.font = [UIFont systemFontOfSize:15];
    [coverScrollview addSubview:btnLabel];
    expendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    expendBtn.frame = CGRectMake(15, btnLabel.frame.origin.y+btnLabel.frame.size.height+5, 290, 38);
    [expendBtn setImage:[UIImage imageNamed:@"expend.png"] forState:UIControlStateNormal];
    [coverScrollview addSubview:expendBtn];
    UILabel * btnLabel2 = [[UILabel alloc]initWithFrame:CGRectMake(15, 10, 200, 18)];
    btnLabel2.backgroundColor = [UIColor clearColor];
    btnLabel2.text = @"月均还款";
    btnLabel2.font = [UIFont systemFontOfSize:16];
    [expendBtn addSubview:btnLabel2];
    //添加可展开列表
    expendView = [[ExpendTableView alloc]initWithFrame:CGRectMake(0, btnLabel.frame.origin.y+btnLabel.frame.size.height-10, 320, self.nameArray_2.count*38+30)];

    expendView.expendTab.frame = CGRectMake(10, 10, 300, self.nameArray_2.count*38+30);
    expendView.backgroundColor = [UIColor clearColor];
    expendView.hidden = YES;
    expendView.nameAry = self.nameArray_2;
    expendView.dataAry = self.dataArray_2;
    [coverScrollview addSubview:expendView];
    //添加按钮视图
    btnView = [[UIView alloc]initWithFrame:CGRectMake(0, expendBtn.frame.origin.y+expendBtn.frame.size.height+15, 320, 100)];
    btnView.backgroundColor = [UIColor clearColor];
    //标题1
    UILabel * label_1 = [[UILabel alloc]initWithFrame:CGRectMake(20, 3, self.view.frame.size.width -20, 20)];
    label_1.backgroundColor = [UIColor clearColor];
    label_1.font = [UIFont systemFontOfSize:14];
    label_1.textColor = [UIColor grayColor];
    label_1.text = @"以上结果仅供参考。";
    [btnView addSubview:label_1];
    //标题2
    UILabel * label_2 = [[UILabel alloc]initWithFrame:CGRectMake(20, 25, self.view.frame.size.width -20, 20)];
    label_2.backgroundColor = [UIColor clearColor];
    label_2.font = [UIFont systemFontOfSize:14];
    label_2.textColor = [UIColor grayColor];
    label_2.text = @"房产计算结果最终以实际交易金额为准。";
    [btnView addSubview:label_2];
    //分割线
    UIImageView * lineImg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 48, self.view.frame.size.width, 8)];
    lineImg.image = [UIImage imageNamed:@"line02.png"];
    [btnView addSubview:lineImg];
    
    [coverScrollview addSubview:btnView];
    //判断滚动范伟
    coverScrollview.contentSize = CGSizeMake(self.view.frame.size.width -20, 500);
}

-(void)backAction:(UIButton *)btn
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
