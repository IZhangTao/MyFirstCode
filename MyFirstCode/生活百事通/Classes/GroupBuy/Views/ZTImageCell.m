//
//  ZTImageCell.m
//  生活百事通
//
//  Created by zhangtao on 15/12/8.
//  Copyright © 2015年 张涛. All rights reserved.
//

#import "ZTImageCell.h"
#import "UIImageView+WebCache.h"

@interface ZTImageCell()

@property (strong, readwrite, nonatomic) UIImageView *pictureView;
@property (nonatomic, strong) UIImageView *freeBookImage;

@end


#define kImageViewH 160
@implementation ZTImageCell

+ (CGFloat)heightWithItem:(NSObject *)item tableViewManager:(RETableViewManager *)tableViewManager
{
    //KLLog(@"%@",item);
    return kImageViewH;
}

- (void)cellDidLoad
{
    [super cellDidLoad];
    
    self.pictureView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kImageViewH)];
    
    NSLog(@"%f",self.frame.size.width);
   self.pictureView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    [self addSubview:self.pictureView];
    
    // 添加免预约
    UIImageView *freeBookImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"icon_deal_nobooking"]];
    [self addSubview:freeBookImage];
    freeBookImage.hidden = YES;
    self.freeBookImage = freeBookImage;
}

- (void)cellWillAppear
{
    [super cellWillAppear];
    if (self.item.imageName) {
        [self.pictureView setImage:[UIImage imageNamed:self.item.imageName]];
    } else {
        [self.pictureView sd_setImageWithURL:[NSURL URLWithString:self.item.imageUrl] placeholderImage:[UIImage imageNamed:@"bg_hotTopic_default"]];
    }
    
    self.freeBookImage.hidden = self.item.isReservation;
}

- (void)cellDidDisappear
{
    
}



@end
