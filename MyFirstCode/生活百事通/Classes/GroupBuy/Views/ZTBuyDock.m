//
//  ZTBuyDock.m
//  生活百事通
//
//  Created by zhangtao on 15/11/27.
//  Copyright © 2015年 张涛. All rights reserved.
//

#import "ZTBuyDock.h"
#import "UIImage+ZTException.h"

@interface ZTBuyDock()

@property (nonatomic, copy) void (^clickedHander)(void);

@end


@implementation ZTBuyDock

- (void)awakeFromNib
{
    [self.buyBtn setBackgroundImage:[UIImage resizedImageWithName:@"bg_button_pay_hl"] forState:UIControlStateNormal];
    [self.buyBtn setBackgroundImage:[UIImage resizedImageWithName:@"bg_button_pay_hl"] forState:UIControlStateHighlighted];
    self.alpha = 0.8;
}

+(instancetype)creatBuyDock
{
    return [[NSBundle mainBundle]loadNibNamed:@"ZTBuyDock" owner:self options:nil][0];
}

+ (instancetype)buyDockWithNowPrice:(NSString *)nowPrice originalPrice:(NSString *)originalPrice clickedHander:(void (^)(void))clicked
{
    ZTBuyDock *buyDock = [ZTBuyDock creatBuyDock];
    buyDock.priceLable.text = nowPrice;
//    buyDock.originalPriceLable.text = [NSString stringWithFormat:@"%@元",originalPrice];
    
    //主要这里的target 为buyDock
    [buyDock.buyBtn addTarget:buyDock action:@selector(clickedBuy) forControlEvents:UIControlEventTouchUpInside];
    
    buyDock.clickedHander = clicked;
    
    return buyDock;
}

- (void)clickedBuy
{
    if (self.clickedHander) {
        self.clickedHander();
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
//    CGSize PriceSize = [self.priceLable.text sizeWithAttributes:@{NSFontAttributeName: self.priceLable.font}];
//    CGRect PriceRect = self.priceLable.frame;
//    PriceRect.size = PriceSize;
//    self.priceLable.frame = PriceRect;
//    
//    CGRect YuanRect = self.yuanLable.frame;
//    YuanRect.origin.x = CGRectGetMaxX(PriceRect)+1;
//    //YuanRect.origin.y = PriceRect.origin.y;
//    self.yuanLable.frame = YuanRect;
//    
//    CGRect originalPriceRect = self.originalPriceLable.frame;
//    originalPriceRect.origin.x = CGRectGetMaxX(YuanRect) ;
//    self.originalPriceLable.frame = originalPriceRect;
}


@end
