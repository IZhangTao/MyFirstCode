//
//  ZTImageCell.h
//  生活百事通
//
//  Created by zhangtao on 15/12/8.
//  Copyright © 2015年 张涛. All rights reserved.
//

#import "RETableViewCell.h"
#import "ZTImageItem.h"

@interface ZTImageCell : RETableViewCell
@property (strong, readonly, nonatomic) UIImageView *pictureView;
@property (strong, readwrite, nonatomic) ZTImageItem *item;

@end
