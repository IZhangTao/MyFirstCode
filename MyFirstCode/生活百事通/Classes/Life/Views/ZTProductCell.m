//
//  ZTProductCell.m
//  生活百事通
//
//  Created by 张涛 on 15/4/23.
//  Copyright (c) 2015年 张涛. All rights reserved.
//

#import "ZTProductCell.h"
#import "ZTItem.h"
@interface ZTProductCell ()

@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *titleLable;

@end

@implementation ZTProductCell

- (void)awakeFromNib {
    self.iconView.layer.cornerRadius = 8;
    self.iconView.clipsToBounds = YES;
    
    self.backgroundColor = [UIColor clearColor];
    
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}

- (void)setItem:(ZTItem *)item
{
    _item = item;
    self.userInteractionEnabled = YES;
    self.iconView.image = [UIImage imageNamed:item.imageName];
    self.titleLable.text = item.title;
    
}
@end
