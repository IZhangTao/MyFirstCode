//
//  ZTDealViewCell.h
//  生活百事通
//
//  Created by zhangtao on 15/11/25.
//  Copyright (c) 2015年 张涛. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZTDeal,ZTLineLable;

@interface ZTDealViewCell : UITableViewCell

// 图片
@property (weak, nonatomic) IBOutlet UIImageView *image;
// 标题
@property (weak, nonatomic) IBOutlet UILabel *titleLable;
// 细节
@property (weak, nonatomic) IBOutlet UILabel *descLable;
// 价格
@property (weak, nonatomic) IBOutlet UILabel *priceLable;
// 销售
@property (weak, nonatomic) IBOutlet UILabel *buycountLable;
@property (weak, nonatomic) IBOutlet UILabel *yuanLable;
// 原价
@property (weak, nonatomic) IBOutlet ZTLineLable *originalPriceLable;

@property (nonatomic, strong) ZTDeal *deal;

@end
