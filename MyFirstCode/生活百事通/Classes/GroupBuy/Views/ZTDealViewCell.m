//
//  ZTDealViewCell.m
//  生活百事通
//
//  Created by zhangtao on 15/11/25.
//  Copyright (c) 2015年 张涛. All rights reserved.
//

#import "ZTDealViewCell.h"
#import "ZTDeal.h"
#import "ZTLineLable.h"
#import "UIImageView+WebCache.h"

@implementation ZTDealViewCell

- (void)setDeal:(ZTDeal *)deal
{
    _deal = deal;
    
    // 标题
    self.titleLable.text = deal.title;
    
    // 描述
    self.descLable.text = deal.desc;
    
    // 图片
    [self.image sd_setImageWithURL:[NSURL URLWithString:deal.s_image_url] placeholderImage:[UIImage imageNamed:@"placeholder_deal"] options:SDWebImageLowPriority | SDWebImageRetryFailed];
    
    // 价格
    self.priceLable.text = deal.current_price_text;
    
    // 原价
    self.originalPriceLable.text = [NSString stringWithFormat:@"%@元",deal.list_price_text];
    
    // 销售
    self.buycountLable.text = [NSString stringWithFormat:@"已销售:%d",deal.purchase_count];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
