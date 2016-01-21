//
//  UIImage+ZTException.h
//  生活百事通
//
//  Created by 张涛 on 15/4/24.
//  Copyright (c) 2015年 张涛. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (ZTException)

/**
 *  设置拉伸图片（默认中线拉伸）
 */
+ (UIImage *)resizedImageWithName:(NSString *)name;
/**
 *  设置拉伸图片（并设置拉伸值）
 */
+ (UIImage *)resizedImageWithName:(NSString *)name left:(CGFloat)left top:(CGFloat)top;
/**
 *  根据图片设置size
 */
- (UIImage *)imageToSize:(CGSize) size;


@end
